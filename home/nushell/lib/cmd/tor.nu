def tor-run-proxy [] {
    docker run -d --name tor-proxy -p 9150:9150 peterdavehello/tor-socks-proxy
}

def tor-remove-proxy [] {
    docker rm -f tor-proxy
}

def tor-run-browser [] {
    firefox --no-remote -P Tor
}

def tor-browser [] {
    tor-run-proxy
    tor-run-browser
    tor-remove-proxy
}
