Categorizing
============

.. image:: ../_static/diagrams/Categorization.png

Process Inbox
-------------

Once transactions have been synced to `inbox.ledger`, it is time to process the inbox.
The user imports transactions by cut-and-pasting them from the `inbox` into the destination ledger.
The destination ledger is opened in the text editor depending on the account is indicated by the `sync.sh` comments.
When the inbox is empty because all the transactions were pasted, this process is done.

The primary goals for processing the inbox are: 1) ensure the categories of the transactions have been set correctly; and 2) migrate those transactions into the proper ledger.
The category can usually be determined from the memo and the date, which should enable you to remember the transaction or find a receipt that can establish the category.
There is a separate review step called "clearing" in which transactions are more closely examined to figure out if they are accurate or not.

Category Curation
^^^^^^^^^^^^^^^^^

It is important to consistently label and use your accounts.
Use the account browser to quickly browse the available account names so you can keep your expense categories clean.

::

    make ui

In case you forget the name of a category, it is simple to see some example expenses for a category with the user interface.

Rules for processing
--------------------

There are a few things to watch for while processing.

- If the transaction is a transfer between your own ledger accounts, then move this transaction to `transfers.ledger`.  Some banks provide a generic memo for transfers between internal accounts, so it may be necessary to investigate transactions online.
- If the category is incorrect, edit the transaction before moving it from `inbox.ledger`.  Changing a category and re-running the import can automatically apply that change to remaining transactions in the inbox.
- To see what categories are available, run `make ui` in order to interactively explore the categories in the ledger.
- If the transaction represents a split transaction, then add lines to the transaction before cut-and-pasting it from `inbox.ledger`.
- If a transaction looks proper, and especially if the booked amount matches a receipt, then the transaction can be immediately marked as "cleared".  Uncleared transactions can be investigated later with a special report, after importing is completed.
- When cut-and-pasting, move one or more transaction from the top of the inbox to the bottom of the account ledger you're importing to.

Examples
--------

Purchase Groceries
^^^^^^^^^^^^^^^^^^

Let's say you purchase groceries with the Debit card.
Ensure the expense is categorized and move that transaction to the ledger for the account: ``0123456789.ledger``.

::

    2017/01/01 GROCERY
        ; ofxid: 1.00000_0123456789.0000000000000000000000000
        Assets:Bank:Debit                     -39.00 CAD
        Expenses:Groceries                     39.00 CAD

Move money from Checking to Savings
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Let's say you transfer $200 from the Checking account to the Debit account.
When that transaction appears in ``inbox.ledger``, we process it by moving it to ``transfers.ledger``.

::

    2017/01/01 TRANSFER OUT
        ; ofxid: 1.00000_0123456789.0000000000000000000000000
        Assets:Bank:Checking                 -200.00 CAD
        Assets:Bank:Debit                     200.00 CAD

Automatic Bank Machine
^^^^^^^^^^^^^^^^^^^^^^

Let's say you withdraw $200 from an ATM that charges a $3 usage fee.
Process this transaction by moving it to ``transfers.ledger``.

::

    2017/01/01 ABM WITHDRAWAL
        ; ofxid: 1.00000_0123456789.0000000000000000000000000
        Assets:Bank:Debit                    -203.00 CAD
        Assets:Cash                           200.00 CAD
        Expenses:Bank                           3.00 CAD

Checking the Results
--------------------

Now see whether the items you just entered are in balance.
If everything was entered properly, this will produce a brief balance sheet that only includes your entries.
This works under the presumption that you have previously cleared all your other transactions prior to the current work.

::

    make uncleared

(or manually run ``ledger --uncleared balance``)

Next steps
----------

Next read about :doc:`clearing` and balances need to match their counterparts as calculated by the bank.
