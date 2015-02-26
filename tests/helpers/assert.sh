assert_equal() {
    expected=$1
    actual=$2

    if [[ "${expected}" != "${actual}" ]]; then
        echo "Expected \"${expected}\" but was \"${actual}\""
        return 1
    fi
}
