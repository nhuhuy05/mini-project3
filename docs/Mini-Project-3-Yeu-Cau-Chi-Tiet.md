# MINI-PROJECT 3: YÊU CẦU CHI TIẾT

**Tên đề tài:** OCR Expense Tracker & Receipt Parser (Flutter & Dart)  
**Tên tiếng Việt:** Ứng dụng theo dõi chi tiêu và trích xuất thông tin hóa đơn bằng OCR  
**Môn học:** Cross-Platform Mobile App Development (VKU)

## 1. Nguồn và cách hiểu yêu cầu

Tài liệu này tổng hợp đề bài trong ba ảnh được cung cấp, đối chiếu với bài giảng và mẫu báo cáo:

| Ký hiệu | Nguồn | Nội dung liên quan |
|---|---|---|
| A | Ba ảnh đề bài trong cuộc trò chuyện | Mục tiêu, chức năng chính, công nghệ và bộ sản phẩm nộp |
| B | [Week-07-Flutter-Part1.pdf](Week-07-Flutter-Part1.pdf), trang 41–43 | Phạm vi dự án, thang điểm 10, công nghệ minh họa |
| C | [Week-08-Flutter-Part2.pdf](Week-08-Flutter-Part2.pdf), trang 18, 26–34, 41–43 | Quản lý trạng thái, form, biểu đồ, luồng OCR, checklist và thời hạn |
| D | [Mini-Project-3-Report-Template.md](Mini-Project-3-Report-Template.md) | Cấu trúc báo cáo kỹ thuật |

**Quy ước:**

- **Bắt buộc theo đề:** nội dung được nêu trực tiếp trong ảnh hoặc phần yêu cầu/chấm điểm dự án của bài giảng.
- **Đề xuất triển khai/nghiệm thu:** cách cụ thể hóa yêu cầu để lập trình và kiểm tra; không phải tiêu chí chấm điểm bổ sung do giảng viên công bố.
- Các ví dụ và ngưỡng kiểm tra trong phần đề xuất là dữ liệu minh họa, không phải kết quả chạy ứng dụng.

**Các điểm cần đọc thống nhất giữa các nguồn:**

1. Ảnh gom sản phẩm thành 3 nhóm: APK + video, GitHub, báo cáo PDF. Tuần 8 tách thành 4 mục. Thực tế cần đủ **APK, video, repository và báo cáo**.
2. Mẫu báo cáo ghi video là “Optional”, nhưng đề và checklist tuần 8 yêu cầu video. Vì vậy video là **bắt buộc cho Mini-Project 3**.
3. Ảnh cho phép `sqflite` hoặc `isar`; rubric tuần 7 và luồng tuần 8 nêu cụ thể `sqflite`/SQLite. **Đề xuất chọn sqflite** để khớp cả hai nguồn. Isar được ảnh cho phép, nhưng cách chấm phương án đó không được tài liệu làm rõ.
4. Provider hoặc Riverpod 2 được rubric chấp nhận; Riverpod 2 là khuyến nghị của bài giảng, không phải lựa chọn duy nhất.
5. `image_picker` xuất hiện trong ví dụ bài giảng, nhưng đề trong ảnh yêu cầu live viewfinder, flash, chạm lấy nét và khung crop. Cần nghiệm thu đủ các hành vi này, không chỉ dựa vào việc đã thêm một package chụp ảnh.
6. Các dòng responsive/dark mode/background sync trong bảng mẫu báo cáo chỉ là ví dụ. Dark mode và responsive có căn cứ riêng trong rubric; **background sync không được yêu cầu trong đề này**.

## 2. Bối cảnh, mục tiêu và phạm vi

Sinh viên và thủ quỹ câu lạc bộ thường phải nhập thủ công các khoản chi từ hóa đơn giấy, hóa đơn siêu thị hoặc biên lai. Công việc này tốn thời gian và dễ sai số. Ứng dụng cần giúp người dùng chụp hóa đơn, nhận dạng chữ trên thiết bị, trích xuất dữ liệu quan trọng, kiểm tra lại và lưu chi tiêu để xem thống kê.

### 2.1. Mục tiêu học tập bắt buộc

