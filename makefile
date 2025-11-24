VERSION ?= 1.0.0
RELEASE_DIR ?= release
BRANCH ?= main

.PHONY: help check commit-release tag-release publish

help:
	@echo "Usage: make [target]"
	@echo "  commit-release  - commit release artifacts in '$(RELEASE_DIR)' and push"
	@echo "  tag-release     - create and push git tag v$(VERSION)"
	@echo "  publish         - commit-release then tag-release"

check:
	@# ensure release dir exists and contains files
	@test -d "$(RELEASE_DIR)" || (echo "Release dir '$(RELEASE_DIR)' not found" && exit 1)
	@test "$(shell ls -A $(RELEASE_DIR) 2>/dev/null)" != "" || (echo "No files found in '$(RELEASE_DIR)'" && exit 1)

commit-release: check
	@echo "Committing release artifacts in '$(RELEASE_DIR)'..."
	@git add "$(RELEASE_DIR)" || true
	@if git diff --cached --quiet; then \
		echo "No staged changes to commit"; \
	else \
		git commit -m "chore(release): add installer for v$(VERSION)"; \
	fi
	@# push to configured upstream or to origin/$(BRANCH) if no upstream
	@if git rev-parse --abbrev-ref --symbolic-full-name @{u} >/dev/null 2>&1; then \
		git push; \
	else \
		git push --set-upstream origin $(BRANCH); \
	fi

tag-release:
	@echo "Creating git tag v$(VERSION) and pushing..."
	@if git rev-parse "v$(VERSION)" >/dev/null 2>&1; then \
		echo "Tag v$(VERSION) already exists"; \
	else \
		git tag "v$(VERSION)" && git push origin "v$(VERSION)"; \
	fi

publish: commit-release tag-release
	@echo "Publish complete (commit + tag pushed)."
VERSION = 1.0.0


commit-release:
	@echo "Committing installer into release repo..."
	@git add release || true && git commit -m "chore(release): add installer for v$(VERSION)" || echo "no changes to commit" && git push origin HEAD:main

tag-release:
	@echo "Creating git tag v$(VERSION) and pushing..."
	@git tag v$(VERSION) && git push origin v$(VERSION)