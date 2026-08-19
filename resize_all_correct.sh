#!/bin/bash
# Resize ALL platforms: each image goes to the format matching its source orientation
# Playgama: LANDSCAPE→1920×1080, PORTRAIT→1080×1920, SQUARE→800×800
# CrazyGames: LANDSCAPE→1280×720, PORTRAIT→720×1280, SQUARE→512×512
# Yandex: LANDSCAPE→1280×720, PORTRAIT→720×1280, SQUARE→200×200
# GameDistribution: LANDSCAPE→800×450, PORTRAIT→450×800, SQUARE→200×200
# GamePix: LANDSCAPE→800×450, PORTRAIT→450×800, SQUARE→200×200
# GameMonetize: LANDSCAPE→800×450, PORTRAIT→450×800, SQUARE→200×200

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

# Platform dimensions: LANDSCAPE_W LANDSCAPE_H PORTRAIT_W PORTRAIT_H SQUARE_SIZE
declare -A PLAT_LANDSCAPE_W=( [playgama]=1920 [crazygames]=1280 [yandex-games]=1280 [gamedistribution]=800 [gamepix]=800 [gamemonetize]=800 )
declare -A PLAT_LANDSCAPE_H=( [playgama]=1080 [crazygames]=720  [yandex-games]=720  [gamedistribution]=450 [gamepix]=450 [gamemonetize]=450 )
declare -A PLAT_PORTRAIT_W=(  [playgama]=1080 [crazygames]=720  [yandex-games]=720  [gamedistribution]=450 [gamepix]=450 [gamemonetize]=450 )
declare -A PLAT_PORTRAIT_H=(  [playgama]=1920 [crazygames]=1280 [yandex-games]=1280 [gamedistribution]=800 [gamepix]=800 [gamemonetize]=800 )
declare -A PLAT_SQUARE=(      [playgama]=800  [crazygames]=512  [yandex-games]=200  [gamedistribution]=200 [gamepix]=200 [gamemonetize]=200 )

PLATFORMS=(playgama crazygames yandex-games gamedistribution gamepix gamemonetize)

echo "=== Resize ALL platforms per source orientation ==="
echo ""

for platform in "${PLATFORMS[@]}"; do
  echo "--- $platform ---"
  mkdir -p "$platform"
  
  for src in "${SOURCES[@]}"; do
    basename="${src%.png}"
    shortname="${basename##*_}"
    
    w=$(identify -format '%w' "$src")
    h=$(identify -format '%h' "$src")
    
    if [ "$w" -gt "$h" ]; then
      tw=${PLAT_LANDSCAPE_W[$platform]}
      th=${PLAT_LANDSCAPE_H[$platform]}
    elif [ "$h" -gt "$w" ]; then
      tw=${PLAT_PORTRAIT_W[$platform]}
      th=${PLAT_PORTRAIT_H[$platform]}
    else
      s=${PLAT_SQUARE[$platform]}
      tw=$s
      th=$s
    fi
    
    convert "$src" \
      -resize "${tw}x${th}" \
      -gravity center -extent "${tw}x${th}" \
      -quality 95 \
      "$platform/${shortname}.png"
  done
  
  echo "  Done"
done

echo ""
echo "=== Verification ==="
for platform in "${PLATFORMS[@]}"; do
  echo ""
  echo "$platform:"
  for f in "$platform"/*.png; do
    name=$(basename "$f")
    dims=$(identify -format '%wx%h' "$f")
    echo "  $name: $dims"
  done
done

echo ""
echo "DONE!"