- Phát triển ứng dụng quản lý tài chính cá nhân bằng Flutter với AI chạy trên thiết bị.
- Tích hợp Google ML Kit Text Recognition để đọc hóa đơn ngoại tuyến.
- Tự xây dựng bộ phân tích regex kết hợp heuristic để lấy **tổng tiền, tên cửa hàng và ngày giao dịch**.
- Vẽ biểu đồ tròn/vành khuyên và biểu đồ cột có hoạt ảnh, có tương tác bằng `CustomPainter`.
- Kết nối giao diện, quản lý trạng thái, lưu trữ cục bộ và vòng đời giao dịch thành một luồng hoàn chỉnh.

### 2.2. Nền tảng và giới hạn phạm vi

| Hạng mục | Yêu cầu hoặc định hướng |
|---|---|
| Framework/ngôn ngữ | Flutter 3.x, Dart 3 |
| OCR | `google_mlkit_text_recognition`, xử lý trên thiết bị, không dùng OCR đám mây cho luồng chính |
| Cơ sở dữ liệu | SQLite qua `sqflite`, hoặc Isar theo lựa chọn trong ảnh; ưu tiên sqflite theo mục 1 |
| Biểu đồ | Tự vẽ bằng `CustomPainter`; không dùng thư viện biểu đồ bên thứ ba |
| Quản lý trạng thái | Provider hoặc Riverpod 2 theo rubric |
| Giao diện | Material 3, chế độ sáng/tối, bố cục đáp ứng |
| Nền tảng phải chứng minh | Android, có APK release đã ký và kiểm tra trên thiết bị thật |
| Điều hướng | GoRouter là gợi ý trong bài giảng; đề không bắt buộc một thư viện điều hướng cụ thể |

Không có yêu cầu bắt buộc về tài khoản, backend, đồng bộ đám mây, kết nối ngân hàng, thanh toán, xuất Excel, OCR từng mặt hàng, bản iOS/Web phát hành hay tự viết platform channel. Những chức năng đó chỉ là mở rộng nếu còn thời gian.

## 3. Luồng nghiệp vụ tổng thể

```text
Mở ứng dụng
  -> Mở camera và cấp quyền
  -> Căn hóa đơn, bật/tắt flash, chạm lấy nét
  -> Chụp ảnh và cắt vùng hóa đơn
  -> ML Kit nhận dạng chữ trên thiết bị
  -> Parser trích xuất tổng tiền, ngày, tên cửa hàng
  -> Người dùng xem lại, sửa dữ liệu và chọn danh mục
  -> Kiểm tra dữ liệu đầu vào
  -> Lưu giao dịch và ảnh/thumbnail vào bộ nhớ cục bộ
  -> Cập nhật danh sách, tổng chi tiêu và biểu đồ
```

**Nguyên tắc bắt buộc:** luôn có bước review/chỉnh sửa trước khi ghi giao dịch từ OCR vào cơ sở dữ liệu. Văn bản OCR chưa được kiểm tra không phải dữ liệu đã xác nhận.

Luồng quản lý sau khi lưu: xem danh sách -> xem chi tiết -> sửa hoặc xóa -> cập nhật cơ sở dữ liệu và thống kê. CRUD được nêu trong rubric tuần 7 và sơ đồ tuần 8.

## 4. Yêu cầu chức năng chi tiết

### FR-01. Chụp ảnh và cắt ảnh hóa đơn

**Bắt buộc theo đề [A]:**

- Có màn hình camera với hình ảnh xem trước trực tiếp.
- Cho phép bật/tắt flash.
- Cho phép chạm vào vùng xem trước để lấy nét.
- Hiển thị khung định vị/crop overlay để căn hóa đơn.
- Có chức năng chụp và cắt ảnh hóa đơn.

**Đề xuất triển khai/nghiệm thu:**

- Xin quyền camera khi người dùng mở chức năng quét; thông báo rõ nếu quyền bị từ chối.
- Sau khi chụp, cho phép xem lại, điều chỉnh vùng cắt, xác nhận hoặc chụp lại.
- Ảnh đưa vào OCR phải tương ứng với vùng cắt đã xác nhận; khung trang trí không thay thế thao tác cắt thật.
- Nếu thiết bị không hỗ trợ flash/lấy nét theo điểm, phản ánh trạng thái đó trên giao diện và ghi rõ giới hạn khi demo.
- Khi hủy chụp hoặc rời màn hình, không tạo giao dịch nháp thành bản ghi chính thức.

### FR-02. Nhận dạng văn bản trên thiết bị

**Bắt buộc theo đề [A, B, C]:**

