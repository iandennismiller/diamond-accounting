#!/usr/bin/bash
# diamond_accounting (c) Ian Dennis Miller

source /usr/local/bin/virtualenvwrapper.sh
mkvirtualenv -a . -r requirements-dev.txt diamond_accounting
source ~/.virtualenvs/diamond_accounting/bin/activate
