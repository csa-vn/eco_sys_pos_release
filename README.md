# Phần mềm bán hàng Eco System POS

Tài liệu hướng dẫn cài đặt & phát hành — kho lưu trữ các bản cài đặt (Windows) cho ứng dụng Eco System POS.

## Mục đích
- Lưu trữ file installer (exe) để người dùng cuối có thể tải về và cài đặt.

## Nội dung repository
```
Thư mục gốc/
├─ CHANGELOG.md          # Ghi chú phát hành
├─ README.md             # Hướng dẫn này
├─ release/              # Nơi chứa các file installer (ví dụ: eco-sys-pos-1.2.0.exe)
└─ makefile              # Tiện ích commit / tag / publish
```

## Yêu cầu hệ thống
- Hệ điều hành: Windows 10 / 11 (64-bit)
- Dung lượng ổ đĩa: đủ cho ứng dụng và dữ liệu
- Quyền: quyền cài đặt trên máy (Run as Administrator nếu cần)

## Hướng dẫn cài đặt
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
