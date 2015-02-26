run_tests() {
    for test in $@; do
        output=$("$test")
        if [[ $? -eq 0 ]]; then
            printf "."
        else
            echo
            printf "Error in \"%s\": %s\n" "$test" "$output"
            exit 1
        fi
    done
    echo
    echo "All good :)"
}
