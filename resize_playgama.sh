#!/bin/bash
# Resize assets for Playgama with correct dimensions:
# - Cover Landscape: 1920×1080
# - Cover Portrait: 1080×1920
# - Cover Square: 800×800

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

echo "=== Regenerating Playgama assets with correct dimensions ==="
echo "Cover Landscape: 1920×1080"
echo "Cover Portrait: 1080×1920"
echo "Cover Square: 800×800"
echo ""

for src in "${SOURCES[@]}"; do
  basename="${src%.png}"
  shortname="${basename##*_}"
  
  # Cover Landscape 1920×1080
  echo "  Landscape: $shortname -> 1920x1080"
  convert "$src" \
    -resize "1920x1080" \
    -gravity center -extent "1920x1080" \
    -quality 95 \
    "playgama/cover-landscape/${shortname}.png"
  
  # Cover Portrait 1080×1920
  echo "  Portrait: $shortname -> 1080x1920"
  convert "$src" \
    -resize "1080x1920" \
    -gravity center -extent "1080x1920" \
    -quality 95 \
    "playgama/cover-portrait/${shortname}.png"
  
  # Cover Square 800×800
  echo "  Square: $shortname -> 800x800"
  convert "$src" \
    -gravity center -extent "$(identify -format '%w' "$src")x$(identify -format '%w' "$src")" \
    -resize "800x800" \
    -gravity center -extent "800x800" \
    -quality 95 \
    "playgama/cover-square/${shortname}.png"
done

echo ""
echo "=== Verification ==="
echo "Landscape samples:"
identify playgama/cover-landscape/*.png 2>/dev/null | head -2 | awk '{print "  " $3}'
echo "Portrait samples:"
identify playgama/cover-portrait/*.png 2>/dev/null | head -2 | awk '{print "  " $3}'
echo "Square samples:"
identify playgama/cover-square/*.png 2>/dev/null | head -2 | awk '{print "  " $3}'

echo ""
echo "File counts:"
echo "  Landscape: $(ls playgama/cover-landscape/*.png | wc -l) files"
echo "  Portrait: $(ls playgama/cover-portrait/*.png | wc -l) files"
echo "  Square: $(ls playgama/cover-square/*.png | wc -l) files"
echo ""
echo "DONE!"
