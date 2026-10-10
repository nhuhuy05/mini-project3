# KẾ HOẠCH THỰC HIỆN MINI-PROJECT 3

**Đề tài:** OCR Expense Tracker & Receipt Parser (Flutter & Dart).  
**Căn cứ:** [Yêu cầu chi tiết](Mini-Project-3-Yeu-Cau-Chi-Tiet.md) và phạm vi người dùng đã chốt.  
**Ưu tiên:** hoàn thành nhanh, đủ đề; triển khai theo thứ tự phụ thuộc, không chia lịch theo ngày.  
**Trạng thái:** kế hoạch, chưa triển khai hoặc kiểm thử ứng dụng.

## 1. Các quyết định đã chốt

| Nội dung | Phương án |
|---|---|
| Hình thức | Cá nhân |
| Phạm vi | Đủ yêu cầu đề, không bổ sung chức năng lớn |
| Máy phát triển | Windows, laptop có webcam phía trước |
| Chạy ứng dụng | Người dùng tự build và chạy máy ảo |
| Máy ảo mặc định | Android Studio Emulator (AVD); điều chỉnh nếu người dùng dùng loại khác |
| Nền tảng nghiệm thu hiện tại | Android Emulator; chưa có Android thật |
| GitHub | Người dùng tự quản lý repository, commit, push và đăng liên kết |
| UI | Tiếng Việt, Material 3, sáng/tối |
| Tiền và ngày | VND nguyên đồng; hiển thị DD/MM/YYYY |
| Danh mục | Food, Study, Travel, Gear, Entertainment |
| Thống kê | Tuần thứ Hai đến Chủ nhật, dựa trên ngày giao dịch |
| Lưu trữ | Cục bộ, không tài khoản/backend/đồng bộ |
| Tên app tạm | Sổ Chi Tiêu |

Không đưa build/kiểm thử iOS vào lần triển khai này. Tên app và màu giao diện có thể đổi sau, không cần chờ xác nhận.

## 2. Phân công và phạm vi bàn giao

**Trợ lý thực hiện:**

- Viết mã nguồn, cấu hình dự án, test cho logic quan trọng và sửa lỗi.
- Chuẩn bị README hướng dẫn chạy, cấu hình AVD, build và ký release.
- Chạy kiểm tra tĩnh/test khi môi trường cho phép; báo rõ phần đã chạy và phần chưa chạy.
- Chuẩn bị dữ liệu kiểm thử, bảng nghiệm thu và kịch bản demo.
- Soạn nội dung báo cáo theo mẫu dựa trên ứng dụng thực tế; hoàn thiện PDF khi có thông tin sinh viên, ảnh và kết quả kiểm thử.

**Người dùng thực hiện:**

- Build, mở AVD, cấp quyền webcam và thao tác kiểm tra ứng dụng.
- Cung cấp log/lỗi nếu lần chạy trên máy có vấn đề để trợ lý sửa.
- Tự quản lý GitHub, đăng APK/video và liên kết nộp bài.
- Giữ khóa ký release trên máy, không gửi mật khẩu/khóa riêng vào chat.
- Quay video demo, cung cấp thông tin sinh viên và ảnh minh chứng khi hoàn thiện báo cáo.

**Giới hạn cần ghi đúng:** đề gốc yêu cầu kiểm tra APK trên Android thật. Kiểm tra AVD không thay thế minh chứng này. Flash/lấy nét và mục tiêu OCR dưới 100 ms phải được đánh giá theo khả năng thiết bị và số đo thực tế; không đánh dấu đạt khi chưa kiểm chứng. Điều đó không cản trở triển khai các chức năng.

## 3. Thiết kế kỹ thuật dự kiến

### 3.1. Công nghệ

