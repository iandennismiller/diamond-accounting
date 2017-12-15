# Diamond-Accounting Scaffold

Read online for more information about about how to use this scaffold:

http://diamond-accounting.readthedocs.io

## CMS

- [Ledger statements are available online](http://YOUR.CMS/index.php)
- [Upload statement PDFs](http://YOUR.CMS/administrator/index.php?option=com_media&folder=statements)

## Process

- [Setup](http://diamond-accounting.readthedocs.io/en/latest/process/setup.html)
- [Download](http://diamond-accounting.readthedocs.io/en/latest/process/downloading.html)
- [Sync](http://diamond-accounting.readthedocs.io/en/latest/process/sync.html)
- [Categorize](http://diamond-accounting.readthedocs.io/en/latest/process/categorizing.html)
- [Clearing](http://diamond-accounting.readthedocs.io/en/latest/process/clearing.html)
- [Reporting](http://diamond-accounting.readthedocs.io/en/latest/process/reporting.html)

## References

- [Ledger CLI Manual](http://ledger-cli.org/3.0/doc/ledger3.html)
- [Ledger cheatsheet](https://devhints.io/ledger)

## Downloading

This document contains instructions for manually downloading transactions.
The information in this document is sensitive due to its financial nature and should not be shared.

### Setup

    export MONTH=00
    export YEAR=0000
    mkdir data/${YEAR}/${MONTH}
    mkdir statements/${YEAR}/${MONTH}

### Bank Institution 1

- [Open the web portal](https://www.example.com/portal.html) in a new tab

#### Download QFX

- Click "Download Transactions" in the Portal UI
- Iterate through this bank institution's accounts based on `etc/syncrc`
- Select download format: Quicken/QFX
- A file called `download.qfx` is downloaded
- Rename files to match the filenames in `etc/syncrc`:
    - `mv ~/Downloads/download.qfx data/${YEAR}/${MONTH}/0123.qfx`

#### Download PDF

- click "Online Statements" in the Portal UI
- Select which account based on *Sequence* number
- click the link for the statement month
- a file called `onlineStatement.pdf` is downloaded
- rename the file and move it to the statements path
    + `mv ~/Downloads/statement.pdf statements/${YEAR}/${MONTH}/0123.pdf`
