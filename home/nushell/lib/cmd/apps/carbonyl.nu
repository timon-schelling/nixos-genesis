def --wrapped carbonyl [...search] {
    docker run --rm -ti fathyb/carbonyl $"https://duckduckgo.com/?q=($search | str join ' ')"
}
