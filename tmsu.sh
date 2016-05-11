#!/usr/bin/env bash

OPEN=xdg-open
CWD="/"
TMSU_DB="/path/to/.tmsu/db"

builtin cd $CWD

COUNT=$(tmsu files -D $TMSU_DB --count "$@")

if [ "$#" -le 0 ]; then
    builtin cd $CWD
    tmsu -D $TMSU_DB tags

elif [[ ${COUNT:0:1} -ne 0 ]]; then
    FILES=$(tmsu -D $TMSU_DB files "$@")
    if [[ ! -z $FILES ]]; then
        builtin echo $FILES | tr " " "\n"
    else
        tmsu -D $TMSU_DB tags
    fi
elif [[ -f $@ ]]; then
    coproc ( $OPEN $@ )
    exit;
else
    tmsu -D $TMSU_DB tags
fi
