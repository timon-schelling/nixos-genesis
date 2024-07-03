def --wrapped sudo [...rest] {
  let args = $rest | str join ' '

  mut envs = [
    "XDG_RUNTIME_DIR=/run/user/0"
    "DISABLE_PROMPT=TRUE"
  ]

  if ("HOME" in $env) {
    env = $envs ++ $"HOME=($env.HOME)"
  }
  if ( "TERM" in $env) {
    env = $envs ++ $"TERM=($env.TERM)"
  }
  if ("TERMINFO" in $env) {
    env = $envs ++ $"TERMINFO=($env.TERMINFO)"
  }
  if ("TERMINFO_DIRS" in $env) {
    env = $envs ++ $"TERMINFO_DIRS=($env.TERMINFO_DIRS)"
  }

  ^sudo env ...$envs $"(which nu | get path | get 0)" --login --commands $'"($args)"'
}
