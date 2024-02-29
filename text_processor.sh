print_usage() {
    echo "Usage: $0 [-v] [-s <A_WORD> <B_WORD>] [-r] [-l] [-u] -i <input file> -o <output file>"
    echo "Options:"
    echo "  -v             : Toggle case of text"
    echo "  -s <A_WORD> <B_WORD> : Substitute A_WORD with B_WORD"
    echo "  -r             : Reverse text lines"
    echo "  -l             : Convert text to lower case"
    echo "  -u             : Convert text to upper case"
    echo "  -i <input file> : Input file"
    echo "  -o <output file>: Output file"
    exit 1
}

reverse_text_lines() {
    tac "$1" > "$2"
}

toggle_case() {
    tr '[:lower:][:upper:]' '[:upper:][:lower:]' < "$1" > "$2"
}

substitute_words() {
    sed -e "s/$1/$2/g" "$3" > "$4"
}

convert_to_lower() {
    tr '[:upper:]' '[:lower:]' < "$1" > "$2"
}

convert_to_upper() {
    tr '[:lower:]' '[:upper:]' < "$1" > "$2"
}

while getopts ":vs:rlui:o:" opt; do
    case $opt in
        v) toggle=true ;;
        s) substitute=true
           a_word="$OPTARG"
           b_word="${*:OPTIND:1}"
           shift ;;
        r) reverse=true ;;
        l) to_lower=true ;;
        u) to_upper=true ;;
        i) input_file="$OPTARG" ;;
        o) output_file="$OPTARG" ;;
        \?) echo "Invalid option: -$OPTARG" >&2
            print_usage ;;
        :) echo "Option -$OPTARG requires an argument." >&2
            print_usage ;;
    esac
done

if [[ -z "$input_file" || -z "$output_file" ]]; then
    echo "Error: Input and output file parameters are required." >&2
    print_usage
fi

temp_file=$(mktemp)
cp "$input_file" "$temp_file"

if [ "$toggle" = true ]; then
    toggle_case "$temp_file" "$output_file"
elif [ "$substitute" = true ]; then
    substitute_words "$a_word" "$b_word" "$temp_file" "$output_file"
elif [ "$reverse" = true ]; then
    reverse_text_lines "$temp_file" "$output_file"
elif [ "$to_lower" = true ]; then
    convert_to_lower "$temp_file" "$output_file"
elif [ "$to_upper" = true ]; then
    convert_to_upper "$temp_file" "$output_file"
fi

rm "$temp_file"
echo "Output written to $output_file"
