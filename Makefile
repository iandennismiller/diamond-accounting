# diamond-accounting (c) Ian Dennis Miller

SHELL=/bin/bash
MOD_NAME=diamond_accounting
TEST_CMD=nosetests -w $(MOD_NAME) -c etc/tests.cfg --with-coverage --cover-package=$(MOD_NAME)

install:
	python setup.py install

dev:
	pip install -r .requirements-dev.txt

clean:
	rm -rf build dist *.egg-info
	find . -name '*.pyc' -delete
	find . -name __pycache__ -delete

docs:
	rm -rf build/sphinx
	sphinx-build -b html docs build/sphinx

watch:
	watchmedo shell-command -R -p "*.py" -c 'date; $(TEST_CMD); date' .

test:
	$(TEST_CMD)

tox:
	tox

release:
	# 1. create ~/.pypirc
	# 2. python setup.py register # notify pypi of new package
	python setup.py sdist upload

# create a homebrew install script
homebrew:
	bin/poet-homebrew.sh
	cp /tmp/diamond-accounting.rb etc/diamond-accounting.rb

.PHONY: clean install test watch docs release tox dev homebrew
