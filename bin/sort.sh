#!/bin/bash
# diamond-accounting
# (c) Ian Dennis Miller

function sort_account {
    # set a bunch of variables
    SYNCRC=$1
    YEAR=$2
    ACCT=$3

    LEDGER_PATH=$(dirname $(cat ~/.ledgerrc | cut -d ' ' -f 2))
    LEDGER_GLOB=(${LEDGER_PATH}/${YEAR}/*${ACCT}.ledger)
    LEDGER_FILE=$(ls `eval echo ${LEDGER_GLOB}`)
    ACCT_NAME=$(grep ${ACCT} ${SYNCRC} | cut -d ' ' -f 3)
    echo "ledger file: ${LEDGER_FILE}"
    echo "command: sorttrans-cli"
    LEDGER_FILE=$(ls `eval echo ${LEDGER_GLOB}`) sorttrans-cli
}

if [[ -z $2 ]]; then
    echo "Error: year and account abbreviation are required."
    echo
    echo "Usage: sort.sh [CONFIG] [YYYY] [ACCOUNT]"
    echo "Example: sort.sh etc/syncrc 2017 0123"
    echo
    exit
fi

sort_account $@
