# MINI-PROJECT SHORT TECHNICAL REPORT
**Course:** Cross-Platform Mobile App Development (VKU)
**Mini-Project Title:** Mini-Project 3 - SpendWise (Smart Receipt & Expense Tracker)
**Team / Student Name:** Nguyễn Như Huy
**Submission Date:** 09/10/2026

---

## 1. GENERAL INFORMATION & DELIVERABLE LINKS
* **Team Members:**
  1. Nguyễn Như Huy — Student ID: 23IT.B077 — Role: Fullstack Developer — Contribution: 100%
* **🔗 Live Demo URL:** [Chạy cục bộ trên điện thoại Android / Máy ảo LDPlayer]
* **💻 GitHub Repository:** https://github.com/nhuhuy05/mini-project3
* **🎥 Video Demo (Optional):** [Link Video demo nếu có]

---

## 2. FEATURE IMPLEMENTATION CHECKLIST
| # | Required Feature | Status | Implementation Details & Acceptance Level |
|:---:|---|:---:|---|
| 1 | On-Device Text Recognition (OCR) | ✅ Complete | Tích hợp Google ML Kit trích xuất văn bản ngoại tuyến từ camera và thư viện ảnh, không cần Internet. |
| 2 | Heuristic Regex Data Extraction | ✅ Complete | Xây dựng bộ parser bóc tách tự động Tên cửa hàng, Ngày giao dịch, Tổng tiền và lọc dòng tiêu đề blacklist. |
| 3 | Local Database Persistence | ✅ Complete | Sử dụng SQLite (`sqflite`) lưu trữ 100% dữ liệu cục bộ trên thiết bị, hỗ trợ đầy đủ thao tác CRUD và lưu ảnh an toàn. |
| 4 | Native Data Visualization | ✅ Complete | Xây dựng biểu đồ vành khăn (Donut) và biểu đồ cột (Bar) vẽ thuần Canvas API bằng `CustomPainter` (không dùng thư viện ngoài). |
| 5 | Clean UI/UX & State Management | ✅ Complete | Thiết kế chuẩn Material 3 (Tím Hoàng Gia & Hồng Neon), hỗ trợ chuyển đổi Light/Dark mode toàn diện và quản lý trạng thái bằng `ChangeNotifier`. |

---

## 3. TECHNICAL ARCHITECTURE & PROJECT STRUCTURE
* **Architecture Pattern:** Clean / Layered Architecture. Dự án phân tách rõ ràng trách nhiệm giữa các tầng:
  - **Core / Services:** Chứa logic nghiệp vụ cốt lõi gồm `ocr_service`, `receipt_parser_service`, lưu trữ ảnh `receipt_image_storage_service` và bộ điều khiển trạng thái `receipt_controller.dart`.
  - **Data Layer:** Cấu hình cơ sở dữ liệu SQLite (`app_database.dart`), DTO models và `receipt_repository.dart` xử lý truy vấn CRUD.
  - **Features (UI):** Phân chia module tính năng độc lập (`home`, `scan`, `receipt`, `expenses`, `statistics`) chứa màn hình và widgets tương ứng.
* **State Management:** Áp dụng mô hình `ChangeNotifier` / `ListenableBuilder` tích hợp sẵn của Flutter, giúp cập nhật trạng thái phản ứng nhẹ nhàng và hiệu quả trên toàn ứng dụng.
* **Exception Handling:** Sử dụng khối `try-catch` chặt chẽ quanh các tác vụ bất đồng bộ (truy vấn SQLite, khởi tạo camera, nhận dạng ML Kit). Thông báo lỗi thân thiện qua `SnackBar` thay vì gây crash ứng dụng.

---

## 4. EMPIRICAL EVIDENCE & SCREENSHOTS
* **Figure 1: Màn hình Dashboard & Thống kê nhanh (Home Screen)**
  * *Mô tả:* Hiển thị thẻ số liệu chi tiêu tháng/tuần từ SQLite, banner kêu gọi quét hóa đơn và danh sách các hóa đơn gần đây.
  * *(Chèn ảnh chụp màn hình Dashboard tại đây)*

* **Figure 2: Màn hình Quét hóa đơn & Bóc tách On-Device OCR**
  * *Mô tả:* Khung ngắm chụp ảnh trực tiếp (Viewfinder), hỗ trợ flash, chạm lấy nét, cắt xén ảnh (crop) và màn hình nhận diện chữ Google ML Kit.
  * *(Chèn ảnh chụp màn hình Camera / OCR Scan tại đây)*

* **Figure 3: Lịch sử chi tiêu & Bộ lọc đa năng (Expense History)**
  * *Mô tả:* Danh sách hóa đơn chi tiết hỗ trợ tìm kiếm thời gian thực, lọc theo chip danh mục, sắp xếp đa chiều và thao tác vuốt để xóa (Dismissible).
  * *(Chèn ảnh chụp màn hình Lịch sử chi tiêu tại đây)*

* **Figure 4: Biểu đồ CustomPainter & Chế độ Giao diện Tối (Dark Mode)**
  * *Mô tả:* Biểu đồ Donut tương tác và biểu đồ cột tuần vẽ thuần bằng Canvas API, chuyển đổi giao diện sang Dark Mode Material 3 mượt mà.
  * *(Chèn ảnh chụp màn hình Biểu đồ / Dark Mode tại đây)*

---

## 5. TECHNICAL CHALLENGES & RESOLUTIONS
* **Challenge 1: Trích xuất dữ liệu có nghĩa từ văn bản OCR thô (Unstructured OCR Text)**
  * *Mô tả:* Bộ nhận dạng OCR trả về các khối văn bản rời rạc, không theo cấu trúc bảng. Việc xác định đâu là tên cửa hàng, ngày giao dịch và số tiền thanh toán gặp nhiều khó khăn do hóa đơn tại Việt Nam có rất nhiều định dạng khác nhau.
  * *Giải pháp:* Xây dựng `ReceiptParserService` áp dụng thuật toán Heuristic Regex. Thiết lập danh sách Blacklist để lọc các dòng tiêu đề rác (HÓA ĐƠN, VAT, TAX), ưu tiên so khớp các chuỗi siêu thị/thương hiệu phổ biến (WinMart, Circle K,...), và tìm kiếm giá trị tiền tệ lớn nhất trong văn bản làm tổng tiền.
* **Challenge 2: Vẽ biểu đồ dữ liệu tương tác mà không dùng thư viện bên thứ 3**
  * *Mô tả:* Việc không sử dụng thư viện ngoài đòi hỏi phải tự tính toán hình học, tọa độ góc quay và xử lý hoạt ảnh từ đầu.
  * *Giải pháp:* Sử dụng thành thạo `CustomPainter` và `Canvas` API kết hợp `AnimationController`. Tính toán góc quét `sweepAngle` theo tỷ trọng phần trăm cho biểu đồ Donut và tính toán chiều cao cột theo tỷ lệ chi tiêu tối đa cho biểu đồ cột tuần, đồng thời tích hợp cảm ứng chạm điểm để hiển thị chi tiết số liệu.
