
fib() {
    local n=$1
    if [ "$n" -eq 0 ]; then
        echo 0
    elif [ "$n" -eq 1 ]; then
        echo 1
    else
        local a=0
        local b=1
        local i=2
        while [ "$i" -le "$n" ]; do
            local temp=$((a + b))
            a=$b
            b=$temp
            i=$((i + 1))
        done
        echo "$b"
    fi
}

for ((i = 0; i <= 10; i++)); do
    printf "fib(%d) = %d\n" "$i" "$(fib "$i")"
done
