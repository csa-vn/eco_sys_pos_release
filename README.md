# eco_sys_pos_release

This repository contains release artifacts (installers) for the Eco System POS Windows application.

Purpose:
1. Host public Windows installers so clients can download and auto-update the application.
2. Provide a simple place for CI to upload release assets when a tag is pushed.

Repository layout:

```
eco_sys_pos_release/
 ├── CHANGELOG.md        # release notes per version
 ├── README.md           # this file
 ├── releases/           # contains installer binaries (e.g. eco_sys.exe)
 └── .github/workflows/  # CI workflows that build & upload releases
```

How to release a new version (manual):

1. Build your Windows release in the main `eco_sys_pos` project (example):

	 ```powershell
	 cd ..\eco_sys_pos
	 flutter build windows --release
	 ```

2. Create an installer using `inno_bundle` (this project already configures `inno_bundle` in `pubspec.yaml`). The produced installer is typically placed under the build output or a configured output path. Example (from project root):

	 ```powershell
	 flutter pub run inno_bundle:bundle
	 ```

3. Copy the generated installer (for example `eco_sys.exe`) into the `releases/` directory in this repo.

4. Commit and push changes, then create a tag (Semantic Versioning):

	 ```powershell
	 git add releases/eco_sys.exe CHANGELOG.md
	 git commit -m "chore(release): v1.2.0"
	 git tag v1.2.0
	 git push origin main --follow-tags
	 git push origin v1.2.0
	 ```

5. Optionally create a GitHub Release for the tag and paste release notes (or let CI create the release automatically).

CI (recommended):

Use a GitHub Actions workflow that triggers on pushed tags (e.g. `v*.*.*`). The workflow should:

1. Checkout the repository containing the app source (`eco_sys_pos`) or the launcher for building the app.
2. Build the Windows release (`flutter build windows --release`).
3. Build the installer with `inno_bundle`.
4. Upload the produced installer as a Release asset for the created tag.

Minimal workflow example (in the source repo) - trigger on tag push:

```yaml
on:
	push:
		tags:
			- 'v*.*.*'

jobs:
	build:
		runs-on: windows-latest
		steps:
			- uses: actions/checkout@v3
			- uses: subosito/flutter-action@v2
				with:
					channel: stable
			- run: flutter pub get
			- run: flutter build windows --release
			- run: flutter pub run inno_bundle:bundle
			- uses: softprops/action-gh-release@v1
				with:
					files: path\to\built\installer\eco_sys.exe
```

Notes:
1. Make this repo `public` so client apps can download releases directly from GitHub Releases API.
2. Release assets must be reachable at URLs like: `https://github.com/<owner>/eco_sys_pos_release/releases/download/v1.2.0/eco_sys.exe`.

CI copy location
----------------

If you use the provided workflow in `eco_sys_pos/.github/workflows/release.yml`, the installer will be copied into `packages/eco_sys_pos_release/release/` with a stable name.

When running locally or in a custom CI step, you can copy the installer with PowerShell (example):

```powershell
# from project root (eco_system)
.
cd .\eco_sys_pos
flutter pub run inno_bundle:bundle
pwsh ..\eco_sys_pos\scripts\copy_installer_to_release.ps1 -projectRoot "${PWD}" -targetReleaseDir "${PWD}\..\packages\eco_sys_pos_release\release" -targetName "eco-sys-pos-${{VERSION}}.exe"
```