| Thành phần | Lựa chọn dự kiến |
|---|---|
| Framework | Flutter 3.x, Dart 3 |
| State | Riverpod; ưu tiên dòng 2.x theo rubric nếu tương thích SDK |
| Database | sqflite |
| Camera | camera: preview, chụp, flash, focus |
| Chọn ảnh | image_picker: lấy ảnh hóa đơn từ thư viện |
| Crop | image_cropper hoặc phương án tương đương sau khi kiểm tra tương thích |
| OCR | google_mlkit_text_recognition |
| Tệp và ảnh nhỏ | path_provider, path, thư viện xử lý ảnh phù hợp |
| Định dạng | intl |
| Điều hướng | Navigator của Flutter, đủ cho phạm vi ứng dụng |
| Biểu đồ | CustomPainter + animation + gesture của Flutter |

Ở bước đầu sẽ kiểm tra phiên bản SDK/package, Android SDK tối thiểu, Java/Gradle và CPU của AVD theo tài liệu hiện hành. Chỉ khóa dependency sau khi giải quyết tương thích; không lấy nguyên phiên bản ví dụ trong slide. Không dùng thư viện chart bên thứ ba.

### 3.2. Cấu trúc mã nguồn

```text
lib/
  main.dart
  app.dart
  core/          # Theme, màu danh mục, định dạng tiền/ngày
  models/        # Expense, ExpenseCategory, ParsedReceipt
  services/      # Database, repository, OCR, parser, lưu ảnh
  state/         # Riverpod: giao dịch, thống kê, theme
  screens/       # Dashboard, scan, review, danh sách, chi tiết
  widgets/       # Form dùng chung, thẻ giao dịch, hai biểu đồ
test/
  parser/
  statistics/
  widgets/
  fixtures/
integration_test/
docs/
  testing.md
  demo-script.md
```

Tách parser khỏi UI; painter chỉ nhận dữ liệu tổng hợp; lớp truy cập DB không nằm trong widget. Form dùng chung cho nhập tay, review OCR và sửa giao dịch.

### 3.3. Hợp đồng dữ liệu

- `Expense`: id, merchantName, amountVnd, transactionDate, category, ảnh/thumbnail tùy nguồn nhập, rawOcrText tùy chọn, createdAt, updatedAt.
- Tiền lưu integer theo đồng; ngày giao dịch lưu dạng ngày lịch `YYYY-MM-DD`, không chuyển múi giờ làm lệch ngày.
- Danh mục lưu khóa ổn định; UI hiển thị nhãn tiếng Việt.
- `ParsedReceipt` cho phép trường chưa xác định và cảnh báo mơ hồ. Không dùng 0 hoặc ngày hiện tại để giả thành kết quả OCR chắc chắn.
- Giao dịch nhập tay có thể không có ảnh; giao dịch từ scan phải lưu ảnh đã xác nhận.
- Chỉ ghi giao dịch sau review/validation. Chỉ thông báo thành công sau khi DB ghi thành công.
- Hai biểu đồ và tổng dashboard dùng cùng tuần được chọn, hiển thị rõ khoảng ngày.

## 4. Các bước triển khai

### Bước 1. Khởi tạo và kiểm chứng camera/OCR sớm

**Công việc:**

1. Xác định Flutter/Dart, Android SDK, Java và lệnh gọi trong môi trường Windows. Hiện mới biết có thư mục Android SDK; Flutter/Dart chưa tìm thấy qua PATH ở lần kiểm tra trước.
2. Khởi tạo dự án trong thư mục hiện tại, giữ nguyên tài liệu nguồn và file yêu cầu/kế hoạch.
3. Chọn dependency tương thích, cấu hình Android và tạo app shell.
4. Tạo luồng thử preview/chụp ảnh và luồng chọn ảnh để gọi ML Kit thật.
5. Hướng dẫn người dùng cấu hình AVD dùng webcam laptop; kiểm tra camera khả dụng, ảnh xoay/lật và quyền truy cập thực tế.
6. Người dùng build/chạy; xử lý sớm lỗi plugin, native build, quyền và mô hình OCR.

