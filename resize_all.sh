#!/bin/bash
# Resize Playgama and GameMonetize for all 9 images
# Each image goes to the format matching its source orientation

set -e
cd "$(dirname "$0")"

SOURCES=(
  "originals/file_00000000014c822f8b672f7c10ba18b1.png"
  "originals/file_000000000b5c81f492ed68ed68aec2e5.png"
  "originals/file_00000000286881f4a226859eb15fecb1.png"
  "originals/file_00000000633c8243a1619883b64ad588.png"
  "originals/file_00000000637481f499e9395e3814e712.png"
  "originals/file_00000000952481f49a94973f0700edbb.png"
  "originals/file_00000000b73081f4b92234403b92add5.png"
  "originals/file_00000000e02881f4a80effd3b82156fe.png"
  "originals/file_00000000e8ec8246a74862c95772e2cf.png"
)

mkdir -p playgama gamemonetize

echo "=== Playgama ==="
echo "  LANDSCAPE → 1920×1080"
echo "  PORTRAIT → 1080×1920"
echo "  SQUARE → 800×800"
echo ""

for src in "${SOURCES[@]}"; do
  basename="${src%.png}"
  shortname="${basename##*_}"
  
  w=$(identify -format '%w' "$src")
  h=$(identify -format '%h' "$src")
  
  if [ "$w" -gt "$h" ]; then
    orientation="landscape"
    tw=1920; th=1080
  elif [ "$h" -gt "$w" ]; then
    orientation="portrait"
    tw=1080; th=1920
  else
    orientation="square"
    tw=800; th=800
  fi
  
  echo "$shortname: ${w}x${h} (${orientation}) → ${tw}x${th}"
  
  convert "$src" \
    -resize "${tw}x${th}" \
    -gravity center -extent "${tw}x${th}" \
    -quality 95 \
    "playgama/${shortname}.png"
done

echo ""
echo "=== GameMonetize ==="
echo "  LANDSCAPE → 512×384"
echo "  PORTRAIT → 340×512"
echo "  SQUARE → 512×512"
echo ""

for src in "${SOURCES[@]}"; do
  basename="${src%.png}"
  shortname="${basename##*_}"
  
  w=$(identify -format '%w' "$src")
  h=$(identify -format '%h' "$src")
  
  if [ "$w" -gt "$h" ]; then
    orientation="landscape"
    tw=512; th=384
  elif [ "$h" -gt "$w" ]; then
    orientation="portrait"
    tw=340; th=512
  else
    orientation="square"
    tw=512; th=512
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
echo ""
echo "Playgama:"
for f in playgama/*.png; do
  name=$(basename "$f")
  dims=$(identify -format '%wx%h' "$f")
  echo "  $name: $dims"
done

echo ""
echo "GameMonetize:"
for f in gamemonetize/*.png; do
  name=$(basename "$f")
  dims=$(identify -format '%wx%h' "$f")
  echo "  $name: $dims"
done

echo ""
echo "DONE!"
