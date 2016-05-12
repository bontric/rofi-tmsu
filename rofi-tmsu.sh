#!/usr/bin/env bash

OPEN=xdg-open
TMSU_DB="/path/to/.tmsu/db"

TMSU_CMD="tmsu -D $TMSU_DB"
ROFI_CMD="rofi -dmenu"

function gen_tags()
{
        $TMSU_CMD tags
}

function files()
{
    basename -a $FILES
}

function file_selection()
{
    FILES=$($TMSU_CMD files "$TAGS")

    if [ ! -z "$FILES" ]; then
        SEL=$( files  | $ROFI_CMD -p "Select File:")

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
    TAGS=$( gen_tags  | $ROFI_CMD -p "Select Tag(s):")

    if [ "$TAGS" = "" ]; then
        exit;
    fi

    COUNT=$($TMSU_CMD files --count "$TAGS")

    if [[ ${COUNT:0:1} -ne 0 ]]; then
        file_selection
    else
        show_selection
    fi
}

show_selection
