#!/bin/bash
# diamond-accounting
# (c) Ian Dennis Miller

function autosync {
    FILENAME=$1
    ACCOUNT=$2
    FID=$3

    # scan the Quicken file for any unimported entries and put them into inbox.ledger
    echo ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;" >> ledgers/inbox.ledger
    echo "; $ACCOUNT ($FILENAME)" >> ledgers/inbox.ledger
    echo ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;" >> ledgers/inbox.ledger
    echo >> ledgers/inbox.ledger
    ledger-autosync /tmp/tmp.qfx -a "$ACCOUNT" --fid $3 >> ledgers/inbox.ledger

    # print results
    echo -n "Inbox now contains "
    echo "$(wc -l ledgers/inbox.ledger | sed -E 's/^ +//g' | cut -d ' ' -f 1) / 4" | bc
}

# remove codes from the file that ledger would interpret as comments (e.g. semicolons)
function clean_qfx {
    FILENAME=$1

    cp "$FILENAME" /tmp/tmp.qfx

    sed "s/'//g" < /tmp/tmp.qfx > /tmp/tmp.new && mv /tmp/tmp.new /tmp/tmp.qfx
    sed "s/\`//g" < /tmp/tmp.qfx > /tmp/tmp.new && mv /tmp/tmp.new /tmp/tmp.qfx
    sed "s/#//g" < /tmp/tmp.qfx > /tmp/tmp.new && mv /tmp/tmp.new /tmp/tmp.qfx
    sed "s/\*//g" < /tmp/tmp.qfx > /tmp/tmp.new && mv /tmp/tmp.new /tmp/tmp.qfx
    sed "s/....;//g" < /tmp/tmp.qfx > /tmp/tmp.new && mv /tmp/tmp.new /tmp/tmp.qfx;
}

function import_file {
    FID=$1
    ACCOUNT_ID=$2
    ACCOUNT_NAME=$3

    FILENAME="data/${YEAR}/${MONTH}/${ACCOUNT_ID}.qfx"

    if [[ ! -f $FILENAME ]]; then
        echo "Error: could not find file $FILENAME"
        exit
    fi

    echo "Import $FILENAME as $ACCOUNT_NAME"
    clean_qfx $FILENAME
    autosync $FILENAME $ACCOUNT_NAME $FID
}

function sync_from_config {
    SYNCRC=$1
    YEAR=$2
    MONTH=$3
    echo "; sync.sh ${SYNCRC}" > ledgers/inbox.ledger
    echo >> ledgers/inbox.ledger

    # read lines from syncrc file and use them as arguments to import_file
    while read -r i; do import_file $i; done < $SYNCRC
}

if [[ -z $2 ]]; then
    echo "Error: configuration and datestamp are required."
    echo
    echo "Usage: sync.sh [CONFIG] [YYYY] [MM]"
    echo "Example: sync.sh etc/syncrc 2017 08"
    echo
    exit
fi

sync_from_config $@
