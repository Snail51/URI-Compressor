#!/bin/bash

# Function to generate random string
generate_random_string() {
    head -c 1000 /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 500 | head -n 1
}

test_loop()
{
    local cmpr=$1
    local data=$2
    local compress=$(curl -s -d "cmpr=${cmpr}&enc=URI-B64&data=${data}" -H "Content-Type: application/x-www-form-urlencoded" -X POST http://tools.snailien.net/URI-Compressor/api/api.php | jq -r '.data')
    local decompress=$(curl -s "http://tools.snailien.net/URI-Compressor/api/api.php?cmpr=${cmpr}&enc=URI-B64&data=${compress}" | jq -r '.data')
    echo "$decompress"
}

pick_compressor() {
    array=("LZMA2" "ZLIB")
    random_element=$(printf "%s\n" "${array[@]}" | shuf -n 1)
    echo "$random_element"
}

# Main loop
for i in {1..1000}; do
    random_string=$(generate_random_string)
    #echo "$random_string"

    
    random_compressor=$(pick_compressor)

    result=$(test_loop "$random_compressor" "$random_string")
    #echo "$result"

    if [ "$random_string" == "$result" ]; then
        echo "[$i/1000] Compression of $random_string under $random_compressor Succeeded!"
        #echo "$random_compressor,$random_string,$result" >> ./successes.log.txt
    fi
    if [ "$random_string" != "$result" ]; then
        echo "[$i/1000] Compression of $random_string under $random_compressor FAILED!"
        echo "$random_compressor,$random_string,$result" >> ./failures.log.txt
    fi

done

echo "Test completed."