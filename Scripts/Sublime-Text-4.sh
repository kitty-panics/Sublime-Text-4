#!/usr/bin/env bash

FILE="sublime_text.exe"
CMD="/usr/bin/xxd"
FIND="807805000f94c1"
REPLACE="c64005014885c9"

function Find_And_Replace() {
    if [[ -f "$FILE" && -f "$CMD" ]]; then
        mv $FILE $FILE.bak
        "$CMD" -p $FILE.bak > $FILE.hex
        sed "s/$FIND/$REPLACE/" $FILE.hex | "$CMD" -p -r > $FILE
    else
        echo -e "=> File '$FILE' or command '$CMD' not found.\n"
    fi
}

[[ "$1" == "-win" || "$1" == "-nt" ]] && GET_OS='NT' || GET_OS="$(uname)"
if [[ "$GET_OS" =~ 'Linux' ]]; then
    FILE="${FILE%%.exe*}"
    Find_And_Replace
    chmod +x $FILE >/dev/null 2>&1
elif [[ "$GET_OS" =~ 'NT' ]]; then
    Find_And_Replace
else
    echo -e "=> Unknown OS: '$GET_OS'.\n"
fi
