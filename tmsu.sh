#!/usr/bin/env bash

OPEN=xdg-open 
CWD="/"
TMSU_DB="/path/to/.tmsu/db"

if [[ "$@" == */* ]]; then
    coproc ( $OPEN $@ )
    exit;
fi

# Show all available tags initaly
if [ "$#" -le 0 ]; then
    tmsu -D $TMSU_DB tags
else
    cd $CWD
    FILES=$(tmsu -D $TMSU_DB files "$@") ;
    if [[ ! -z $FILES ]]; then
        echo $FILES | tr " " "\n"
    else
        tmsu -D $TMSU_DB tags
    fi
fi
