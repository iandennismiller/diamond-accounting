Installation
============

prerequisites
-------------

Ensure python, virtualenv, and ledger are installed:

::

    brew install python --universal --framework
    brew install pyenv-virtualenv pyenv-virtualenvwrapper
    brew install ledger --with-python

Make a python virtualenv to contain our ledger work:

::

    mkvirtualenv --system-site-packages ledger
    pip install -r etc/requirements.txt

clone
-----

::

    git clone /Volumes/mpgtrust/ledger.git ~/ledger
    cd ~/ledger

configure
---------

Create and edit a configuration file:

::

    cp etc/ledgerrc ~/.ledgerrc

Ensure the file points to `ledgers/main.ldg`, which in my case looks like:

::

    --file /Users/idm/Work/ledger/ledgers/main.ldg

installing meld
---------------

This is only relevant for sorting ledger files.
Sorting is a sensitive process that changes ledger files and it is run infrequently.
Just install meld from GitHub.

::

    wget https://github.com/yousseb/meld/releases/download/osx-9/meldmerge.dmg
    open meldmerge.dmg # install it here
    ln -s /Applications/Meld.app/Contents/MacOS/Meld ~/.virtualenvs/ledger/bin/meld
