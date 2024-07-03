def --wrapped sudo [...rest] {
  let args = $rest | str join ' '

  let copys = [
    "HOME"
    "TERM"
    "TERMINFO"
    "TERMINFO_DIRS"
  ] | each { |x|
    if ($x in $env) {
      $"($x)=($env | get $x)"
    } else {
      ""
    }
  } | filter { |x| $x != "" }

  mut envs = [
    "XDG_RUNTIME_DIR=/run/user/0"
    "DISABLE_PROMPT=TRUE"
  ] ++ $copys

  ^sudo env ...$envs $"(which nu | get path | get 0)" --login --commands $'"($args)"'
}
