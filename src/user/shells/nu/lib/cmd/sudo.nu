def --wrapped sudo [...rest] {
  let args = $rest | str join ' '
  ^sudo env "XDG_RUNTIME_DIR=/run/user/0" $"HOME=($env.HOME)" $"TERMINFO=($env.TERMINFO)" "DISABLE_PROMPT=TRUE" $"(which nu | get path | get 0)" --login --commands $'"($args)"'
}
