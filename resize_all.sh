#!/bin/bash
cd "$(dirname "$0")"

for f in originals/*.png; do
  name=$(basename "$f")
  w=$(identify -format '%w' "$f")
  h=$(identify -format '%h' "$f")
  
  if [ "$w" -gt "$h" ]; then
    orient="landscape"
  elif [ "$w" -lt "$h" ]; then
    orient="portrait"
  else
    orient="square"
  fi
  
  echo "$name: ${w}x${h} $orient"
  
  if [ "$orient" = "landscape" ]; then
    # Playgama: 1920x1080
    convert "$f" -resize 1920x1080! -quality 95 "playgama/${name}"
    # GameMonetize: 512x384
    convert "$f" -resize 512x384! -quality 95 "gamemonetize/${name}"
  elif [ "$orient" = "portrait" ]; then
    # Playgama: 1080x1920
    convert "$f" -resize 1080x1920! -quality 95 "playgama/${name}"
    # GameMonetize: 340x512
    convert "$f" -resize 340x512! -quality 95 "gamemonetize/${name}"
  else
    # Playgama: 800x800
    convert "$f" -resize 800x800! -quality 95 "playgama/${name}"
    # GameMonetize: 512x512
    convert "$f" -resize 512x512! -quality 95 "gamemonetize/${name}"
  fi
done

echo ""
echo "=== PLAYGAMA ==="
for f in playgama/*.png; do
  echo "$(basename $f): $(identify -format '%wx%h' $f)"
done

echo ""
echo "=== GAMEMONETIZE ==="
for f in gamemonetize/*.png; do
  echo "$(basename $f): $(identify -format '%wx%h' $f)"
done
