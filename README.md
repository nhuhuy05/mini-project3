# SpendWise - Quản lý chi tiêu & Quét hóa đơn

Ứng dụng theo dõi chi tiêu cá nhân bằng Flutter, hỗ trợ quét hóa đơn tự động qua OCR trên thiết bị và trực quan hóa dữ liệu bằng biểu đồ.

## Các tính năng chính

1. **Quét và nhận diện hóa đơn (On-Device OCR):**
   - Chụp ảnh trực tiếp từ camera hoặc chọn ảnh từ thư viện.
   - Hỗ trợ cắt ảnh (crop) để lấy đúng phần nội dung hóa đơn.
   - Tự động bóc tách tên cửa hàng, ngày giao dịch và tổng tiền bằng Google ML Kit kết hợp Regex (hoạt động hoàn toàn offline, không cần internet).

2. **Xác nhận và chỉnh sửa dữ liệu:**
   - Màn hình kiểm tra trước khi lưu giúp người dùng rà soát, sửa đổi thông tin và phân loại danh mục (Thực phẩm, Du lịch, Thiết bị, v.v.).

3. **Quản lý lịch sử chi tiêu:**
   - Lưu trữ dữ liệu cục bộ bằng SQLite (`sqflite`).
   - Hỗ trợ đầy đủ thêm, xem chi tiết, sửa và xóa hóa đơn.
   - Tìm kiếm nhanh theo tên cửa hàng hoặc ghi chú.
   - Bộ lọc theo danh mục chi tiêu và sắp xếp theo ngày/số tiền.

4. **Thống kê và Biểu đồ:**
   - Biểu đồ vành khăn (Donut Chart) thể hiện tỷ trọng chi tiêu theo từng nhóm danh mục.
   - Biểu đồ cột (Bar Chart) thống kê chi tiêu trong 7 ngày gần nhất.
   - Toàn bộ biểu đồ được vẽ thuần bằng `CustomPainter` / `Canvas API` (không sử dụng thư viện biểu đồ bên thứ 3).

5. **Giao diện người dùng:**
   - Thiết kế theo chuẩn Material 3.
   - Hỗ trợ đầy đủ 2 chế độ Giao diện Sáng (Light Mode) và Giao diện Tối (Dark Mode).

---

## Công nghệ sử dụng

- **Framework:** Flutter & Dart
- **Nhận diện chữ (OCR):** `google_mlkit_text_recognition`
- **Cơ sở dữ liệu:** `sqflite` (SQLite)
- **Xử lý ảnh:** `camera`, `image_picker`, `image_cropper`
- **Vẽ đồ họa:** Flutter `CustomPainter` & `Canvas`
- **Quản lý trạng thái:** `ChangeNotifier` / `ListenableBuilder`

---

## Hướng dẫn cài đặt và chạy ứng dụng

### 1. Yêu cầu môi trường
- Flutter SDK (phiên bản 3.20 trở lên)
- Android Studio / VS Code
- Thiết bị thật hoặc máy ảo Android (API 21+)

### 2. Các bước khởi chạy

```bash
# 1. Clone repository
git clone https://github.com/nhuhuy05/mini-project3.git
cd mini-project3

# 2. Cài đặt các package phụ thuộc
flutter pub get

# 3. Chạy kiểm thử tự động (Unit test)
flutter test

# 4. Chạy ứng dụng trên thiết bị
flutter run
```

---

## Cấu trúc thư mục mã nguồn

```text
lib/
├── app.dart                   # Cấu hình MaterialApp, Theme và Navigation
├── main.dart                  # Điểm khởi chạy ứng dụng
├── core/
│   ├── constants/             # Bảng màu, danh mục chi tiêu
│   ├── services/              # Xử lý OCR, bộ bóc tách Regex, lưu ảnh
│   ├── theme/                 # Cấu hình Material 3 (Light/Dark)
│   └── utils/                 # Format tiền tệ VND, ngày tháng
├── data/
│   ├── database/              # Khởi tạo SQLite và dữ liệu mẫu
│   ├── models/                # Model hóa đơn và kết quả OCR
│   └── repositories/          # Xử lý truy vấn dữ liệu CRUD
└── features/
    ├── home/                  # Màn hình Dashboard và thống kê nhanh
    ├── scan/                  # Camera chụp ảnh và xử lý OCR
    ├── receipt/               # Màn hình xem lại, chi tiết hóa đơn
    ├── expenses/              # Màn hình lịch sử, tìm kiếm, lọc
    └── statistics/            # Màn hình báo cáo và biểu đồ CustomPainter
```
