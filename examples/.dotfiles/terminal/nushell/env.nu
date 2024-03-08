$env.ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

$env.NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'lib')
]

$env.NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

$env.GOPATH = ($env.HOME | path join '.golang')
$env.PATH = ($env.PATH | append ($env.GOPATH | path join 'bin'))
