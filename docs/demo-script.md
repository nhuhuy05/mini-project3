# KỊCH BẢN QUAY VIDEO DEMO (2–3 PHÚT)

**Môn học:** Cross-Platform Mobile App Development (VKU)  
**Đề tài:** Mini-Project 3 — On-Device OCR Expense Tracker & Receipt Parser  
**Thời lượng chuẩn:** 2 phút 30 giây (Theo yêu cầu slide Tuần 8, trang 43: 2–3 phút)

---

## ⏱️ Dòng thời gian chi tiết

### Phần 1: Giới thiệu tổng quan & Giao diện Material 3 (0:00 – 0:25)
* **Thao tác:**
  1. Mở ứng dụng trên điện thoại/máy ảo. Giới thiệu ngắn: "Xin chào thầy và các bạn, đây là ứng dụng Sổ Chi Tiêu VKU ứng dụng OCR On-Device và Canvas CustomPainter".
  2. Bấm vào icon Mặt trăng/Mặt trời trên thanh AppBar để chuyển đổi giữa **Light Mode** và **Dark Mode**, cho thấy giao diện thích ứng mượt mà.
  3. Lướt qua màn hình Tổng quan (Dashboard) với các thẻ thống kê tổng tuần.

---

### Phần 2: Quét hóa đơn & Bóc tách OCR On-Device (0:25 – 1:05)
* **Thao tác:**
  1. Bấm nút nổi lớn **"Quét Hóa Đơn (OCR)"**.
  2. Màn hình Camera mở ra:
     * Trình diễn chạm vào màn hình để lấy nét (**Tap-to-focus**), xuất hiện vòng tròn vàng.
     * Trình diễn bật/tắt đèn Flash.
     * Căn hóa đơn vào **khung ngắm viền xanh (Crop Overlay)**.
  3. Bấm nút Chụp ảnh (hoặc bấm chọn ảnh từ thư viện nếu chạy trên máy ảo).
  4. Hiệu ứng cắt ảnh và chạy OCR Google ML Kit xuất hiện chỉ trong tích tắc.

---

### Phần 3: Màn hình Review & Xác nhận (1:05 – 1:40)
* **Thao tác:**
  1. Chuyển vào màn hình **"Kiểm tra & Xác nhận"**:
     * Chỉ ra huy hiệu tốc độ xử lý: **"Tốc độ: OCR 85ms | Parser 2ms (< 100ms Đạt chuẩn)"**.
     * Đối chiếu ảnh hóa đơn đã cắt với các trường thông tin tự động điền:
       - Tên cửa hàng (ví dụ: *Highlands Coffee*).
       - Tổng tiền (ví dụ: *150.000 ₫*).
       - Ngày giao dịch (`DD/MM/YYYY`).
     * Trình diễn chỉnh sửa: Nhập thêm ghi chú hoặc đổi nhẹ số tiền để chứng minh tính năng can thiệp thủ công.
     * Chọn 1 trong 5 danh mục bắt buộc (*Ăn uống*).
  2. Bấm nút **"Xác nhận & Lưu chi tiêu"**.

---

### Phần 4: Trực quan hóa dữ liệu bằng CustomPainter (1:40 – 2:15)
* **Thao tác:**
  1. Ứng dụng quay về màn hình Tổng quan.
  2. Dữ liệu tổng tuần tăng lên, ngay lập tức:
     * **Biểu đồ Donut (CustomPainter)**: Tự động chạy Animation quét vòng (`CurvedAnimation`) để vẽ tỷ trọng các danh mục. Chạm tay vào từng lát biểu đồ để highlight và xem số tiền.
     * **Biểu đồ cột tuần (Weekly Bar Chart - CustomPainter)**: 7 cột (T2 đến CN) chạy animation mọc lên. Chạm vào cột ngày vừa thêm giao dịch để hiển thị tooltip số tiền chính xác.
  3. Bấm nút chuyển tuần trước/tuần sau để thể hiện khả năng lọc theo tuần linh hoạt.

---

### Phần 5: Quản lý CRUD SQLite & Vòng đời ảnh (2:15 – 2:45)
* **Thao tác:**
  1. Chuyển sang tab **"Lịch sử"**:
     * Thấy giao dịch vừa lưu xuất hiện ở đầu danh sách kèm ảnh thumbnail thu nhỏ.
     * Thử gõ tìm kiếm theo tên cửa hàng vào ô tìm kiếm.
     * Bấm vào filter chip (ví dụ: chỉ lọc *Ăn uống*).
  2. Mở màn hình **Chi tiết**:
     * Dùng 2 ngón tay zoom phóng to ảnh hóa đơn gốc (`InteractiveViewer`).
     * Mở mục "Văn bản OCR nhận dạng được" để xem text thô.
  3. Trình diễn **Xóa giao dịch**:
     * Vuốt sang trái để xóa (Swipe-to-delete) hoặc bấm nút thùng rác.
     * Xuất hiện hộp thoại xác nhận xóa -> Bấm Xóa.
     * Số liệu trên Dashboard và Biểu đồ tự động cập nhật giảm đi.

---

### Phần 6: Tổng kết & Kết thúc (2:45 – 3:00)
* Tắt kết nối mạng (Wifi/4G) trên máy để chứng minh ứng dụng và ML Kit OCR vẫn hoạt động 100% ngoại tuyến (Offline).
* Kết thúc video: Cảm ơn thầy đã theo dõi.
