# URI-Compressor
 ## Purpose
  Almost every program has a need to store data. Instead of the server maintaining a database that links point to, a different solution is to store all relevant data in the URL of the link itself.
  This concept has already been applied in my other projects, such as [the RTN](https://github.com/Snail51/Rapid-Tree-Note), [Sweet Dreams](https://github.com/Snail51/SweetDreams), and my [Stateless Link Shortener](https://github.com/Snail51/Stateless-Link-Shortener).
  The purpose of this repo is to take all the work I have done on these projects and migrate them to a self-contained script that can be easily imported into other projects for use.

 ## Installation
  Simply insert the included `uriCompressor-min.js` in a `<script>` tag in the header of your document.
  ```
  <script src="./uriCompressor-min.js></script>
  ```
  Once included, `URICompressor` will become a static class available at global scope (attached to `window`).
  *Note that inclusion of this script will also pollute the global scope with the keywords `PAKO` and `LZMA`.*

 ## Usage
  Once imported, functionality is accomplished via `URICompressor.push()` and `URICompressor.pull()`.
  In addition to providing data parameters, compression type and encoding type must also be specified.
  For the purposes of this program, the following types are available:
  **Compression:** `LZMA2`, `ZLIB`
  **Encoding:** `URI-B64`

  The result of both functions is returned as an object with the following structure:
  ```
  {
	"length": 59,
	"isEncoded": true,
	"encoding": "URI-B64",
	"compression": "LZMA2",
	"data": "3YCAgIKMgICAgICAgIDkudkYb86xT-jgop4ziIn6f35iAIA"
  }
  ```

  **Compression**
   - Compression is accomplished via `URICompressor.push($Data, $CompressionType, $EncodingType, $MaxLength)`
   - The output (compressed string) is made available in the `.data` attribute.
   - `$MaxLength` - Specifies the maximum size the result can be. If the result is larger than this, the `.data` attribute is set to `ERROR` and the `.error` attribute is set to `Max length exceeded, data Expunged!`.
   - Objects returned from `URICompressor.push()` have their `isEncoded` attribute value equal to `true`.

  **Decompression**
   - Decompression is accomplished via `URICompressor.pull($Data, $CompressionType, $EncodingType)`
   - The output (decompressed string) is made available in the `.data` attribute.
   - Objects returned from `URICompressor.pull()` have their `isEncoded` attribute value equal to `false`.

 ## Use Case
  In all my previous works, I have used this system to embed data into the URL in the following way:
  ```
  https://rtn.snailien.net/program.html?enc=URI-B64&cmpr=LZMA2&data=3YCAgIKNgICAgICAgIDkudkYb86xT-jgop4xOVn6H39_6CCAgA

  Handler / Page:       https://rtn.snailien.net/program.html
  Specify Encoding:     enc=URI-B64
  Specify Compression:  cmpr=LZMA2
  Specify Data:         data=3YCAgIKNgICAgICAgIDkudkYb86xT-jgop4xOVn6H39_6CCAgA
  ```
  The program then collects the GET URI attributes of `data`, `enc`, and `cmpr` to decompress the data and obtain the original string.

 ## Demo
  An interactive demo of this script is available in [demo.html](https://github.com/Snail51/URI-Compressor/blob/main/demo.html).

 ## Credits
  - [PAKO](https://github.com/nodeca/pako) - JavaScript ZLIB compression library
  - [LZMA-JS](https://github.com/LZMA-JS/LZMA-JS) - JavaScript LZMA compression library