- Tích hợp `google_mlkit_text_recognition` để nhận dạng văn bản từ ảnh hóa đơn.
- OCR hoạt động ngoại tuyến, xử lý trên thiết bị và không phát sinh chi phí gọi OCR đám mây.
- Chuyển văn bản OCR sang bộ parser tự xây dựng.
- Đề nêu mục tiêu **thời gian trích xuất dưới 100 ms**.

**Đề xuất triển khai/nghiệm thu:**

- Có trạng thái “Đang nhận dạng”; hạn chế gửi nhiều yêu cầu OCR trùng nhau.
- Nếu không nhận được chữ, cho phép chụp lại hoặc nhập/chỉnh sửa thông tin thủ công.
- Kiểm tra khả năng OCR khi tắt mạng và ghi rõ điều kiện cài đặt/khởi tạo mô hình nếu có.
- Đo riêng thời gian nhận dạng, thời gian parser và thời gian toàn luồng. Không tính thời gian người dùng chụp/crop vào chỉ số OCR.
- Ghi thiết bị, chế độ build, kích thước ảnh và phân biệt lần chạy đầu với các lần tiếp theo. Chỉ kết luận đạt dưới 100 ms khi có số đo; đề không quy định thiết bị, tập ảnh hay cách tổng hợp chỉ số này.

### FR-03. Parser tổng tiền bằng regex và heuristic

**Bắt buộc theo đề [A, B, C]:**

- Tự viết parser, sử dụng regex và quy tắc suy luận để tìm tổng tiền thanh toán.
- Xử lý được các cách biểu diễn như `150,000 VND` và `150.000 đ`.
- Tuần 8 còn minh họa các nhãn `TOTAL`, `Tổng tiền`, `Thanh toán`, `amount due` và số không có dấu phân nhóm như `150000`.

**Đề xuất quy tắc xử lý:**

1. Chuẩn hóa khoảng trắng và chữ hoa/thường; tạo bản không dấu để dò từ khóa tiếng Việt nếu cần, đồng thời giữ văn bản gốc.
2. Tìm các dòng có nhãn tổng tiền/thành tiền cần thanh toán.
3. Xét số tiền cùng dòng hoặc dòng liền kề trong trường hợp OCR tách nhãn và giá trị.
4. Loại hoặc hạ ưu tiên các dòng tạm tính, tiền khách đưa, tiền thừa, VAT, giảm giá, số điện thoại và mã hóa đơn.
5. Chuẩn hóa dấu phân nhóm với quy tắc VND rõ ràng: `150,000`, `150.000`, `150000` cùng biểu diễn 150000 đồng trong phạm vi này.
6. Khi nhiều ứng viên mâu thuẫn hoặc không tìm được tổng tiền, chuyển sang review với trạng thái cần người dùng kiểm tra; không mặc định lấy số lớn nhất.

Không xóa mọi dấu chấm/phẩy một cách vô điều kiện nếu chưa phân biệt dấu thập phân. Nếu chỉ hỗ trợ VND nguyên đồng, cần nêu rõ phạm vi đó và yêu cầu xác nhận đối với chuỗi mơ hồ.

### FR-04. Parser ngày giao dịch và tên cửa hàng

**Bắt buộc theo đề [A, B]:**

- Trích xuất ngày giao dịch theo định dạng `DD/MM/YYYY`.
- Trích xuất tên cửa hàng/đơn vị bán hàng từ nội dung hóa đơn.

**Đề xuất triển khai/nghiệm thu:**

- Với ngày: nhận diện chuỗi phù hợp rồi kiểm tra ngày thực tế, không chấp nhận `31/02/2026` chỉ vì khớp regex.
- Với tên cửa hàng: ưu tiên các dòng đầu hóa đơn; loại các dòng chỉ gồm số, số điện thoại, địa chỉ hoặc tiêu đề chung như “HÓA ĐƠN”.
- Giữ tên hiển thị từ văn bản gốc để không làm mất dấu tiếng Việt.
- Nếu thiếu ngày hoặc tên cửa hàng, để người dùng bổ sung. Nếu dùng ngày hiện tại làm gợi ý, phải phân biệt đó là giá trị gợi ý, không phải ngày đã đọc được.
- Không yêu cầu độ chính xác tuyệt đối với mọi mẫu hóa đơn; cần ghi rõ lỗi và giới hạn đã quan sát được.

