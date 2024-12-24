#!/bin/bash

# Define the source directory and target directory
SOURCE_DIR="$HOME/Downloads"
TARGET_DIR="$HOME/Downloads/pixiv"
TARGET_DAN="$HOME/Downloads/danbooru"
TARGET_GEL="$HOME/Downloads/gelbooru"
TARGET_KONA="$HOME/Downloads/konachan"
TARGET_SAN="$HOME/Downloads/sankaku"
TARGET_YAN="$HOME/Downloads/yandere"
TARGET_PDF="$HOME/Downloads/pdfs"
TARGET_DOCX="$HOME/Downloads/docx"

mkdir -p "$TARGET_KONA"
mkdir -p "$TARGET_GEL"
mkdir -p "$TARGET_DAN"
mkdir -p "$TARGET_SAN"
mkdir -p "$TARGET_YAN"
mkdir -p "$TARGET_PDF"
mkdir -p "$TARGET_DOCX"

# Upixie a loop to find and move matching files
for file in "$SOURCE_DIR"/*_p*.*; do
  # Check if the file matches the pattern
  if [[ $file =~ [0-9]+_p[0-9]+\..* ]]; then
    mv "$file" "$TARGET_DIR"
    echo "Moved: $file to $TARGET_DIR"
  fi
done

for file in "$SOURCE_DIR"/*.pdf; do
  if [ -e "$file" ]; then
    mv "$file" "$TARGET_PDF"
    echo "Moved: $file to $TARGET_PDF"
  fi
done

# Move images to their respective subfolders
for file in "$SOURCE_DIR"/*.jpg "$SOURCE_DIR"/*.jpeg "$SOURCE_DIR"/*.png "$SOURCE_DIR"/*.gif "$SOURCE_DIR"/*.bmp "$SOURCE_DIR"/*.tiff "$SOURCE_DIR"/*.mp4 "$SOURCE_DIR"/*.webp; do
  # Check if any files match (to avoid errors if no files exist)
  if [ -e "$file" ]; then
    WHERE_FROMS=$(xattr -p com.apple.metadata:kMDItemWhereFroms "$file" 2>/dev/null)
    echo "$WHERE_FROMS"
    if [[ "$WHERE_FROMS" == *"danbooru"* ]]; then
      mv "$file" "$TARGET_DAN"
      echo "Moved: $file to $TARGET_DAN"
    fi
    if [[ "$WHERE_FROMS" == *"gelbooru"* ]]; then
      mv "$file" "$TARGET_GEL"
      echo "Moved: $file to $TARGET_GEL"
    fi
    if [[ "$WHERE_FROMS" == *"konachan"* ]]; then
      mv "$file" "$TARGET_KONA"
      echo "Moved: $file to $TARGET_KONA"
    fi
    if [[ "$WHERE_FROMS" == *"sankaku"* ]]; then
      mv "$file" "$TARGET_SAN"
      echo "Moved: $file to $TARGET_SAN"
    fi
    if [[ "$WHERE_FROMS" == *"yande.re"* ]]; then
      mv "$file" "$TARGET_YAN"
      echo "Moved: $file to $TARGET_YAN"
    fi
    if [[ $file =~ .+\.docx ]]; then
      mv "$file" "$TARGET_DOCX"
      echo "Moved: $file to $TARGET_DOCX"
    fi
  fi
done

echo "Done sorting folder"

