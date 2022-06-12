# Package

version       = "0.1.0"
author        = "N545PY"
description   = "Parse Csv, json and other formats into Star Intel Documents"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["starintel_parser"]


# Dependencies

requires "nim >= 1.6.6"
requires "starintel_doc >= 0.1.4"
requires "uuids >= 0.1.11"
requires "mycouch >= 0.4.0"
requires "cligen >= 1.5.24"