### FR-05. Review và chỉnh sửa trước khi lưu

**Bắt buộc theo đề [A, B, C]:** có màn hình/form cho người dùng kiểm tra và sửa kết quả OCR trước khi lưu.

**Nội dung form đề xuất:**

| Trường | Hành vi |
|---|---|
| Ảnh hóa đơn | Hiển thị để đối chiếu dữ liệu |
| Tên cửa hàng | Điền từ parser, cho sửa hoặc nhập bổ sung |
| Tổng tiền | Điền từ parser, cho sửa; hiển thị đơn vị VND |
| Ngày giao dịch | Điền từ parser, cho chọn lại ngày |
| Danh mục | Người dùng chọn/xác nhận một trong năm danh mục bắt buộc |
| Ghi chú | Tùy chọn mở rộng |

**Đề xuất validation:** tên cửa hàng không rỗng sau khi trim; tổng tiền là số hợp lệ và lớn hơn 0; ngày tồn tại; danh mục hợp lệ. Đây cũng phù hợp với ví dụ kiểm tra form ở tuần 8, trang 26–28.

Khi dữ liệu sai, báo lỗi tại trường và giữ nội dung đang nhập. Nút lưu chỉ tạo một giao dịch cho một lần xác nhận; sau khi lưu thành công mới thông báo và điều hướng tiếp.

### FR-06. Cơ sở dữ liệu và vòng đời giao dịch

**Bắt buộc theo đề/rubric [A, B, C]:**

- Lưu dữ liệu bền vững bằng cơ sở dữ liệu cục bộ.
- Hỗ trợ CRUD: tạo, đọc, cập nhật và xóa giao dịch.
- Phân loại chi tiêu theo năm danh mục:

| Giá trị theo đề | Nhãn tiếng Việt gợi ý |
|---|---|
| Food | Ăn uống |
| Study | Học tập |
| Travel | Đi lại/du lịch |
| Gear | Thiết bị/đồ dùng |
| Entertainment | Giải trí |

Đề không bắt buộc tự động phân loại bằng AI; cho người dùng chọn danh mục đáp ứng phần phân loại. Có thể gợi ý danh mục như một mở rộng.

**Đề xuất triển khai/nghiệm thu:**

- Danh sách thể hiện cửa hàng, số tiền, ngày, danh mục và thumbnail.
- Có thể mở chi tiết giao dịch để xem lại và sửa dữ liệu.
- Khi xóa, có bước xác nhận hoặc cơ chế hoàn tác phù hợp.
- Sau thêm/sửa/xóa, danh sách và biểu đồ phản ánh cùng dữ liệu.
- Tắt rồi mở lại ứng dụng vẫn đọc được giao dịch đã lưu; không chỉ giữ dữ liệu trong state.
- Xử lý lỗi ghi/đọc cơ sở dữ liệu; không hiển thị lưu thành công khi thao tác ghi thất bại.

### FR-07. Lưu ảnh và cache thumbnail

**Bắt buộc theo đề [A, B]:** lưu ảnh hóa đơn và cache thumbnail trong thư mục lưu trữ của ứng dụng.

**Đề xuất triển khai/nghiệm thu:**

- Sao chép ảnh cần giữ vào thư mục dữ liệu ứng dụng thay vì phụ thuộc vào đường dẫn tạm của camera.
- Lưu đường dẫn hoặc khóa tham chiếu ảnh trong bản ghi giao dịch.
- Dùng thumbnail cho danh sách; có thể xem ảnh lớn ở màn hình chi tiết/review.
- Ảnh vẫn hiển thị sau khi mở lại ứng dụng; nếu ảnh mất/hỏng, dùng placeholder và vẫn cho xem thông tin giao dịch.
- Khi xóa giao dịch, xử lý ảnh liên quan theo chính sách rõ ràng để tránh tệp không còn được sử dụng.

### FR-08. Biểu đồ tròn/vành khuyên theo danh mục

**Bắt buộc theo đề [A, B, C]:**

- Vẽ biểu đồ pie hoặc donut biểu diễn phân bố chi tiêu theo danh mục.
- Dùng `CustomPainter`, vẽ trực tiếp trên canvas, có hoạt ảnh.
- Mục tiêu học tập còn yêu cầu tính tương tác; kiểu tương tác cụ thể không được đề quy định.
- Không dùng thư viện chart bên thứ ba thay cho phần tự vẽ.

