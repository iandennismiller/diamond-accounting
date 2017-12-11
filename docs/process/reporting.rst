Reporting
=========

The monthly statement is a compilation of common financial statements, including balance, income/expense, and year-to-date graphs.
Once the accounts have been imported and cleared, then it is time to create a monthly statement.

Create a Statement
------------------

A monthly statement PDF can be generated with `create-statement.sh`.

::

    create-statement.sh YYYY MM "NAME ON STATEMENT"

For example, to create a statement for January 2017:

::

    create-statement.sh 2017 01 "Fancy Pants"

The result will be placed into `/products/2017/2017-01.pdf`.

Uploading
---------

Statements should be archived in a CMS for easier use.
If you use Joomla for your CMS, then there are two URLs to know:

- [Administrator Media Manager](http://LOCALHOST/administrator/index.php?option=com_media&folder=statements)
- [Accounting page on CMS](http://LOCALHOST/index.php/accounting)

To add a statement, first upload the PDF via the Media manager.
Once the PDF has been saved to the CMS server, then edit the Accounting page to include a link to the PDF.

- click gear dropdown icon
- click "edit"
- at the bottom of the edit form, click "toggle editor"
- cut-and-paste a link to a previous month and update it for the current month.

NB: multiple files can be uploaded at once.

Next steps
----------

[The reports are online so it is time to make regular use of them.](reading.md)
