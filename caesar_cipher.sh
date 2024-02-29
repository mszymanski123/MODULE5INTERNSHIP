caesar_cipher() {
    local text="$1"
    local shift="$2"
    local encrypted=""
    local char

    for ((i = 0; i < ${#text}; i++)); do
        char="${text:i:1}"
        if [[ "$char" =~ [A-Za-z] ]]; then
            ascii_val=$(printf "%d" "'$char")
            if [[ "$char" =~ [a-z] ]]; then
                ascii_val=$((ascii_val - 97))
                ascii_val=$((ascii_val + shift))
                ascii_val=$((ascii_val % 26))
                ascii_val=$((ascii_val + 97))
            else
                ascii_val=$((ascii_val - 65))
                ascii_val=$((ascii_val + shift))
                ascii_val=$((ascii_val % 26))
                ascii_val=$((ascii_val + 65))
            fi
            char=$(printf "\$(printf '%03o' $ascii_val)")
        fi
        encrypted+="$char"
    done

    echo "$encrypted"
}

while getopts ":s:i:o:" opt; do
    case $opt in
        s) shift_amount="$OPTARG" ;;
        i) input_text="$OPTARG" ;;
        o) output_file="$OPTARG" ;;
        \?) echo "Invalid option: -$OPTARG" >&2
            exit 1 ;;
    esac
done

if [[ -z "$shift_amount" || -z "$output_file" ]]; then
    echo "Usage: $0 -s <shift> -o <output file>" >&2
    exit 1
fi

encrypted_text=$(caesar_cipher "$input_text" "$shift_amount")

echo "$encrypted_text" > "$output_file"
echo "Encrypted text has been written to '$output_file'."
