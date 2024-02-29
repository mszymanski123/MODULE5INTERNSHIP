
print_debug_info() {
    echo "User: $USER"
    echo "Script: $0"
    echo "Operation: $operation"
    echo "Numbers:" "${numbers[@]}"
}

perform_operation() {
    local result
    case "$operation" in
        "+") result=$(echo "${numbers[@]}" | tr ' ' '+' | bc) ;;
        "-") result=${numbers[0]}
             for ((i = 1; i < ${#numbers[@]}; i++)); do
                 result=$((result - numbers[i]))
             done ;;
        "*") result=1
             for num in "${numbers[@]}"; do
                 result=$((result * num))
             done ;;
        "%") result=${numbers[0]}
             for ((i = 1; i < ${#numbers[@]}; i++)); do
                 result=$((result % numbers[i]))
             done ;;
        *)   echo "Error: Invalid operation '$operation'" >&2
             exit 1 ;;
    esac
    echo "Result: $result"
}

while getopts ":o:n:d" opt; do
    case $opt in
        o) operation="$OPTARG" ;;
        n) numbers=("$@") ;;
        d) debug=true ;;
        \?) echo "Invalid option: -$OPTARG" >&2
            exit 1 ;;
    esac
done

shift "$((OPTIND - 1))"

if [ "$debug" = true ]; then
    print_debug_info
fi

perform_operation

