#!/usr/bin/env bash

OPEN=xdg-open
CWD="/"
TMSU_DB="/path/to/.tmsu/db"


function gen_tags()
{
        tmsu -D $TMSU_DB tags
}

function files()
{
    for i in ${FILES[@]}; do
        echo $(basename $i);
    done
}

function file_selection()
{
    FILES=$(tmsu -D $TMSU_DB files "$TAGS")

    if [ ! -z "$FILES" ]; then
        SEL=$( files  | rofi -dmenu -p "Select File:")

        if [ ! -z "$SEL"  ]; then
            for i in ${FILES[@]}; do
                if test "$i" != "${i#*/$SEL}" ; then
                    coproc ( $OPEN $i );
                fi
            done
        fi
    else
        show_selection
    fi
}

function show_selection()
{
    TAGS=$( gen_tags  | rofi -dmenu -p "Select Tag(s):")

    if [ "$TAGS" = "" ]; then
        exit;
    fi

    COUNT=$(tmsu files -D $TMSU_DB --count "$TAGS")

    if [[ ${COUNT:0:1} -ne 0 ]]; then
        file_selection
    else
        show_selection
    fi
}

show_selection