**Đề xuất triển khai/nghiệm thu:**

- Tổng hợp số tiền từng danh mục; tỷ trọng = tổng tiền danh mục / tổng tiền trong phạm vi thống kê.
- Hiển thị chú giải màu, tên danh mục, số tiền và/hoặc phần trăm.
- Chạm vào lát biểu đồ hoặc chú giải để xem/highlight danh mục tương ứng.
- Khi thêm/sửa/xóa giao dịch, cập nhật số liệu và hoạt ảnh đúng trạng thái mới.
- Khi không có dữ liệu, hiển thị trạng thái rỗng và tránh phép chia cho 0.

### FR-09. Biểu đồ cột chi tiêu theo tuần

**Bắt buộc theo đề [A, B]:** vẽ weekly spending bar chart bằng `CustomPainter`, có hoạt ảnh. Bổ sung tương tác để đáp ứng mục tiêu học tập trong ảnh.

**Quy ước triển khai đề xuất, do đề chưa định nghĩa chi tiết “weekly”:**

- Một biểu đồ gồm 7 cột cho thứ Hai đến Chủ nhật của tuần đang xem.
- Mỗi cột là tổng số tiền giao dịch của ngày đó; ngày không có giao dịch có giá trị 0.
- Dựa trên **ngày giao dịch**, không dựa trên thời điểm chụp hoặc thời điểm tạo bản ghi.
- Có nhãn ngày, đơn vị tiền và tương tác chạm để xem số tiền chính xác.
- Có thể thêm chọn tuần trước/sau; đây là tiện ích đề xuất, không phải yêu cầu được nêu trực tiếp.
- Hai biểu đồ nên thể hiện rõ khoảng thời gian áp dụng để người dùng đối chiếu được số liệu.

### FR-10. Giao diện và quản lý trạng thái

**Bắt buộc theo rubric [B]:** Material 3, dark mode, responsive layout, kiến trúc quản lý trạng thái bằng Provider hoặc Riverpod 2 rõ ràng.

**Đề xuất triển khai/nghiệm thu:**

- Có cả giao diện sáng và tối, chữ và dữ liệu biểu đồ dễ đọc ở cả hai chế độ.
- Form cuộn được khi bàn phím mở; bố cục không tràn ở các kích thước điện thoại kiểm tra.
- Các màn hình có trạng thái đang tải, rỗng, thành công và lỗi phù hợp.
- Tách state cục bộ như flash/focus/animation khỏi state dùng chung như danh sách giao dịch và thống kê.
- Giải phóng camera, bộ nhận dạng, animation controller và text controller khi không còn dùng; không cập nhật màn hình đã bị đóng.

## 5. Đề xuất cấu trúc màn hình và dữ liệu

Phần này cụ thể hóa cách triển khai; đề không bắt buộc đúng số màn hình hay tên trường dưới đây.

### 5.1. Màn hình

| Màn hình | Nội dung chính |
|---|---|
| Tổng quan/thống kê | Tổng chi tiêu, donut/pie, biểu đồ tuần, nút quét hóa đơn |
| Camera | Preview, flash, lấy nét theo điểm, khung crop, chụp |
| Xem/cắt ảnh | Kiểm tra ảnh, chọn vùng cắt, chụp lại, tiếp tục OCR |
| Review | Ảnh và form sửa cửa hàng, tiền, ngày, danh mục |
| Danh sách giao dịch | Các giao dịch đã lưu và thumbnail |
| Chi tiết/chỉnh sửa | Xem ảnh, xem dữ liệu, cập nhật hoặc xóa |

Có thể gộp màn hình nếu vẫn giữ đầy đủ hành vi và luồng rõ ràng.

### 5.2. Mô hình giao dịch đề xuất

| Trường | Kiểu dữ liệu gợi ý | Ý nghĩa |
|---|---|---|
| `id` | integer hoặc string | Định danh duy nhất |
| `merchantName` | string | Tên cửa hàng đã xác nhận |
| `amountVnd` | integer | Số tiền nguyên đồng, tránh sai số số thực |
| `transactionDate` | date hoặc chuỗi `YYYY-MM-DD` | Ngày trên hóa đơn, không kèm chuyển đổi múi giờ ngoài ý muốn |
| `category` | enum/string | Một trong năm danh mục quy định |
| `receiptImagePath` | string | Tham chiếu ảnh hóa đơn trong bộ nhớ ứng dụng |
| `thumbnailPath` | string | Tham chiếu ảnh thu nhỏ |
| `rawOcrText` | string, tùy chọn | Văn bản gốc hỗ trợ đối chiếu/debug |
| `note` | string, tùy chọn | Ghi chú người dùng |
| `createdAt`, `updatedAt` | timestamp | Thời điểm tạo và cập nhật bản ghi |

