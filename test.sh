#!/bin/bash

# Do a GET request
curl "http://tools.snailien.net/URI-Compressor/api.php?cmpr=LZMA2&enc=URI-B64&data=3YCAgIKMgICAgICAgIDkudkYb86xT-jgop4ziIn6f35iAIA"

# Do a POST request
curl -d "cmpr=LZMA2&enc=URI-B64&data=Hello%20World%21" -H "Content-Type: application/x-www-form-urlencoded" -X POST http://tools.snailien.net/URI-Compressor/api.php