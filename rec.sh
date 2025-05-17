#!/bin/bash

if [ -z "$1" ]; then
    echo "Uso: $0 termo_de_busca"
    exit 1
fi

termo="$1"

for file in *.mp3 *.flac *.m4a *.ogg *.wav; do

    [ -f "$file" ] || continue

    output=$(ffprobe -v error -show_entries format_tags=title,artist,album \
        -of default=noprint_wrappers=1:nokey=1 "$file" 2>/dev/null)

    if echo "$output" | grep -iq "$termo"; then
        echo "$file"
    fi
done
