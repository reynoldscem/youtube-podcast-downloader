#!/bin/bash

DONE_FN="done.txt"
PROCS=$(( $(nproc) * 4 ))
cut -d' ' -f2 "$DONE_FN" |
    xargs -P "$PROCS" -n1 youtube-dl -o "%(title)s" --get-filename -- |
    perl -e 'print sort { length($b) <=> length($a) } <>' |
    cat --number
