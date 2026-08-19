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

# Output dimensions per platform
# Format: PLATFORM|ICON_W|ICON_H|THUMBNAIL_W|THUMBNAIL_H|SCREENSHOT_W|SCREENSHOT_H
PLATFORMS=(
  "playgama|512|512|800|450|1280|720"
  "crazygames|512|512|800|450|1280|720"
  "yandex-games|200|200|1280|720|1280|720"
  "gamedistribution|200|200|800|450|1280|720"
  "gamepix|200|200|800|450|1280|720"
  "gamemonetize|200|200|800|450|1280|720"
)

mkdir -p originals

# Copy originals
for src in "${SOURCES[@]}"; do
  cp "$src" originals/ 2>/dev/null || true
done

echo "=== Starting resize for all platforms ==="

for platform_data in "${PLATFORMS[@]}"; do
  IFS='|' read -r platform icon_w icon_h thumb_w thumb_h screen_w screen_h <<< "$platform_data"
  
  echo ""
  echo "--- Processing: $platform ---"
  
  mkdir -p "$platform/icons"
  mkdir -p "$platform/thumbnails"
  mkdir -p "$platform/screenshots"
  
  for src in "${SOURCES[@]}"; do
    basename="${src%.png}"
    shortname="${basename##*_}"
    
    # Icon: center-crop to square, then resize
    echo "  Icon: $shortname -> ${icon_w}x${icon_h}"
    convert "$src" \
      -gravity center -extent "$(identify -format '%w' "$src")x$(identify -format '%w' "$src")" \
      -resize "${icon_w}x${icon_h}" \
      -quality 95 \
      "$platform/icons/${shortname}.png"
    
    # Thumbnail: resize to fit within bounds, no crop
    echo "  Thumbnail: $shortname -> ${thumb_w}x${thumb_h}"
    convert "$src" \
      -resize "${thumb_w}x${thumb_h}" \
      -gravity center -extent "${thumb_w}x${thumb_h}" \
      -quality 95 \
      "$platform/thumbnails/${shortname}.png"
    
    # Screenshot: resize to fit within bounds
    echo "  Screenshot: $shortname -> ${screen_w}x${screen_h}"
    convert "$src" \
      -resize "${screen_w}x${screen_h}" \
      -gravity center -extent "${screen_w}x${screen_h}" \
      -quality 95 \
      "$platform/screenshots/${shortname}.png"
  done
  
  echo "  Done: $platform"
done

echo ""
echo "=== All platforms processed ==="

# Summary
echo ""
echo "=== File count summary ==="
for platform_data in "${PLATFORMS[@]}"; do
  IFS='|' read -r platform _ _ _ _ _ _ <<< "$platform_data"
  if [ -d "$platform" ]; then
    count_icons=$(find "$platform/icons" -name "*.png" | wc -l)
    count_thumbs=$(find "$platform/thumbnails" -name "*.png" | wc -l)
    count_screens=$(find "$platform/screenshots" -name "*.png" | wc -l)
    echo "  $platform: $count_icons icons, $count_thumbs thumbnails, $count_screens screenshots"
  fi
done

echo ""
echo "=== Sample dimensions check ==="
for platform_data in "${PLATFORMS[@]}"; do
  IFS='|' read -r platform icon_w icon_h _ _ _ _ <<< "$platform_data"
  sample=$(ls "$platform/icons/"*.png 2>/dev/null | head -1)
  if [ -n "$sample" ]; then
    dim=$(identify -format '%wx%h' "$sample")
    echo "  $platform icon: $dim (expected: ${icon_w}x${icon_h})"
  fi
done

echo ""
echo "DONE!"
