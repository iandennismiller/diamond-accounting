Updating accounts
=================

As long as account transactions can be downloaded in Quicken format, it is possible to import them into a plaintext ledger.
The purpose of updating the accounts is to download any transactions that occurred during the previous month, then import all those transactions into the ledger.

Overview of update process
--------------------------

This update process is:

0. Setup the ledger project environment.
1. `Download <downloading.md>`_ monthly transactions from bank websites.
2. Sync those transactions into `inbox.ledger` with `make sync`.
3. [Process transactions](#process-inbox) in inbox.
4. [Next steps](#next-steps).

Setup
-----

Setup the ledger project environment.
This ensures the right software is open, the right files are open, and things are going to be ready for work.

1. Open password manager software.
2. Enter the ledger project with `project-workon ledger`
3. Load `ledgers/inbox.ledger` and `ledgers/budget.ledger` in editor.
4. Load `ledgers/YYYY/transfers.ledger` in editor for transfers between accounts.
5. Enter SublimeText 2-column mode with `cmd-alt-2`.  Put the inbox on the right and everything else on the left.
6. Open the interactive register with `make ui` so that all accounts can be viewed and historical transactions can be explored.

Download Monthly Transactions
-----------------------------

The goal of downloading transactions is to download a `.QFX` file for each account containing one month of that account's transactions.
These files will eventually be imported into the ledger with the sync process.

Throughout the download process, accounts are referred to by the last 4 or 5 digits of their account number.
When an account is downloaded, the file will be renamed using the 4 or 5 digit number.

Unique portfolios
^^^^^^^^^^^^^^^^^

Each bank or financial institution has a unique process for downloading transactions.
To make this process as repeatable as possible, it is recommended to use account management software to store web URLs and authentication information for logging into your various bank web portals.
Since each accounting portfolio is different, :doc:`downloading.md` is described in a separate document that will be different for each project.

Moving downloads to ledger project
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Once the `.QFX` files have been downloaded and renamed, they must be moved to the ledger project so they can be archived.
Create a folder called `data/YYYY/MM` in the project, where **YYYY** is the year and **MM** is the month.
Move all the downloaded `.QFX` files into this new folder and check it into the repository.

Download Statements
^^^^^^^^^^^^^^^^^^^

Each financial institution produces periodic statements that memorialize your account balances.
These statements need to be downloaded or scanned so they can be compared to the ledger balance, later.
The most convenient time to download these statements is when downloading transaction data.
As with transaction data, the process for downloading statements is unique to each bank so :doc:`downloading.md` is in a separate document as well.

Downloading is complete
^^^^^^^^^^^^^^^^^^^^^^^

Once the `.QFX` and `.PDF` files are in the repository, the ledger project contains an archive of the bank's record of your account transactions.
These archived `.QFX` and `.PDF` files are unlikely to change and, since they are computer-readable, they are a convenient source of raw transaction data for updating our ledgers.

Sync transactions to Inbox
--------------------------

After downloading, transactions need to be synced to `ledgers/inbox.ledger` according to the configuration specified by [etc/syncrc](../etc/syncrc).
The sync process expects to find `.QFX` files for import in within the ledger project itself, inside the `data/` folder.
To perform the sync, use `bin/sync.sh`, substituting the year and month as appropriate:

::

    bin/sync.sh etc/syncrc YYYY MM

As accounts are synced to the inbox, `sync.sh` adds a comment to the file to provide notice that a new account is being synced.
Watch for these comments during import so you know when to switch ledger files.
The `ofxid` that appears as a comment in each transaction must remain intact for re-running `sync.sh` to be possible.

The configuration file `syncrc`
-------------------------------

The configuration file describes all of the accounts that should be imported by `sync.sh`.
Each row in the configuration is one account and it has three fields:

- financial ID
- 4 or 5-digit account ID
- account name to import into ledger as.

For example:

::

    1 1234 Assets:BankOne:Checking
    1 2345 Assets:BankOne:Savings
    2 3456 Assets:BankTwo:Savings

The financial ID is a number that chosen by you, but it should be unique and consistent within your ledgers.
The account ID and account name should match your portfolio.

Process Inbox
-------------

Once transactions have been synced to `inbox.ledger`, it is time to process the inbox.
The user imports transactions by cut-and-pasting them from the `inbox` into the destination ledger.
The destination ledger is opened in the text editor depending on the account is indicated by the `sync.sh` comments.
When the inbox is empty because all the transactions were pasted, this process is done.

The primary goals for processing the inbox are: 1) ensure the categories of the transactions have been set correctly; and 2) migrate those transactions into the proper ledger.
The category can usually be determined from the memo and the date, which should enable you to remember the transaction or find a receipt that can establish the category.
There is a separate review step called "clearing" in which transactions are more closely examined to figure out if they are accurate or not.

Rules for processing
--------------------

There are a few things to watch for while processing.

- If the transaction is a transfer between your own ledger accounts, then move this transaction to `transfers.ledger`.  Some banks provide a generic memo for transfers between internal accounts, so it may be necessary to investigate transactions online.
- If the category is incorrect, edit the transaction before moving it from `inbox.ledger`.  Changing a category and re-running the import can automatically apply that change to remaining transactions in the inbox.
- To see what categories are available, run `make ui` in order to interactively explore the categories in the ledger.
- If the transaction represents a split transaction, then add lines to the transaction before cut-and-pasting it from `inbox.ledger`.
- If a transaction looks proper, and especially if the booked amount matches a receipt, then the transaction can be immediately marked as "cleared".  Uncleared transactions can be investigated later with a special report, after importing is completed.
- When cut-and-pasting, move one or more transaction from the top of the inbox to the bottom of the account ledger you're importing to.

Next steps
----------

Next read about :doc:`clearing` and balances need to match their counterparts as calculated by the bank.
