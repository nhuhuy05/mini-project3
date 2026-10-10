# 📱 SpendWise — Smart Receipt & Expense Tracker

> **Ứng dụng theo dõi chi tiêu và bóc tách hóa đơn thông minh ngoại tuyến (Offline-First)**  
> Được xây dựng bằng **Flutter & Dart**, tích hợp **On-Device OCR (Google ML Kit)** và trực quan hóa dữ liệu tài chính thuần túy bằng **CustomPainter**.

[![Flutter](https://img.shields.io/badge/Flutter-3.47.5-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.13.4-0175C2?logo=dart)](https://dart.dev)
[![Database](https://img.shields.io/badge/Database-SQLite%20(sqflite)-003B57?logo=sqlite)](https://sqlite.org)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-3DDC84?logo=android)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

---

## 💡 Giới thiệu (Overview)

**SpendWise** giải quyết bài toán quản lý tài chính cá nhân thủ công bằng cách tự động hóa quy trình nhập liệu thông qua trí tuệ nhân tạo chạy trực tiếp trên thiết bị (**On-Device AI**).

Người dùng chỉ cần chụp ảnh hóa đơn bán lẻ, hệ thống sẽ tự động quét, nhận diện ký tự quang học (**OCR**) và bóc tách các trường thông tin trọng yếu (*Tên cửa hàng, Ngày giao dịch, Tổng tiền thanh toán*), sau đó trực quan hóa báo cáo tài chính qua các biểu đồ tương tác sinh động.

### 🛡️ Nguyên tắc thiết kế cốt lõi
* **100% Offline-First & Bảo mật riêng tư:** Toàn bộ dữ liệu giao dịch và ảnh chụp được lưu trữ cục bộ qua SQLite. Tuyệt đối không gửi dữ liệu tài chính lên máy chủ đám mây.
* **On-Device Machine Learning:** Sử dụng Google ML Kit Text Recognition chạy trực tiếp bằng phần cứng thiết bị, hoạt động mọi lúc không cần kết nối Internet.
* **Pure CustomPainter Visuals:** Biểu đồ vành khăn (Donut Chart) và biểu đồ cột (Weekly Bar Chart) được lập trình vẽ thuần bằng Canvas API, **hoàn toàn không dùng thư viện biểu đồ bên thứ 3** (`fl_chart`, `syncfusion`).
* **Kiến trúc phân tầng sạch (Clean Architecture):** Tách bạch rõ ràng giữa UI, State Controller, Repository và Services.

---

## ⚡ Luồng xử lý OCR Heuristic (Workflow)

```text
[Chụp ảnh / Chọn ảnh] 
       │
       ▼
[Căn chỉnh & Cắt xén (Crop)] 
       │
       ▼
[Google ML Kit (On-Device OCR)] ──► Văn bản thô (Raw OCR text)
       │
       ▼
[Regex Heuristic Parser] 
   ├── 🏢 Merchant: So khớp thương hiệu (WinMart, Circle K,...) & lọc Blacklist
   ├── 📅 Date: Trích xuất chuẩn DD/MM/YYYY, DD-MM-YYYY, DD.MM.YYYY
   └── 💰 Total: Thuật toán nhận diện số tiền lớn nhất (Hỗ trợ định dạng VND, đ, dấu chấm/phẩy)
       │
       ▼
[Màn hình Review & Chỉnh sửa] ──► Người dùng xác nhận dữ liệu trước khi lưu
       │
       ▼
[Lưu SQLite & Cập nhật UI] ──► Dashboard, Lịch sử chi tiêu & Biểu đồ CustomPainter
```

---

## 🚀 Tính năng nổi bật (Core Features)

| Phân hệ | Mô tả chi tiết |
|---|---|
| **📸 Quét & Xử lý ảnh** | Viewfinder trực tiếp, chạm lấy nét (*tap-to-focus*), bật/tắt Flash, tích hợp cắt xén góc thông minh (`image_cropper`). |
| **🔍 On-Device OCR** | Nhận dạng ký tự ngoại tuyến siêu tốc với Google ML Kit, tự động trích xuất Tên cửa hàng, Ngày tháng và Tổng tiền. |
| **✍️ Review & An toàn dữ liệu** | Hóa đơn luôn qua bước đối chiếu ảnh gốc / văn bản thô để người dùng chỉnh sửa, phân loại danh mục trước khi ghi vào database. |
| **💾 Quản lý dữ liệu (SQLite)** | Lưu trữ bền vững, đầy đủ thao tác CRUD (Thêm, Đọc, Cập nhật, Xóa kèm ảnh gốc). Khởi tạo sẵn 4 bản ghi mẫu demo. |
| **📜 Lịch sử & Bộ lọc** | Tìm kiếm theo từ khóa thời gian thực, lọc theo nhóm danh mục (*Category Chips*), sắp xếp đa chiều, vuốt để xóa (*Dismissible*). |
| **📊 Biểu đồ CustomPainter** | Biểu đồ hình vành khăn (**CategoryDonutChart**) kèm animation & tâm tương tác; Biểu đồ cột 7 ngày (**WeeklyExpenseChart**) chuyển động mọc từ đáy lên. |
| **🎨 Material 3 & Dark Mode** | Bảng màu **Tím Hoàng Gia & Hồng Neon (Royal Violet & Vivid Fuchsia)** hiện đại. Nút chuyển đổi Light/Dark mode mượt mà trên toàn bộ màn hình. |

---

## 🛠️ Công nghệ & Thư viện sử dụng (Tech Stack)

* **Framework & Ngôn ngữ:** Flutter 3.x • Dart 3.x
* **Xử lý hình ảnh & Camera:** `camera`, `image_picker`, `image_cropper`, `path_provider`
* **Trí tuệ nhân tạo:** `google_mlkit_text_recognition` (On-Device)
* **Cơ sở dữ liệu cục bộ:** `sqflite`, `path`
* **Vẽ đồ họa & Biểu đồ:** Pure `CustomPainter` & `Canvas` API, `AnimationController`
* **Quản lý trạng thái:** `ChangeNotifier` / `ListenableBuilder`
* **Kiểm thử tự động:** `flutter_test`, `sqflite_common_ffi`

---

## 📁 Cấu trúc thư mục (Project Structure)

```text
lib/
├── app.dart                                # MaterialApp, Dark/Light Theme & NavigationShell
├── main.dart                               # Entry point, cấu hình StatusBar
├── core/
│   ├── constants/                          # Bảng màu (Royal Violet), danh mục & icon
│   ├── services/                           # OCR Service, Regex Heuristic Parser, Image Storage
│   ├── theme/                              # Material 3 Theme (Light/Dark) & ThemeController
│   ├── utils/                              # Định dạng tiền tệ VND, ngày tháng
│   └── widgets/                            # Animated ThemeToggleButton
├── data/
│   ├── database/                           # SQLite AppDatabase, table schema & seed data
│   ├── models/                             # ReceiptModel (DB Entity), ReceiptData (OCR DTO)
│   └── repositories/                       # ReceiptRepository xử lý CRUD & thống kê SQL
└── features/
    ├── home/                               # Dashboard tổng quan, thẻ thống kê nhanh, Recent items
    ├── scan/                               # Camera scan screen, Image preview, OCR processing
    ├── receipt/                            # Màn hình Review trước khi lưu & Chi tiết hóa đơn
    ├── expenses/                           # Lịch sử chi tiêu, tìm kiếm, lọc danh mục, sắp xếp
    └── statistics/                         # Biểu đồ Donut & Bar chart vẽ thuần CustomPainter
```

---

## 🚀 Hướng dẫn cài đặt & Chạy ứng dụng (Getting Started)

### Yêu cầu tiên quyết
* Flutter SDK `>= 3.20.0`
* Android Studio / VS Code / Antigravity IDE
* Thiết bị Android thật (bật USB Debugging) hoặc máy ảo Android (API Level 21+)

### Khởi chạy dự án

1. **Clone repository:**
   ```bash
   git clone https://github.com/nhuhuy05/mini-project3.git
   cd mini-project3
   ```

2. **Cài đặt thư viện phụ thuộc:**
   ```bash
   flutter pub get
   ```

3. **Chạy ứng dụng:**
   ```bash
   flutter run
   ```

---

## 🧪 Kiểm thử tự động (Automated Testing)

Dự án được xây dựng với bộ kiểm thử tự động toàn diện, bao phủ từ thuật toán bóc tách Regex, tầng lưu trữ cơ sở dữ liệu cho đến khởi chạy giao diện:

```bash
flutter test
```

* **OCR Regex Heuristic Test (`receipt_parser_test.dart`):** Kiểm thử độ chính xác khi bóc tách hóa đơn mẫu, nhận diện đa dạng định dạng tiền tệ (`.`, `,`, `đ`, `VND`), định dạng ngày tháng và lọc blacklist.
* **SQLite CRUD Integration Test (`receipt_repository_test.dart`):** Kiểm thử toàn bộ thao tác Thêm, Sửa, Xóa, Đọc và Thống kê nhóm danh mục trên bộ nhớ ảo FFI.
* **Widget Smoke Test (`widget_test.dart`):** Kiểm thử khởi chạy và render thành công giao diện ứng dụng.

---

## 👨‍💻 Thông tin tác giả & Đồ án

* **Sinh viên thực hiện:** Nguyễn Như Huy
* **Mã số sinh viên (MSSV):** `23IT.B077` — Lớp: `23IT`
* **Học phần:** Phát triển ứng dụng di động đa nền tảng (*Cross-Platform Mobile App Development*)
* **Trường:** Trường Đại học Công nghệ Thông tin và Truyền thông Việt - Hàn (VKU), Đại học Đà Nẵng
* **GitHub Repository:** [https://github.com/nhuhuy05/mini-project3](https://github.com/nhuhuy05/mini-project3)