**Đầu ra:** dự án khởi tạo, camera tối thiểu và văn bản OCR thô từ ảnh hóa đơn.

**Tiêu chí hoàn thành:** ứng dụng build/chạy được, preview/chụp được và ML Kit trả về chữ. Nếu camera AVD đang lỗi, có thể tiếp tục các bước dữ liệu/parser bằng luồng chọn ảnh nhưng không đánh dấu camera đã hoàn thành.

### Bước 2. Database, quản lý trạng thái và CRUD nhập tay

**Phụ thuộc:** dự án và dependency ở bước 1.

**Công việc:**

1. Tạo model, schema SQLite phiên bản đầu và repository thêm/đọc/sửa/xóa.
2. Tạo Riverpod controller với trạng thái loading/error/data; DB là nguồn dữ liệu bền vững.
3. Làm form cửa hàng, tiền, ngày và danh mục; validation trước khi ghi.
4. Làm danh sách, chi tiết, chỉnh sửa và xác nhận xóa.
5. Sắp xếp theo ngày giao dịch giảm dần; xử lý thứ tự ổn định khi trùng ngày.
6. Chặn bấm lưu lặp, giữ form nếu lưu thất bại và cập nhật UI sau ghi thành công.

**Đầu ra:** app quản lý chi tiêu bằng nhập tay.

**Tiêu chí hoàn thành:** thêm -> đóng/mở app -> đọc lại -> sửa -> xóa đều đúng; không mất dữ liệu hoặc sinh bản ghi trùng vì submit liên tiếp.

### Bước 3. Parser hóa đơn và unit test

**Phụ thuộc:** model kết quả parser; không cần UI hoàn thiện.

**Công việc:**

1. Giữ văn bản OCR gốc và tạo bản chuẩn hóa để dò nhãn.
2. Dò nhãn tổng tiền tiếng Việt/Anh và ứng viên số ở cùng dòng/dòng liền kề.
3. Phân biệt tổng thanh toán với tạm tính, VAT, tiền khách đưa, tiền thừa, giảm giá, mã hóa đơn và điện thoại.
4. Chuẩn hóa `150,000 VND`, `150.000 đ`, `150000`; không lấy một phần chuỗi số hoặc xóa dấu thập phân tùy tiện.
5. Tìm ngày DD/MM/YYYY và kiểm tra ngày có thật.
6. Tìm tên cửa hàng ở đầu hóa đơn, loại tiêu đề chung/địa chỉ/điện thoại khi phù hợp.
7. Trả về dữ liệu thiếu/cảnh báo nếu không chắc; để review xử lý thay vì tự đoán chắc chắn.
8. Unit test bằng văn bản cố định, gồm tiếng Việt có/không dấu, nhãn tách dòng, ngày sai và nhiều số tiền mâu thuẫn.

**Đầu ra:** parser Dart độc lập, test và bảng quy tắc phục vụ báo cáo.

**Tiêu chí hoàn thành:** các ví dụ bắt buộc trả kết quả đúng; trường không rõ không bị biến thành dữ liệu giả. Test parser tách biệt với chất lượng nhận dạng của ML Kit.

### Bước 4. Hoàn thiện camera, crop và review

**Phụ thuộc:** bước 1–3.

**Công việc:**

1. Hoàn thiện preview, khung căn hóa đơn, chụp, chọn ảnh, flash và chạm lấy nét.
2. Xử lý camera không hỗ trợ flash/focus; biến đổi tọa độ chạm theo vùng preview thực tế.
3. Crop thật, xem lại, chụp lại hoặc hủy; ảnh vào OCR phải là ảnh sau crop và đúng chiều.
4. Nối OCR -> parser -> form review có ảnh đối chiếu.
5. Cho sửa cửa hàng/tiền/ngày, chọn danh mục và xác nhận lưu.
6. OCR lỗi/rỗng cho phép thử lại hoặc nhập tay; hủy không tạo bản ghi.
7. Quản lý các trạng thái đang chụp/crop/nhận dạng/lưu, không chạy lặp đồng thời.
8. Quản lý lifecycle và dispose camera/recognizer; xử lý rời màn hình hoặc app vào nền trong khi đang xử lý.

