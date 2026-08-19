#!/bin/bash
# Playgama: resize each image according to its source orientation
# - LANDSCAPE source → 1920×1080
# - PORTRAIT source → 1080×1920
# - SQUARE source → 800×800

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

mkdir -p playgama

echo "=== Playgama: resize per source orientation ==="
echo ""

for src in "${SOURCES[@]}"; do
  basename="${src%.png}"
  shortname="${basename##*_}"
  
  # Get source dimensions
  w=$(identify -format '%w' "$src")
  h=$(identify -format '%h' "$src")
  
  # Determine orientation
  if [ "$w" -gt "$h" ]; then
    orientation="landscape"
    target_w=1920
    target_h=1080
  elif [ "$h" -gt "$w" ]; then
    orientation="portrait"
    target_w=1080
    target_h=1920
  else
    orientation="square"
    target_w=800
    target_h=800
  fi
  
  echo "$shortname: ${w}x${h} (${orientation}) → ${target_w}x${target_h}"
  
  convert "$src" \
    -resize "${target_w}x${target_h}" \
    -gravity center -extent "${target_w}x${target_h}" \
    -quality 95 \
    "playgama/${shortname}.png"
done

echo ""
echo "=== Verification ==="
for f in playgama/*.png; do
  name=$(basename "$f")
  dims=$(identify -format '%wx%h' "$f")
  echo "  $name: $dims"
done

echo ""
echo "DONE!"
