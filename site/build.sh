#!/usr/bin/env bash
# Parçaları birleştirir:
#   page.html  -> claude.ai Artifact olarak yayımlanan gövde (iskeleti platform ekler)
#   index.html -> tek başına tarayıcıda açılabilen tam sayfa
set -euo pipefail
cd "$(dirname "$0")"
P=parts
cat $P/1-head.html $P/2-shell.html $P/3a-notes.html $P/3b-notes.html $P/4-ozet.html $P/5-data.html $P/6-app.html > page.html
{
  printf '<!doctype html>\n<html lang="tr">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n'
  printf '<style>:root{color-scheme:light;padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0}img{max-width:100%%}[hidden]{display:none!important}</style>\n'
  cat $P/1-head.html
  printf '</head>\n<body>\n'
  cat $P/2-shell.html $P/3a-notes.html $P/3b-notes.html $P/4-ozet.html $P/5-data.html $P/6-app.html
  printf '</body>\n</html>\n'
} > index.html
echo "page.html: $(wc -c < page.html) bytes, index.html: $(wc -c < index.html) bytes"