**Đầu ra:** luồng chụp hoặc chọn ảnh -> crop -> OCR -> parser -> review -> lưu.

**Tiêu chí hoàn thành:** dữ liệu đã sửa được lưu đúng, không tự ghi ngay sau OCR, từ chối quyền/hủy/lỗi không làm crash.

### Bước 5. Lưu ảnh và thumbnail bền vững

**Phụ thuộc:** bước 2 và 4; ghép trực tiếp vào thao tác lưu.

**Công việc:**

1. Phân biệt tệp tạm do app tạo và ảnh đã xác nhận của giao dịch.
2. Khi lưu, tạo tên tệp duy nhất, chuyển ảnh vào thư mục ứng dụng, tạo thumbnail và lưu tham chiếu trong DB.
3. Không phụ thuộc đường dẫn tạm của camera/picker; không xóa ảnh gốc trong thư viện người dùng.
4. Nếu ghi DB thất bại, thu hồi tệp mới tạo khi an toàn; vẫn có thể thử lưu lại.
5. Khi hủy, dọn tệp tạm của app. Khi xóa giao dịch, dọn ảnh liên quan theo thứ tự tránh mất ảnh của bản ghi còn tồn tại.
6. Danh sách dùng thumbnail; chi tiết xem ảnh lớn; có placeholder nếu ảnh thiếu/hỏng.

**Đầu ra:** ảnh/thumbnail gắn với giao dịch và tồn tại sau khởi động lại.

**Tiêu chí hoàn thành:** lưu, hủy, xóa, mở lại app và ảnh bị thiếu đều có hành vi đúng; không để DB trỏ vào tệp tạm đã mất.

### Bước 6. Dashboard và hai biểu đồ CustomPainter

**Phụ thuộc:** CRUD ổn định.

**Công việc:**

1. Viết hàm tổng hợp theo tuần/ngày/danh mục; test ranh giới Chủ nhật–thứ Hai và tuần qua tháng/năm.
2. Dashboard hiển thị tổng tuần, khoảng ngày và điều khiển tuần trước/sau đơn giản.
3. Donut thể hiện tỷ trọng danh mục, màu nhất quán, chú giải và số tiền.
4. Bar chart có bảy cột, ngày không chi tiêu bằng 0; trục/nhãn không chồng.
5. Tự vẽ bằng CustomPainter, thêm animation và chạm xem giá trị; hit test khớp hình đang hiển thị.
6. Cập nhật sau thêm/sửa/xóa; repaint đúng khi đổi dữ liệu, theme, selection hoặc animation.
7. Xử lý không có dữ liệu, một danh mục, số tiền lớn và tên dài.

**Đầu ra:** hai biểu đồ có hoạt ảnh/tương tác, cùng phạm vi thống kê.

**Tiêu chí hoàn thành:** Food 100000, Study 50000, Travel 50000 tạo tổng 200000 và tỷ lệ 50/25/25; cột đúng ngày; sửa/xóa cập nhật; không chia cho 0.

### Bước 7. Hoàn thiện giao diện và kiểm thử tích hợp

**Phụ thuộc:** các luồng chính đã nối hoàn chỉnh.

**Công việc:**

