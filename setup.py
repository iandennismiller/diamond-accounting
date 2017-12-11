# -*- coding: utf-8 -*-
# diamond-accounting (c) Ian Dennis Miller

import re
import os
import codecs
from setuptools import setup
from setuptools import find_packages


def read(*rnames):
    return codecs.open(os.path.join(os.path.dirname(__file__), *rnames), 'r', 'utf-8').read()


def grep(attrname):
    pattern = r"{0}\W*=\W*'([^']+)'".format(attrname)
    strval, = re.findall(pattern, read('diamond_accounting/__meta__.py'))
    return strval


setup(
    version=grep('__version__'),
    name='diamond-accounting',
    description="Diamond-Accounting helps you manage your books.",
    packages=find_packages(),
    scripts=[
        "bin/diamond-accounting",
        "bin/create-statement.sh",
        "bin/sync.sh",
        "bin/regdel",
    ],
    long_description=read('Readme.rst'),
    classifiers=[],  # Get strings from http://pypi.python.org/pypi?%3Aaction=list_classifiers
    include_package_data=True,
    keywords='',
    author=grep('__author__'),
    author_email=grep('__email__'),
    url=grep('__url__'),
    install_requires=read('requirements.txt'),
    license='MIT',
    zip_safe=False,
)
