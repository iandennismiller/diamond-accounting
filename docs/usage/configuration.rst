Configuration
=============

There are two files that are used to control `diamond-accounting`

- syncrc
- ledgerrc

syncrc
------

Account numbers are difficult to remember so we store this information in ``syncrc``.
The file called ``etc/syncrc`` is where you define how to sync from your .QFX files into your ledger accounts.
Ledger accounts have plain-language descriptions that are easier to work with than account numbers.

The format of ``etc/syncrc`` looks like this:

::

    [Financial ID] [last 4 digits of account] [ledger account name]

The following is an example for an account stored with my first bank.
Here is an example for an account called "Checking" with an account number *56781234* - so I will use "1234" as the last 4 digits.
The financial ID is 1 because this is my first bank.

::

    1 1234 Assets:Bank:Checking

Here is longer example example with 3 accounts at my first bank and 1 account at a separate bank:

::

    1 1234 Assets:Bank:Checking
    1 2345 Assets:Bank:Debit
    1 3456 Assets:Bank:Savings
    2 0123 Liabilities:CreditCard

ledgerrc
--------

`diamond-accounting` uses ledger-cli to do the heavy lifting.
For ledger to work, this configuration file must point to your actual ledger files.

Install the ledgerrc in your home directory:

::

    ln -s etc/ledgerrc ~/.ledgerrc

Then, ensure the contents of that file actually point to your ``main.ledger``.
