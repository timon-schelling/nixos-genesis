def l [] {
    ls -al | select name size mode user group modified type
}

alias goto = g
def --env g [shell?: int] {
    try {
        if ($shell == null) {
            let iselec_installed = try { iselec "[]"; true } catch { false }
            if ($iselec_installed) {
                goto (iselec $"(goto | get path | to json -r | str replace -a $"($env.HOME)" '~')" | from json).0
            } else {
                goto (goto | get path | str replace -a $"($env.HOME)" '~' | input list -i -f)
            }
        } else {
            goto $shell
        }
    }
}

def --env e [path?: path] {
    if ($path == null) {
        enter (tere)
    } else {
        enter $path
    }
}

def --env c [path?: path] {
    if ($path == null) {
        cd (tere)
    } else {
        cd $path
    }
}

def fuzzy-finder [] {3k
    rg --files | sk --preview="bat {} --color=always"
}


# TODO: add fuzzy finder capabilitys
# def ff [] {
#     let file = (fuzzy-finder)
#     cat $file
# }

# def --env ef [] {
#     let file = (fuzzy-finder)
#     if ($file != null) {
#         try {
#             enter $file
#         } catch {
#             enter ($file | path dirname)
#         }
#     }
# }

# def --env cf [] {
#     let file = (fuzzy-finder)
#     if ($file != null) {
#         try {
#             cd $file
#         } catch {
#             cd ($file | path dirname)
#         }
#     }
# }

# def hf [] {
#     let file = (fuzzy-finder)
#     if ($file != null) {
#         code $"./($file)"
#     }
# }

def --env dotfiles [] {
    enter ~/.dotfiles
    code .
}
