use inquire::Select;
use serde_json::Value;

fn main() {
    let results = std::env::args()
        .skip(1)
        .map(|arg| {
            let json = serde_json::from_str(&arg);
            let options = match json {
                Ok(Value::Array(a)) => a,
                _ => panic!("Unsuported input"),
            };
            let options = options
                .iter()
                .map(Value::as_str)
                .filter_map(|e| e)
                .map(|e| e.to_string())
                .collect::<Vec<String>>();
            let ans = Select::new("", options.clone())
                .with_page_size(15)
                .without_help_message()
                .prompt();
            match ans {
                Ok(c) => options.iter().position(|e| *e == c),
                Err(_) => None,
            }
        })
        .filter_map(|e| e)
        .collect::<Vec<usize>>();

    serde_json::to_writer(std::io::stdout(), &results).unwrap();
}
