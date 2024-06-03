def --wrapped sudo [...rest] {
  let escaped_args = $rest
    | range 1..
    | each { || to nuon }
    | str join ' '
  ^sudo env XDG_RUNTIME_DIR=/run/user/0 $"HOME=($env.HOME)" $"(which nu | get path | get 0)" --login --commands $'($rest.0) ($escaped_args)'
}
