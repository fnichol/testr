include vendor/mk/base.mk
include vendor/mk/release.mk

build:
.PHONY: build

test: ## Runs all tests
.PHONY: test

check: ## Checks all linting, styling, & other rules
.PHONY: check

clean: ## Cleans up project
.PHONY: clean
