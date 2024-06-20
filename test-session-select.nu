let sessions = '[{"name":"session1","command":"start-session-1"}]' | from json
let sessions_number = $sessions | length

if ($sessions_number == 0) {
  echo "No sessions available"
  exit 1
}

let selection = (
  if ($sessions_number == 1) {
    0
  } else {
    $sessions | get name | input list -i -f "Select a session"
  }
)

if ($selection == null) {
  echo "No session selected"
  exit 0
}

let command = $sessions | get $selection | get command
^($command)
