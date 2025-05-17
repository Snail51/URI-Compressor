#!/bin/bash

# Do a GET request
echo -en "\n\n\nHTTP GET of LZMA2 data"
curl "http://tools.snailien.net/URI-Compressor/api/api.php?cmpr=LZMA2&enc=URI-B64&data=3YCAgIKMgICAgICAgIDkudkYb86xT-jgop4ziIn6f35iAIA"
echo -en "\n\n\nHTTP GET of ZLIB data"
curl "http://tools.snailien.net/URI-Compressor/api/api.php?cmpr=ZLIB&enc=URI-B64&data=eNrzSM3JyVcIzy_KSVEEABxJBD4"

# Do a POST request
echo -en "\n\n\nHTTP PUT of LZMA2 data"
curl -d "cmpr=LZMA2&enc=URI-B64&data=Hello%20World%21" -H "Content-Type: application/x-www-form-urlencoded" -X POST http://tools.snailien.net/URI-Compressor/api/api.php
echo -en "\n\n\nHTTP PUT of ZLIB data"
curl -d "cmpr=ZLIB&enc=URI-B64&data=Hello%20World%21" -H "Content-Type: application/x-www-form-urlencoded" -X POST http://tools.snailien.net/URI-Compressor/api/api.php