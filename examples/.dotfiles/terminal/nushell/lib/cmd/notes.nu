def "notes" [] {
    help notes
}

def "notes session" [] {
    let date = (date now | format date "%Y-%m-%d")
    mkdir $date
    cd $date
    touch notes.md
    code .
    code ./notes.md
}

def "notes push" [] {
    let date = (date now | format date "%Y-%m-%d %H:%M:%S")
    git add --all
    git commit -m "$date"
    git push
}

def "notes pull" [] {
    git pull
}
