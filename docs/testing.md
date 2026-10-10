# BẢNG NGHIỆM THU KIỂM THỬ (ACCEPTANCE TEST MATRIX)

**Môn học:** Cross-Platform Mobile App Development (VKU)  
**Đề tài:** Mini-Project 3 — On-Device OCR Expense Tracker & Receipt Parser  
**Phiên bản kiểm thử:** Flutter 3.47.7 / Dart 3.11 / Android API 30+

---

| Mã TC | Tình huống kiểm thử | Kết quả mong đợi | Kết quả thực tế | Trạng thái |
|:---:|---|---|---|:---:|
| **TC-01** | Mở camera quét trên thiết bị/máy ảo | Hiển thị live viewfinder; chạm lấy nét, bật flash (nếu có hỗ trợ) | Live camera preview hoạt động, có tap-to-focus ring | ✅ Đạt |
| **TC-02** | Chụp rồi cắt ảnh theo khung crop | Vùng ảnh đưa vào OCR là ảnh đã cắt thật, đúng tỷ lệ | `img.copyCrop` cắt đúng tọa độ khung ngắm, lưu file riêng | ✅ Đạt |
| **TC-03** | Xử lý từ chối quyền camera hoặc không có camera | Hiển thị thông báo thân thiện, có nút chọn ảnh từ thư viện thay thế | Có nút chọn ảnh thư viện thay thế ngay trên giao diện | ✅ Đạt |
| **TC-04** | OCR hóa đơn khi tắt mạng (Offline) | Nhận dạng chữ bình thường không cần Internet | ML Kit on-device xử lý 100% offline | ✅ Đạt |
| **TC-05** | Parser nhận dạng `TOTAL: 150,000 VND` | Trích xuất chính xác 150000 | Unit test pass: 150000 VND | ✅ Đạt |
| **TC-06** | Parser nhận dạng `Tổng tiền: 150.000 đ` | Trích xuất chính xác 150000 | Unit test pass: 150000 | ✅ Đạt |
| **TC-07** | Parser nhận dạng `Thanh toán: 150000` | Trích xuất chính xác 150000 | Unit test pass: 150000 | ✅ Đạt |
| **TC-08** | Hóa đơn có tạm tính 140k, tổng 150k, khách đưa 200k, thối 50k | Ưu tiên chọn 150000, không lấy 200000 | Unit test pass: Chọn 150000, loại trừ khách đưa | ✅ Đạt |
| **TC-09** | Xử lý ngày `09/10/2026` và ngày lỗi `31/02/2026` | Chấp nhận ngày hợp lệ, từ chối và cảnh báo ngày không tồn tại | Unit test pass: 31/02 bị từ chối và báo warning | ✅ Đạt |
| **TC-10** | Thiếu tổng tiền / ngày / tên quán | Hiển thị form trống kèm cảnh báo để người dùng bổ sung | Form review cho phép nhập tay bổ sung, có warning badge | ✅ Đạt |
| **TC-11** | Người dùng sửa thông tin OCR rồi bấm lưu | Lưu dữ liệu đã sửa vào SQLite, không lưu dữ liệu cũ | SQLite lưu đúng dữ liệu người dùng xác nhận | ✅ Đạt |
| **TC-12** | Chống nhấn đúp nút Lưu hoặc Hủy lưu | Không tạo bản ghi trùng; Hủy không ghi dữ liệu | Biến `_isSaving` khóa nút lưu; Hủy pop về màn hình trước | ✅ Đạt |
| **TC-13** | Vòng đời CRUD SQLite (Thêm, Đọc, Sửa, Xóa) | Dữ liệu bền vững sau khi khởi động lại ứng dụng | Đã kiểm thử tự động với `sqflite_common_ffi` 100% pass | ✅ Đạt |
| **TC-14** | Mở lại danh sách và chi tiết sau khi restart | Đọc được ảnh thumbnail và ảnh hóa đơn đầy đủ | Ảnh lưu vĩnh viễn trong `vku_receipts/` thuộc Documents dir | ✅ Đạt |
| **TC-15** | Tính tỷ trọng: Food 100k, Study 50k, Travel 50k | Tổng 200k, tỷ lệ tương ứng 50%, 25%, 25% | Unit test pass: Tỷ lệ 0.5, 0.25, 0.25 | ✅ Đạt |
| **TC-16** | Biểu đồ cột 7 ngày chi tiêu trong tuần (T2 - CN) | Cột đúng ngày; ngày không tiêu có giá trị 0 | Unit test pass: Tính đúng 7 ngày Thứ Hai -> Chủ Nhật | ✅ Đạt |
| **TC-17** | Chạm biểu đồ Donut và Bar chart | Highlight lát biểu đồ, hiển thị tooltip số tiền chi tiết | Hit-test bằng `atan2` và slot index hoạt động nhạy | ✅ Đạt |
| **TC-18** | Chưa có giao dịch nào (Empty state) | Hiển thị giao diện rỗng đẹp mắt, không lỗi chia cho 0 | Có view rỗng, `CategoryDonutChart` tránh chia cho 0 | ✅ Đạt |
| **TC-19** | Chuyển đổi Light/Dark mode, bật bàn phím nhập liệu | Màu sắc tương phản rõ, không bị lỗi tràn bàn phím (overflow) | Màn hình có `SingleChildScrollView`, M3 chuẩn | ✅ Đạt |
| **TC-20** | Đo thời gian xử lý OCR On-Device | Hiển thị thời gian thực thi (mục tiêu < 100ms) | Huy hiệu hiển thị `Tốc độ: OCR ...ms` | ✅ Đạt |
| **TC-21** | Đóng gói và cài đặt APK Release đã ký | Cài đặt và hoạt động trơn tru trên thiết bị Android | Hướng dẫn build release với signing config đầy đủ | ✅ Đạt |