Kết quả parser trước review nên cho phép trường rỗng/không xác định. Chỉ chuyển thành giao dịch hợp lệ sau khi người dùng bổ sung và xác nhận.

### 5.3. Tổ chức mã nguồn

Checklist tuần 8 yêu cầu repository có kiến trúc rõ ràng và nêu các thư mục `core/`, `models/`, `services/`, `state/`, `widgets/`, `screens/`. Có thể tổ chức như sau:

```text
lib/
  core/       # Theme, constants, định dạng tiền/ngày, điều hướng
  models/     # Expense, Category, ParsedReceipt
  services/   # Camera/ảnh, OCR, parser, cơ sở dữ liệu
  state/      # Provider hoặc Riverpod và dữ liệu thống kê
  widgets/    # Form, thẻ giao dịch, CustomPainter của các biểu đồ
  screens/    # Camera, review, danh sách, chi tiết, tổng quan
  main.dart
```

Parser nên là logic Dart tách khỏi UI để kiểm tra độc lập; painter nhận dữ liệu tổng hợp thay vì tự truy vấn cơ sở dữ liệu. Đây là đề xuất về trách nhiệm từng thành phần, không phải yêu cầu dùng một kiến trúc nhiều tầng cố định.

## 6. Bộ tiêu chí nghiệm thu đề xuất

Bảng sau chuyển các yêu cầu thành tình huống kiểm tra. Không có nghĩa các tình huống đã được chạy hoặc đã đạt.

| ID | Tình huống | Kết quả mong đợi |
|---|---|---|
| TC-01 | Mở camera trên thiết bị thật | Có preview, chụp được; flash và chạm lấy nét hoạt động trên thiết bị hỗ trợ |
| TC-02 | Chụp rồi chọn vùng crop | Ảnh đầu vào OCR phản ánh đúng vùng đã chọn |
| TC-03 | Từ chối quyền camera | Có hướng dẫn phù hợp, ứng dụng không crash |
| TC-04 | OCR hóa đơn khi tắt mạng | Vẫn nhận dạng được trong điều kiện mô hình đã sẵn sàng; ghi rõ điều kiện kiểm tra |
| TC-05 | Parser nhận `TOTAL: 150,000 VND` | Gợi ý tổng tiền 150000 |
| TC-06 | Parser nhận `Tổng tiền: 150.000 đ` | Gợi ý tổng tiền 150000, nhận diện được nhãn tiếng Việt |
| TC-07 | Parser nhận `Thanh toán: 150000` | Gợi ý toàn bộ giá trị 150000, không lấy một phần chuỗi số |
| TC-08 | Có tạm tính 140000, tổng 150000, khách đưa 200000, trả lại 50000 | Ưu tiên 150000; không chọn 200000 chỉ vì lớn nhất |
| TC-09 | Ngày `09/10/2026` và `31/02/2026` | Ngày đầu hợp lệ; ngày sau cần sửa |
| TC-10 | Thiếu tổng tiền/ngày/tên cửa hàng | Cho bổ sung ở review; không tạo dữ liệu chắc chắn giả |
| TC-11 | Người dùng sửa kết quả OCR rồi lưu | DB giữ dữ liệu đã sửa, không lấy lại giá trị OCR cũ |
| TC-12 | Bấm lưu liên tiếp hoặc hủy review | Không tạo bản ghi trùng do thao tác lặp; hủy không lưu giao dịch |
| TC-13 | Thêm, mở lại, sửa và xóa giao dịch | CRUD hoạt động; dữ liệu tồn tại sau khi khởi động lại |
| TC-14 | Mở lại danh sách và chi tiết sau khi khởi động lại | Thumbnail và ảnh hóa đơn còn đọc được |
| TC-15 | Food 100000, Study 50000, Travel 50000 | Tổng 200000; tỷ trọng tương ứng 50%, 25%, 25% |
| TC-16 | Thêm giao dịch vào các ngày khác nhau trong tuần | Mỗi cột đúng tổng ngày; ngày không chi tiêu bằng 0 |
| TC-17 | Chạm biểu đồ và thay đổi giao dịch | Có phản hồi tương tác, hoạt ảnh và số liệu cập nhật |
| TC-18 | Chưa có giao dịch hoặc vừa xóa hết | Giao diện rỗng rõ ràng, biểu đồ không lỗi chia cho 0 |
| TC-19 | Đổi sáng/tối, mở bàn phím trên màn hình nhỏ | Nội dung đọc được, thao tác được, không tràn bố cục |
| TC-20 | Đo thời gian OCR trên tập ảnh thử | Có số đo và điều kiện đo để đánh giá mục tiêu dưới 100 ms |
| TC-21 | Cài bản APK release đã ký trên điện thoại thật | Hoàn thành luồng chụp -> OCR -> review -> lưu -> biểu đồ |

