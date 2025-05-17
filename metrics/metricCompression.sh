#!/bin/bash

# Function to generate random string
generate_random_string()
{
    local length=$1
    local acquire=$(($1 * 8))
    head -c "$acquire" /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w "$length" | head -n 1
}

generate_from_input()
{
    local length=$1
    cat "./source.txt" | tr -d '\t\n\v\f\r ' | fold -w "$length" | head -n 1
}

get_length()
{
    local cmpr=$1
    local data=$2
    local compress_length=$(curl -s -d "cmpr=${cmpr}&enc=URI-B64&data=${data}" -H "Content-Type: application/x-www-form-urlencoded" -X POST http://tools.snailien.net/URI-Compressor/api/api.php | jq -r '.length')
    echo "$compress_length"
}

pick_compressor() {
    array=("LZMA2" "ZLIB")
    random_element=$(printf "%s\n" "${array[@]}" | shuf -n 1)
    echo "$random_element"
}

# Main loop

#LZMA2
for i in {1..3500}; do
    random_string=$(generate_from_input "$i")

    #random_compressor=$(pick_compressor)
    random_compressor="LZMA2"

    result=$(get_length "$random_compressor" "$random_string")

    echo -en "[$i\t/\t3500]\n"
    echo -en "$i,$random_compressor,$result\n" >> ./result.lzma2.csv
done

#ZLIB
for i in {1..3500}; do
    random_string=$(generate_from_input "$i")

    #random_compressor=$(pick_compressor)
    random_compressor="ZLIB"

    result=$(get_length "$random_compressor" "$random_string")

    echo -en "[$i\t/\t3500]\n"
    echo -en "$i,$random_compressor,$result\n" >> ./result.zlib.csv
done

echo "Test completed."