Bills
=====

Ledger can help with routine bills in several ways.
The most common use I've found is to search transaction memos for specific payees, which is used to look for bill payments.

Queries for Billing
-------------------

Within the ledger project environment, a variety of ledger "register" operations can zoom in on exactly the desired transactions.

Bills paid by check
^^^^^^^^^^^^^^^^^^^

::

    ledger reg --sort date expenses:rent
    ledger reg --sort date expenses:school

Automatic Debit Payment
^^^^^^^^^^^^^^^^^^^^^^^

::

    ledger reg --sort date @phone
    ledger reg --sort date @electricity
    ledger reg --sort date @internet

Liabilities
^^^^^^^^^^^

::

    ledger reg --sort date -r liabilities:card |grep Assets