1. Hoàn thiện Material 3 và sáng/tối; chữ, biểu đồ và trạng thái chọn dễ đọc.
2. Kiểm tra màn hình nhỏ, bàn phím, vùng an toàn, cuộn form và tên cửa hàng dài.
3. Thống nhất loading/empty/error và phản hồi thành công.
4. Chạy analyze, unit test và widget test cần thiết; kiểm tra SQLite, camera, ảnh và OCR trên AVD.
5. Kiểm tra offline, ghi rõ mô hình đã sẵn sàng hay có tải tài nguyên ở lần đầu. Ưu tiên cấu hình có thể nhận dạng không cần tải mạng khi sử dụng.
6. Đo riêng OCR và parser bằng tập ảnh cố định; phân biệt lần đầu/lần tiếp theo, ghi cấu hình AVD, build và kích thước ảnh.
7. Đối chiếu TC-01 đến TC-21 trong file yêu cầu, ghi đạt/chưa đạt/chưa kiểm chứng.

**Đầu ra:** bảng kiểm thử thực tế và danh sách giới hạn.

**Tiêu chí hoàn thành:** các phần kiểm tra được trên AVD có kết quả; không còn lỗi làm đứt luồng chính hoặc mất dữ liệu. Không khẳng định tốc độ dưới 100 ms nếu số đo không đạt.

### Bước 8. Bàn giao release và tài liệu nộp

**Phụ thuộc:** kiểm thử luồng chính xong; người dùng cung cấp kết quả build/run và minh chứng.

**Công việc:**

1. Hoàn thiện README: phiên bản thực tế, thiết lập, chạy AVD/webcam, chọn ảnh, build và xử lý lỗi.
2. Chuẩn bị hướng dẫn cấu hình ký release bằng tệp cục bộ không đưa vào Git; người dùng giữ khóa ký.
3. Người dùng build APK, kiểm tra chữ ký theo hướng dẫn và cài bản release lên AVD, chạy lại luồng chính.
4. Hoàn thiện bảng nghiệm thu dựa trên kết quả thật.
5. Viết kịch bản video 2–3 phút: webcam -> crop -> OCR -> review sửa -> lưu -> hai biểu đồ -> sáng/tối.
6. Soạn báo cáo 2–4 trang theo mẫu: thông tin, checklist, kiến trúc, bảng regex, 3–4 ảnh chú thích, khó khăn và giới hạn.
7. Hoàn thiện PDF khi có thông tin và ảnh; người dùng tự đăng repo/APK/video, điền hoặc cung cấp link nộp bài.

**Đầu ra:** mã nguồn, README, hướng dẫn release, bảng kiểm thử, kịch bản demo và báo cáo dựa trên minh chứng.

**Tiêu chí hoàn thành:** người dùng làm theo để build/chạy được; bản release đã được kiểm tra riêng; phần thiếu link/thông tin/thiết bị thật ghi rõ, không đánh dấu hoàn thành thay.

## 5. Liên kết công việc với yêu cầu

| Yêu cầu | Bước | Cách kiểm chứng |
|---|---|---|
| FR-01 Camera/crop | 1, 4 | Người dùng thao tác AVD; kiểm tra preview, crop, quyền và tính năng được hỗ trợ |
| FR-02 OCR | 1, 4, 7 | Ảnh thật -> văn bản, offline, lỗi/rỗng, thời gian |
| FR-03/04 Parser | 3 | Unit test tiền/ngày/cửa hàng, thiếu và mơ hồ |
| FR-05 Review | 2, 4 | Validation, sửa, hủy, chống submit lặp |
| FR-06 CRUD | 2, 7 | Thêm/đọc/sửa/xóa và khởi động lại trên AVD |
| FR-07 Ảnh | 5 | Thumbnail, ảnh lớn, rollback khi lỗi, ảnh thiếu |
| FR-08/09 Biểu đồ | 6 | Unit test tổng hợp và kiểm tra animation/tap/cập nhật |
| FR-10 UI/state | 2, 7 | Sáng/tối, bàn phím, màn hình nhỏ, lifecycle |
| Release/tài liệu | 8 | Người dùng build/chạy/đăng; trợ lý chuẩn bị và sửa theo kết quả |

