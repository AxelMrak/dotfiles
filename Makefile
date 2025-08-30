SHELL := /bin/bash

.PHONY: setup bootstrap list

setup:
	@bash scripts/install.sh

bootstrap:
	@bash scripts/bootstrap.sh $(PKG)

list:
	@find . -maxdepth 3 -print | sort

