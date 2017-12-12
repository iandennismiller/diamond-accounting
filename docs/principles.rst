Principles
==========

`Diamond-Accounting` provides an accounting system with the following in mind:

- Store transaction ledgers using plain text files.
- Use Open Source Software and share results with Open Source community.
- Provide a starting file system structure for holding accounting files.
- The software never changes the ledgers.  They are essentially write-once.
- Each transaction is written exactly once.  Internal transfers between accounts are logged once.
- The raw data produces the ledgers which in turn produce the monthly statements.
- Version control of the ledgers enables simple archival for transactions.
- Produce basic financial statements: balance, income/expense, cashflow.
- Support data entry by multiple people - via version control.