Nên kiểm tra parser bằng dữ liệu văn bản cố định, kiểm tra phép tổng hợp biểu đồ bằng dữ liệu biết trước, và kiểm tra camera/OCR/ảnh lưu bằng thiết bị thật. Cần phân biệt lỗi nhận dạng chữ với lỗi parser để báo cáo đúng nguyên nhân.

## 7. Thang điểm chính thức trong bài giảng tuần 7

Nguồn: Week-07-Flutter-Part1.pdf, trang 42. Tài liệu không chia điểm nhỏ hơn cho từng tính năng con.

| Nhóm | Tiêu chí | Điểm |
|---|---|---:|
| On-Device OCR & Heuristics | Camera, ML Kit, regex trích xuất tổng tiền, ngày, tên cửa hàng | 3.5 |
| Custom Canvas Visualization | Pie/donut theo danh mục và bar chart theo tuần, tự vẽ có hoạt ảnh bằng CustomPainter | 2.5 |
| State Management & DB | Provider hoặc Riverpod 2 rõ ràng, sqflite CRUD bền vững, lưu ảnh hóa đơn | 2.0 |
| UI/UX Polish | Material 3, dark mode, responsive, review và sửa thủ công | 1.0 |
| Deliverables & Report | APK release đã ký, video, GitHub sạch, PDF 2–4 trang | 1.0 |
| **Tổng** | | **10.0** |

## 8. Sản phẩm bắt buộc phải nộp

### 8.1. APK và video demo

**APK:**

- Có tệp `app-release.apk` là bản release đã ký.
- Có liên kết tải qua GitHub Releases hoặc Google Drive.
- Đã kiểm tra trên điện thoại Android thật theo checklist tuần 8.
- Đề xuất kiểm tra lại quyền truy cập liên kết trước khi nộp.

**Video:**

- Thời lượng **2–3 phút** theo tuần 8, trang 43.
- Thể hiện chụp trực tiếp hóa đơn thật, OCR và regex trích xuất, review/xác nhận, lưu dữ liệu, donut cập nhật có hoạt ảnh.
- Đề xuất cho thấy thêm biểu đồ cột và một lần sửa dữ liệu để chứng minh luồng hoàn chỉnh.

Kịch bản thời gian tham khảo: 15 giây giới thiệu; 40 giây chụp/crop/OCR; 40 giây review và lưu; 35 giây danh sách và biểu đồ; 20–30 giây chế độ tối hoặc minh chứng bổ sung.

### 8.2. GitHub repository

- Repository **public**, chứa mã nguồn Flutter 3.x.
- Kiến trúc rõ ràng theo các nhóm thư mục đã nêu; lịch sử commit gọn, có ý nghĩa.
- `README.md` có hướng dẫn build theo đề và mô tả đủ để chạy lại dự án theo checklist tuần 8.

Nội dung README đề xuất: giới thiệu, tính năng, phiên bản SDK đã dùng, cài dependency, chạy ứng dụng, cấu hình cần thiết, build release, cách kiểm thử, giới hạn và các liên kết APK/video/báo cáo.

Các lệnh cơ bản có thể ghi trong README sau khi kiểm tra với dự án thực tế:

```bash
flutter pub get
flutter run
flutter build apk --release
```

Lệnh build release không tự chứng minh bản phát hành đã được cấu hình ký đúng. Cần mô tả cấu hình ký phù hợp; không đưa khóa ký riêng hoặc mật khẩu vào repository public. Các lệnh này là hướng dẫn dự kiến, chưa được chạy trong tài liệu yêu cầu này.

