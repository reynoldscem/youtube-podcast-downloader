#!/bin/bash

SOURCE_FN="urls.txt"
DONE_FN="done.txt"

progress_count() {
    echo -e -n "\r    $(wc -l "$DONE_FN") / $(wc -l "$SOURCE_FN")"
}

xargs -a "$SOURCE_FN" -P "$(nproc)" -n1 \
    youtube-dl --quiet -x --audio-format mp3 --download-archive "$DONE_FN" &
PROC_ID=$!

while kill -0 "$PROC_ID" >/dev/null 2>&1; do
    progress_count
    sleep 0.5
done
progress_count
echo
echo
source ./yt_title.sh