TC-01 về phần cứng thực và TC-21 trên Android thật giữ trạng thái chưa kiểm chứng nếu chỉ dùng AVD. Kết quả máy ảo không tự đổi yêu cầu của đề gốc.

Các lệnh dự kiến sau khi khởi tạo dự án:

```bash
flutter doctor -v
flutter pub get
flutter analyze
flutter test
flutter devices
flutter run -d <device-id>
flutter build apk --release
```

Thay `<device-id>` bằng mã thiết bị lấy từ `flutter devices`. Lệnh integration test sẽ được bổ sung theo file test thực tế. Đây chưa phải nhật ký lệnh đã chạy.

## 6. Cách thực hiện để giảm thời gian

1. Kiểm chứng native build/camera/ML Kit ngay đầu tiên.
2. Dùng chung form và dịch vụ, không xây nhiều luồng trùng logic.
3. Hoàn thành luồng lưu xuyên suốt trước khi tinh chỉnh UI.
4. Dùng test cố định cho parser và số liệu để giảm thử tay lặp lại.
5. Chỉ tự viết những phần cần thiết, đặc biệt parser và CustomPainter đúng yêu cầu đề.
6. Ghi minh chứng trong lúc test để hoàn thiện báo cáo ở cuối nhanh hơn.
7. Không thêm đăng nhập, cloud, xuất Excel, ngân sách, thông báo, OCR từng mặt hàng hoặc iOS.

## 7. Thông tin còn lại và mặc định xử lý

**Không còn thông tin bắt buộc phải làm rõ trước khi triển khai.** Không cần cung cấp deadline vì đã thống nhất làm nhanh, không chia lịch theo ngày.

| Thông tin | Cách xử lý |
|---|---|
| Loại/tên máy ảo | Mặc định Android Studio Emulator; chỉ cần báo nếu dùng loại khác |
| Webcam có hoạt động với AVD không | Kiểm tra ở bước 1; dùng chọn ảnh để tiếp tục test OCR trong lúc sửa camera |
| Hóa đơn thực tế dùng demo | Có thể bổ sung khi test OCR; mẫu tổng hợp phải ghi rõ là mẫu, không coi là bằng chứng độ chính xác trên hóa đơn thật |
| Tên app/màu | Dùng mặc định đơn giản, có thể sửa sau |
| Họ tên/mã sinh viên | Chỉ cần khi hoàn thiện báo cáo |
| Link repo/APK/video | Người dùng tự lo, bổ sung trước khi nộp |
| Minh chứng điện thoại thật | Ghi chưa kiểm chứng theo điều kiện hiện tại |

## 8. Checklist bàn giao

- [ ] Triển khai đủ FR-01 đến FR-10.
- [ ] Parser và phép tổng hợp có kiểm thử với dữ liệu biết trước.
- [ ] Người dùng build/chạy trên AVD và kiểm tra riêng camera lẫn chọn ảnh.
- [ ] Review trước khi lưu; CRUD và ảnh tồn tại sau khi mở lại ứng dụng.
- [ ] Hai biểu đồ tự vẽ, có hoạt ảnh/tương tác, số liệu cập nhật đúng.
- [ ] Kiểm tra sáng/tối, bàn phím, offline và các lỗi chính.
- [ ] Có hướng dẫn ký release và kết quả chạy bản release thực tế.
- [ ] Có README, bảng nghiệm thu, kịch bản demo và nội dung báo cáo.
- [ ] Các phần chưa đạt/chưa kiểm chứng/đang chờ người dùng được liệt kê đúng.

Hoàn tất mã nguồn và kiểm thử AVD là mục tiêu triển khai hiện tại. Hoàn tất toàn bộ bộ nộp còn phụ thuộc thao tác build/chạy, minh chứng, đăng liên kết của người dùng và yêu cầu kiểm tra thiết bị thật trong đề gốc.
