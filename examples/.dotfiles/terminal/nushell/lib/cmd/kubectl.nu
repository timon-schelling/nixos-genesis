alias k = kubectl
alias kubectl-json = kubectl -o json
alias k-json = kubectl-json

def kubectl-from-json-pods-by-namespace [] {
    let input = $in

    let result = (try {
        ($input | from json).items |
        select metadata.namespace metadata.name |
        rename namespace name |
        sort-by namespace name |
        group-by namespace |
        transpose namespace pods |
        update pods { |it|
            ($it.pods | each { |it|
                $"($it | get name)"
            })
        }
    } catch { |e|
        print $input
        print $e
    })

    def flattern_namespaces [] {
        let input = $in
        mut namespaces = {}
        for it in $input {
            $namespaces = ($namespaces | insert $it.namespace $it.pods)
        }
        $namespaces
    }

    $result | flattern_namespaces
}

def kubectl-from-json-pods-by-node [] {
    let input = $in

    let result = (try {
        ($input | from json).items |
        select spec.nodeName metadata.namespace metadata.name |
        rename node namespace name |
        sort-by node namespace name |
        update node {
            |row| ($row.node | split row "." | get 0)
        } |
        group-by node |
        transpose node pods |
        update pods { |it|
            ($it.pods | each { |it|
                $"($it | get namespace)/($it | get name)"
            })
        }
    } catch { |e|
        print $input
        print $e
    })

    def flattern_nodes [] {
        let input = $in
        mut nodes = {}
        for it in $input {
            $nodes = ($nodes | insert $it.node $it.pods)
        }
        $nodes
    }

    $result | flattern_nodes
}

def kubectl-from-json-pods-by-namespace-by-node [] {
    let input = $in

    let result = (try {
        ($input | from json).items |
        select metadata.namespace spec.nodeName metadata.name |
        rename namespace node name |
        sort-by namespace node name |
        update node {
            |row| ($row.node | split row "." | get 0)
        } |
        group-by namespace |
        transpose namespace pods |
        update pods { |it|
            $it.pods | group-by node | rotate | rename pods node | move pods --after node | update pods { |it|
                ($it.pods | each { |it|
                    $it | get name
                })
            }
        }
    } catch { |e|
        print $input
        print $e
    })

    def flattern_nodes [] {
        let input = $in
        mut nodes = {}
        for it in $input {
            $nodes = ($nodes | insert $it.node $it.pods)
        }
        $nodes
    }

    def flattern_namespaces [] {
        let input = $in
        mut namespaces = {}
        for it in $input {
            $namespaces = ($namespaces | insert $it.namespace ($it.pods | flattern_nodes))
        }
        $namespaces
    }

    $result | flattern_namespaces
}

def kubectl-from-json-pods-by-node-by-namespace [] {
    let input = $in

    let result = (try {
        ($input | from json).items |
        select spec.nodeName metadata.namespace metadata.name |
        rename node namespace name |
        sort-by node namespace name |
        update node {
            |row| ($row.node | split row "." | get 0)
        } |
        group-by node |
        transpose node pods |
        update pods { |it|
            $it.pods | group-by namespace | rotate | rename pods namespace | move pods --after namespace | update pods { |it|
                ($it.pods | each { |it|
                    $it | get name
                })
            }
        }
    } catch { |e|
        print $input
        print $e
    })

    def flattern_namespaces [] {
        let input = $in
        mut namespaces = {}
        for it in $input {
            $namespaces = ($namespaces | insert $it.namespace $it.pods)
        }
        $namespaces
    }

    def flattern_nodes [] {
        let input = $in
        mut nodes = {}
        for it in $input {
            $nodes = ($nodes | insert $it.node ($it.pods | flattern_namespaces))
        }
        $nodes
    }

    $result | flattern_nodes
}
