Installation
============

Typical setup
-------------

Python 2.7 is required.

::

    pip install diamond-accounting

The Python 2.7 dependency comes from ledgerhelpers, which does not yet support Python 3.

Python virtualenv
-----------------

You can optionally make a python virtualenv for accounting work.

::

    mkvirtualenv --system-site-packages accounting

Pre-requisites
--------------

Ensure python, virtualenv, and ledger are installed.
On OS X with homebrew, these can be installed with the following commands:

::

    brew install ledger --with-python
    brew install python --universal --framework
    brew install pyenv-virtualenv pyenv-virtualenvwrapper

`Diamond-Accounting` is not currently compatible with Windows.  Sorry.

Configure
---------

Create and edit a configuration file:

::

    ln -s etc/ledgerrc ~/.ledgerrc

Ensure ``etc/ledgerrc`` points to ``ledgers/main.ledger``.
In my case, that looks like:

::

    --file ~/Work/accounting/ledgers/main.ledger

Installing meld
---------------

This is only relevant for sorting ledger files - and if you never do this, you'll be better off.
Sorting is a sensitive process that changes ledger files and should only be run infrequently.

Just install meld from GitHub.
The point is to run ``meld`` on the command line and have it work.
The following commands download Meld and install an alias within the virtualenv.

::

    wget https://github.com/yousseb/meld/releases/download/osx-9/meldmerge.dmg
    open meldmerge.dmg # install it here
    ln -s /Applications/Meld.app/Contents/MacOS/Meld ~/.virtualenvs/accounting/bin/meld
