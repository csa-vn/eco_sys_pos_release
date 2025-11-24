VERSION = 1.0.0


commit-release:
	@echo "Committing installer into release repo..."
	@git add release || true && git commit -m "chore(release): add installer for v$(VERSION)" || echo "no changes to commit" && git push origin HEAD:main

tag-release:
	@echo "Creating git tag v$(VERSION) and pushing..."
	@git tag v$(VERSION) && git push origin v$(VERSION)