#!/bin/zsh
# チラシ画像を一覧ページ用に縮小して images/ に保存する。
# 使い方: tools/add_image.sh <元画像> <イベントID>
#   例: tools/add_image.sh ~/Downloads/flyer.png 2026-06-20-garden-party
# 長辺1200px・JPEG（HEIC/PNGも可）。元画像は変更しない。

set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "使い方: $0 <元画像> <イベントID>" >&2
  exit 1
fi

src="$1"
id="$2"
root="${0:A:h:h}"
dest="$root/images/$id.jpg"

if [[ ! -f "$src" ]]; then
  echo "画像が見つかりません: $src" >&2
  exit 1
fi

sips -s format jpeg -s formatOptions 82 -Z 1200 "$src" --out "$dest" >/dev/null
echo "images/$id.jpg"
