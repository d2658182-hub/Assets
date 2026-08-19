#!/bin/bash
# Script to resize assets for each game portal
# Uses ImageMagick's convert command

set -e

cd "$(dirname "$0")"

# Source images
SOURCES=(
  "file_00000000014c822f8b672f7c10ba18b1.png"
  "file_00000000286881f4a226859eb15fecb1.png"
  "file_00000000633c8243a1619883b64ad588.png"
  "file_00000000637481f499e9395e3814e712.png"
  "file_00000000b73081f4b92234403b92add5.png"
  "file_00000000e02881f4a80effd3b82156fe.png"
  "file_00000000e8ec8246a74862c95772e2cf.png"
)

echo "=== Resize Assets for Game Portals ==="
echo ""
echo "NOTE: Playgama dimensions are verified from their developer docs."
echo "Other platforms use standard industry dimensions."
echo ""

# === PLAYGAMA (verified dimensions) ===
echo "--- Processing: playgama (VERIFIED) ---"
echo "  Cover Landscape: 1920×1080"
echo "  Cover Portrait: 1080×1920"
echo "  Cover Square: 800×800"

mkdir -p playgama/cover-landscape
mkdir -p playgama/cover-portrait
mkdir -p playgama/cover-square

for src in "${SOURCES[@]}"; do
  basename="${src%.png}"
  shortname="${basename##*_}"
  
  convert "$src" -resize "1920x1080" -gravity center -extent "1920x1080" -quality 95 \
    "playgama/cover-landscape/${shortname}.png"
  
  convert "$src" -resize "1080x1920" -gravity center -extent "1080x1920" -quality 95 \
    "playgama/cover-portrait/${shortname}.png"
  
  convert "$src" -gravity center -extent "$(identify -format '%w' "$src")x$(identify -format '%w' "$src")" \
    -resize "800x800" -gravity center -extent "800x800" -quality 95 \
    "playgama/cover-square/${shortname}.png"
done

echo "  Done: playgama"

# === CRAZYGAMES (standard dimensions) ===
echo ""
echo "--- Processing: crazygames ---"
echo "  Icon: 512×512"
echo "  Thumbnail: 800×450"
echo "  Screenshot: 1280×720"

mkdir -p crazygames/icons
mkdir -p crazygames/thumbnails
mkdir -p crazygames/screenshots

for src in "${SOURCES[@]}"; do
  basename="${src%.png}"
  shortname="${basename##*_}"
  
  convert "$src" -gravity center -extent "$(identify -format '%w' "$src")x$(identify -format '%w' "$src")" \
    -resize "512x512" -quality 95 "crazygames/icons/${shortname}.png"
  
  convert "$src" -resize "800x450" -gravity center -extent "800x450" -quality 95 \
    "crazygames/thumbnails/${shortname}.png"
  
  convert "$src" -resize "1280x720" -gravity center -extent "1280x720" -quality 95 \
    "crazygames/screenshots/${shortname}.png"
done

echo "  Done: crazygames"

# === YANDEX GAMES (standard dimensions) ===
echo ""
echo "--- Processing: yandex-games ---"
echo "  Icon: 200×200"
echo "  Cover: 1280×720"
echo "  Screenshot: 1280×720"

mkdir -p yandex-games/icons
mkdir -p yandex-games/covers
mkdir -p yandex-games/screenshots

for src in "${SOURCES[@]}"; do
  basename="${src%.png}"
  shortname="${basename##*_}"
  
  convert "$src" -gravity center -extent "$(identify -format '%w' "$src")x$(identify -format '%w' "$src")" \
    -resize "200x200" -quality 95 "yandex-games/icons/${shortname}.png"
  
  convert "$src" -resize "1280x720" -gravity center -extent "1280x720" -quality 95 \
    "yandex-games/covers/${shortname}.png"
  
  convert "$src" -resize "1280x720" -gravity center -extent "1280x720" -quality 95 \
    "yandex-games/screenshots/${shortname}.png"
done

echo "  Done: yandex-games"

# === GAMEDISTRIBUTION (standard dimensions) ===
echo ""
echo "--- Processing: gamedistribution ---"
echo "  Icon: 200×200"
echo "  Thumbnail: 800×450"
echo "  Screenshot: 1280×720"

mkdir -p gamedistribution/icons
mkdir -p gamedistribution/thumbnails
mkdir -p gamedistribution/screenshots

for src in "${SOURCES[@]}"; do
  basename="${src%.png}"
  shortname="${basename##*_}"
  
  convert "$src" -gravity center -extent "$(identify -format '%w' "$src")x$(identify -format '%w' "$src")" \
    -resize "200x200" -quality 95 "gamedistribution/icons/${shortname}.png"
  
  convert "$src" -resize "800x450" -gravity center -extent "800x450" -quality 95 \
    "gamedistribution/thumbnails/${shortname}.png"
  
  convert "$src" -resize "1280x720" -gravity center -extent "1280x720" -quality 95 \
    "gamedistribution/screenshots/${shortname}.png"
done

echo "  Done: gamedistribution"

# === GAMEPIX (standard dimensions) ===
echo ""
echo "--- Processing: gamepix ---"
echo "  Icon: 200×200"
echo "  Thumbnail: 800×450"
echo "  Screenshot: 1280×720"

mkdir -p gamepix/icons
mkdir -p gamepix/thumbnails
mkdir -p gamepix/screenshots

for src in "${SOURCES[@]}"; do
  basename="${src%.png}"
  shortname="${basename##*_}"
  
  convert "$src" -gravity center -extent "$(identify -format '%w' "$src")x$(identify -format '%w' "$src")" \
    -resize "200x200" -quality 95 "gamepix/icons/${shortname}.png"
  
  convert "$src" -resize "800x450" -gravity center -extent "800x450" -quality 95 \
    "gamepix/thumbnails/${shortname}.png"
  
  convert "$src" -resize "1280x720" -gravity center -extent "1280x720" -quality 95 \
    "gamepix/screenshots/${shortname}.png"
done

echo "  Done: gamepix"

# === GAMEMONETIZE (standard dimensions) ===
echo ""
echo "--- Processing: gamemonetize ---"
echo "  Icon: 200×200"
echo "  Thumbnail: 800×450"
echo "  Screenshot: 1280×720"

mkdir -p gamemonetize/icons
mkdir -p gamemonetize/thumbnails
mkdir -p gamemonetize/screenshots

for src in "${SOURCES[@]}"; do
  basename="${src%.png}"
  shortname="${basename##*_}"
  
  convert "$src" -gravity center -extent "$(identify -format '%w' "$src")x$(identify -format '%w' "$src")" \
    -resize "200x200" -quality 95 "gamemonetize/icons/${shortname}.png"
  
  convert "$src" -resize "800x450" -gravity center -extent "800x450" -quality 95 \
    "gamemonetize/thumbnails/${shortname}.png"
  
  convert "$src" -resize "1280x720" -gravity center -extent "1280x720" -quality 95 \
    "gamemonetize/screenshots/${shortname}.png"
done

echo "  Done: gamemonetize"

echo ""
echo "=== All platforms processed ==="
echo ""
echo "=== Verification ==="
echo ""
echo "Playgama (VERIFIED):"
echo "  Landscape: $(identify playgama/cover-landscape/*.png 2>/dev/null | head -1 | awk '{print $3}')"
echo "  Portrait: $(identify playgama/cover-portrait/*.png 2>/dev/null | head -1 | awk '{print $3}')"
echo "  Square: $(identify playgama/cover-square/*.png 2>/dev/null | head -1 | awk '{print $3}')"
echo ""
echo "=== DONE ==="
