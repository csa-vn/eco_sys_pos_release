# eco_sys_pos_release

Tài liệu hướng dẫn cài đặt & phát hành — kho lưu trữ các bản cài đặt (Windows) cho ứng dụng Eco System POS.

## Mục đích
- Lưu trữ file installer (exe) để người dùng cuối có thể tải về và cài đặt.
- Cung cấp nơi cho CI/CD upload artifact khi tạo tag release.

## Nội dung repository
```
packages/eco_sys_pos_release/
├─ CHANGELOG.md          # Ghi chú phát hành
├─ README.md             # Hướng dẫn này
├─ release/              # Nơi chứa các file installer (ví dụ: eco-sys-pos-1.2.0.exe)
└─ makefile              # Tiện ích commit / tag / publish
```

## Yêu cầu hệ thống (Người dùng cuối)
- Hệ điều hành: Windows 10 / 11 (64-bit)
- Dung lượng ổ đĩa: đủ cho ứng dụng và dữ liệu
- Quyền: quyền cài đặt trên máy (Run as Administrator nếu cần)

## Hướng dẫn cài đặt (Người dùng cuối)
1. Mở trang `Releases` của repository trên GitHub:
   `https://github.com/csa-vn/eco_sys_pos_release/releases` và tải file installer tương ứng (ví dụ `eco-sys-pos-v1.2.0.exe`).
2. Chạy file `.exe` vừa tải về (double-click) và làm theo hướng dẫn của trình cài đặt.
3. Nếu Windows hiển thị cảnh báo SmartScreen/Antivirus, xác nhận nguồn tin cậy (publisher) rồi cho phép cài.
4. Sau khi cài xong, mở ứng dụng từ Start Menu hoặc biểu tượng trên Desktop.

## Sử dụng cơ bản
- Đăng nhập/Thiết lập cửa hàng (nếu ứng dụng yêu cầu cấu hình ban đầu).
- Ghi bán hàng: chọn sản phẩm, số lượng, hình thức thanh toán.
- Quản lý kho và báo cáo: truy cập menu Quản lý/Thống kê.

## Cập nhật ứng dụng
- Khi có phiên bản mới, tải installer từ trang `Releases` và cài đè (hoặc làm theo hướng dẫn cập nhật tự động nếu tích hợp auto-update).

## Hướng dẫn cho nhà phát triển / phát hành (Developer)
1. Tạo bản build Windows (trong repo mã nguồn `eco_sys_pos`):

```powershell
cd ..\eco_sys_pos
flutter pub get
flutter build windows --release
```

2. Tạo installer (ví dụ dùng `inno_bundle`):

```powershell
flutter pub run inno_bundle:bundle
```

3. Sao chép file installer vào thư mục `packages/eco_sys_pos_release/release`:

```powershell
cp .\build\windows\runner\Release\eco_sys.exe ..\packages\eco_sys_pos_release\release\eco-sys-pos-<VERSION>.exe
```

4. Sử dụng `makefile` có sẵn để commit & tạo tag (ở thư mục `packages/eco_sys_pos_release`):

```powershell
# Thay <VERSION> bằng phiên bản thực tế, ví dụ 1.2.0
make -f .\makefile commit-release VERSION=<VERSION>
make -f .\makefile tag-release VERSION=<VERSION>
# hoặc chạy publish (commit + tag)
make -f .\makefile publish VERSION=<VERSION>
```

5. Sau khi push tag, bạn có thể tạo GitHub Release hoặc cho CI tự động tạo Release và upload asset.

## Gợi ý CI
- Kích hoạt workflow GitHub Actions trên repo chứa mã nguồn `eco_sys_pos` để build, đóng gói installer và upload asset vào repository `eco_sys_pos_release` hoặc trực tiếp tạo Release với asset.

## Đặt tên file & URL truy cập
- Quy ước gợi ý: `eco-sys-pos-<version>.exe`.
- URL tải: `https://github.com/<owner>/eco_sys_pos_release/releases/download/v<version>/eco-sys-pos-<version>.exe`

## Ghi chú quan trọng
- Đảm bảo repository công khai nếu cần người dùng tải trực tiếp.
- Ký số/đóng gói file installer nếu cần để tránh cảnh báo bảo mật.

## Hỗ trợ & Báo lỗi
- Tạo Issue trên GitHub: `https://github.com/<owner>/eco_sys_pos_release/issues`
- Gửi email tới nhóm phát triển (nếu có): support@example.com

## License
- Xem file `LICENSE` trong repo gốc (nếu có) hoặc liên hệ nhóm phát triển để biết chi tiết.

---
Tài liệu này tập trung vào cách cài đặt cho người dùng cuối và quy trình phát hành dành cho nhà phát triển. Nếu bạn muốn tôi bổ sung phần hướng dẫn chi tiết hơn cho CI (ví dụ: file workflow mẫu), hãy cho biết phiên bản CI hoặc công cụ bạn dùng.
4229857938
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


