use std::{env, fmt::Display, fs, io, path::PathBuf, vec};

use regex::Regex;
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Clone, Debug)]
struct Patches {
    path: Option<String>,
    paths: Option<Vec<String>>,
    replace: Option<Vec<Option<Replace>>>,
    prepend: Option<String>,
    append: Option<String>,
}

#[derive(Serialize, Deserialize, Clone, Debug)]
struct Replace {
    regex: Option<String>,
    sub: Option<String>,
}

enum ErrorKind {
    FileRead,
    ParsingRegex,
}

struct Error {
    path: PathBuf,
    kind: ErrorKind,
    msg: String,
}

impl Error {
    fn new(path: PathBuf, kind: ErrorKind, msg: Box<dyn Display>) -> Self {
        Self {
            path,
            kind,
            msg: format!("{}", msg),
        }
    }

    fn print(&self) {
        println!("{}", self);
    }
}

impl Display for Error {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        let path = self
            .path
            .to_str()
            .unwrap_or_else(|| "Invalid UTF-8 in path");

        let kind = match self.kind {
            ErrorKind::FileRead => "Error reading file",
            ErrorKind::ParsingRegex => "Error parsing regex",
        };

        write!(f, "[{}]({}): {}", path, kind, self.msg)
    }
}

fn main() {
    let input = env::args().nth(1).unwrap_or("-".to_string());

    let mut patch_source: Box<dyn io::Read> = match input.as_str() {
        "-" => Box::new(io::stdin()),
        _ => Box::new(fs::File::open(input).unwrap()),
    };

    let mut patch_bin = Vec::<u8>::new();

    patch_source
        .read_to_end(&mut patch_bin)
        .expect("Failed to read patch source");

    let patch_str = String::from_utf8(patch_bin).expect("Failed to parse patch source as UTF-8");

    serde_yaml::Deserializer::from_str(&patch_str)
        .map(Patches::deserialize)
        .filter_map(|f| f.ok())
        .for_each(|f| {
            let paths = match (f.path, f.paths) {
                (Some(p), Some(mut ps)) => {
                    let mut paths = vec![p];
                    paths.append(&mut ps);
                    paths
                }
                (Some(p), None) => vec![p],
                (None, Some(ps)) => ps,
                (None, None) => return,
            };

            paths
                .into_iter()
                .map(|regex| match glob::glob(&regex) {
                    Ok(g) => Some(
                        g.into_iter()
                            .filter_map(|p| p.ok())
                            .collect::<Vec<PathBuf>>(),
                    ),
                    Err(_) => None,
                })
                .filter(|g| g.is_some())
                .flatten()
                .flatten()
                .for_each(|path| {
                    let path = PathBuf::from(path);

                    let mut content = match fs::read_to_string(&path) {
                        Ok(c) => c,
                        Err(e) => {
                            Error::new(path, ErrorKind::FileRead, Box::new(e)).print();
                            return;
                        }
                    };

                    if let Some(patches) = f.replace.clone() {
                        patches.into_iter().filter_map(|p| p).for_each(|p| {
                            let regex = match p.regex {
                                Some(r) => r,
                                None => return,
                            };
                            let sub = match p.sub {
                                Some(s) => s,
                                None => return,
                            };

                            let re = match Regex::new(&regex) {
                                Ok(r) => r,
                                Err(e) => {
                                    Error::new(path.clone(), ErrorKind::ParsingRegex, Box::new(e))
                                        .print();
                                    return;
                                }
                            };

                            content = re.replace_all(&content, &sub).to_string();
                        });
                    }

                    content = match f.prepend.clone() {
                        Some(p) => format!("{}{}", p, content),
                        None => content,
                    };

                    content = match f.append.clone() {
                        Some(a) => format!("{}{}", content, a),
                        None => content,
                    };

                    match fs::write(&path, content) {
                        Ok(_) => (),
                        Err(e) => Error::new(path, ErrorKind::FileRead, Box::new(e)).print(),
                    };
                });
        });
}
