include vendor/mk/base.mk
include vendor/mk/release.mk

build: ## Build a target. Set TARGET=darwin-x86_64
	@echo "--- $@ ($(TARGET))"
	@if [ -z "$(strip $(TARGET))" ]; then \
		echo "xxx usage: make build TARGET=darwin-x86_64" >&2; \
		echo "xxx Missing required value: TARGET" >&2; \
		exit 1; \
	fi
	@$(MAKE) build/testr-$(TARGET)
.PHONY: build

test: ## Runs all tests
.PHONY: test

check: ## Checks all linting, styling, & other rules
.PHONY: check

clean: ## Cleans up project
	rm -rf build
.PHONY: clean

build-release-artifacts: clean
	@echo "--- $@"
	@$(MAKE) build TARGET=darwin-x86_64
	@$(MAKE) build TARGET=freebsd-x86_64
	@$(MAKE) build TARGET=linux-x86_64
	@$(MAKE) build/testr.manifest.txt
.PHONY: build-release-artifacts

build/testr-$(TARGET):
	mkdir -p build
	cp testr $@
	version="$$(cat VERSION.txt)" \
		&& sed -i.bak \
			-e "s,@@version@@,$${version},g" \
			-e "s,@@target@@,$(TARGET),g" $@ \
		&& rm -f $@.bak
	chmod 755 $@
	cd build && md5 $$(basename $@) > $$(basename $@).md5
	cd build && shasum -a 256 $$(basename $@) > $$(basename $@).sha256

build/testr.manifest.txt:
	@echo "--- $@"
	mkdir -p build
	rm -f $@
	echo "darwin-x86-64	testr-darwin-x86-64" >>$@
	echo "freebsd-x86-64	testr-freebsd-x86-64" >>$@
	echo "linux-x86-64	testr-linux-x86-64" >>$@
