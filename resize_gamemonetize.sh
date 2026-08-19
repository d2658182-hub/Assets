#!/bin/bash
# GameMonetize: resize per source orientation
# - SQUARE source → 512×512
# - LANDSCAPE source → 512×384
# - PORTRAIT source → 340×512

set -e
cd "$(dirname "$0")"

SOURCES=(
  "file_00000000014c822f8b672f7c10ba18b1.png"
  "file_00000000286881f4a226859eb15fecb1.png"
  "file_00000000633c8243a1619883b64ad588.png"
  "file_00000000637481f499e9395e3814e712.png"
  "file_00000000b73081f4b92234403b92add5.png"
  "file_00000000e02881f4a80effd3b82156fe.png"
  "file_00000000e8ec8246a74862c95772e2cf.png"
)

mkdir -p gamemonetize

echo "=== GameMonetize: resize per source orientation ==="
echo "  SQUARE → 512×512"
echo "  LANDSCAPE → 512×384"
echo "  PORTRAIT → 340×512"
echo ""

for src in "${SOURCES[@]}"; do
  basename="${src%.png}"
  shortname="${basename##*_}"
  
  w=$(identify -format '%w' "$src")
  h=$(identify -format '%h' "$src")
  
  if [ "$w" -gt "$h" ]; then
    orientation="landscape"
    tw=512
    th=384
  elif [ "$h" -gt "$w" ]; then
    orientation="portrait"
    tw=340
    th=512
  else
    orientation="square"
    tw=512
    th=512
  fi
  
  echo "$shortname: ${w}x${h} (${orientation}) → ${tw}x${th}"
  
  convert "$src" \
    -resize "${tw}x${th}" \
    -gravity center -extent "${tw}x${th}" \
    -quality 95 \
    "gamemonetize/${shortname}.png"
done

echo ""
echo "=== Verification ==="
for f in gamemonetize/*.png; do
  name=$(basename "$f")
  dims=$(identify -format '%wx%h' "$f")
  echo "  $name: $dims"
done

echo ""
echo "DONE!"