### 8.3. Báo cáo kỹ thuật PDF

- Độ dài **2–4 trang**.
- Theo cấu trúc [Mini-Project-3-Report-Template.md](Mini-Project-3-Report-Template.md).
- Bổ sung các nội dung tuần 8 yêu cầu: **sơ đồ kiến trúc, bảng regex OCR, ảnh giao diện sáng/tối và giới hạn**.

| Phần của template | Nội dung cần điền cho Mini-Project 3 |
|---|---|
| Thông tin đầu báo cáo | Môn học, tên đề tài, nhóm/sinh viên, ngày nộp |
| 1. General Information & Deliverable Links | Họ tên, mã sinh viên, vai trò, tỷ lệ đóng góp; link APK, GitHub và video |
| 2. Feature Implementation Checklist | Các chức năng thật của đề: camera/crop, OCR, parser, review, CRUD/ảnh, hai biểu đồ, sáng/tối; ghi trạng thái thực tế và mức đạt |
| 3. Technical Architecture & Project Structure | Sơ đồ luồng, cấu trúc thư mục, state management, xử lý lỗi; bảng regex/quy tắc và ví dụ đầu vào/đầu ra |
| 4. Empirical Evidence & Screenshots | 3–4 ảnh ứng dụng chạy trên giả lập hoặc thiết bị thật, có chú thích; bao gồm sáng/tối và luồng chính; thêm số đo OCR nếu có |
| 5. Technical Challenges & Resolutions | 1–2 khó khăn thực tế, cách xử lý, hạn chế còn lại |

Không giữ các tính năng ví dụ không liên quan trong template như background sync. Không đánh dấu “Complete” hoặc ghi chỉ số hiệu năng khi chưa có minh chứng.

## 9. Thời hạn theo tài liệu

Week-08-Flutter-Part2.pdf, trang 43 ghi:

- Hạn nộp: **cuối tuần học thứ 8, Chủ nhật lúc 23:59**.
- Nộp trễ: **trừ 1 điểm mỗi ngày**.

Các tài liệu được cung cấp không xác định ngày dương lịch tương ứng của tuần học thứ 8. Cần đối chiếu lịch lớp/LMS; không suy ra ngày nộp từ ngày tạo file hoặc ngày hiện tại.

## 10. Checklist tổng hợp trước khi nộp

- [ ] Flutter 3.x, Dart 3; ứng dụng chạy trên Android thật.
- [ ] Camera trực tiếp, flash, chạm lấy nét, khung crop và xử lý cắt ảnh.
- [ ] ML Kit Text Recognition hoạt động ngoại tuyến.
- [ ] Parser tự viết lấy tổng tiền, ngày và tên cửa hàng.
- [ ] Xử lý được các ví dụ số tiền trong đề và tình huống nhiều số tiền.
- [ ] Người dùng review/sửa trước khi lưu.
- [ ] Đủ năm danh mục Food, Study, Travel, Gear, Entertainment.
- [ ] CRUD bền vững; ảnh và thumbnail được lưu trong bộ nhớ ứng dụng.
- [ ] Provider hoặc Riverpod 2 được tổ chức rõ ràng.
- [ ] Pie/donut và weekly bar chart tự vẽ bằng CustomPainter, có hoạt ảnh và tương tác.
- [ ] Không sử dụng thư viện biểu đồ bên thứ ba cho hai biểu đồ bắt buộc.
- [ ] Material 3, sáng/tối, bố cục đáp ứng.
- [ ] Có minh chứng đánh giá mục tiêu OCR dưới 100 ms, ghi trung thực phần chưa đạt.
- [ ] APK release đã ký, link tải truy cập được, đã kiểm tra trên thiết bị thật.
- [ ] Video demo dài 2–3 phút, chứng minh luồng quét và biểu đồ cập nhật.
- [ ] Repository public, README có lệnh build và hướng dẫn chạy.
- [ ] PDF 2–4 trang đúng mẫu, đủ sơ đồ, bảng regex, 3–4 ảnh có chú thích, sáng/tối và giới hạn.
- [ ] Đối chiếu hạn nộp chính xác trên lịch lớp/LMS.

**Phạm vi của file này:** tài liệu phân tích yêu cầu và đề xuất nghiệm thu; không phải báo cáo kết quả triển khai, không thay thế báo cáo PDF cuối kỳ.
