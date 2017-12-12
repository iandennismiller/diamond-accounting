# diamond-accounting (c) Ian Dennis Miller

SHELL=/bin/bash

ui:
    regdel ledgers/main.ledger

uncleared:
	@echo "Uncleared Balance"
	@echo "-----------------"
	@ledger --uncleared balance

.PHONY: ui uncleared
