BUMP_MODE ?= minor

bump-version: ## Set a new version for the project. (default: BUMP_MODE=minor)
	@echo "--- $@"
	@echo "  - Bumping version $(BUMP_MODE)"
	versio bump file $(BUMP_MODE)
	@echo "  - Preparing release commit"
	git add VERSION.txt
	git commit --signoff \
		--message "[release] Update version to $$(cat VERSION.txt)"
	@echo
	@echo "To complete the release for $$(cat VERSION.txt), run: \`make tag\`"
.PHONY: bump-version

tag: ## Create a new release Git tag
	@echo "--- $@"
	@version="$$(cat VERSION.txt)" && tag="v$$version" \
		&& git tag --annotate "$$tag" \
			--message "Release version $$version" \
		&& echo "Release tag '$$tag' created." \
		&& echo "To push: \`git push origin $$tag\`"
.PHONY: tag
