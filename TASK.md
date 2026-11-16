# Mobile (Flutter): chức năng theo vai trò

Cập nhật: 16/11/2026.

Căn cứ:

- Frontend đã làm: `AI_Storytelling_Frontend/TASKS.md` (22 chức năng F-01 → F-22 của tài liệu 6).
- Thiết kế mobile: mục "Mobile (Flutter)" trong `DESIGN.md` ở thư mục gốc dự án.
- Sản phẩm: `PRODUCT.md` (người dùng chính là Phụ huynh và Bé).
- API: REST `/api/v1`. Hàm gọi API tham khảo từ `AI_Storytelling_Frontend/src/app/services/*.ts`, kiểu dữ liệu từ `src/app/types/*.ts`.

Phạm vi đã chốt (15/11): app mobile **chỉ dành cho Bé và Phụ huynh, không dùng để tạo truyện**.

- **Bé**: trọng tâm là trải nghiệm đọc (màn đọc, nghe, tương tác, quiz, phần thưởng, điều ước).
- **Phụ huynh**: xem thống kê học tập và quản lý thông tin của bé; giao máy cho bé đọc.
- Tạo truyện (Studio AI, nhập truyện, tự viết), sửa lộ trình, gói và thanh toán, Creator, Moderator, Admin: dùng web.

Ký hiệu: `[x]` xong · `[ ]` chưa làm · **Một phần** ghi rõ còn thiếu gì.

---

## Cấu trúc thư mục

```
lib/
├─ core/
│  ├─ config/        API_URL, USE_MOCK (--dart-define)
│  ├─ network/       dio, interceptor tự refresh token, xử lý lỗi → toast
│  ├─ storage/       flutter_secure_storage (token, phiên của bé)
│  ├─ router/        go_router, StatefulShellRoute (thanh đáy), route Chế độ của bé
│  ├─ theme/         TtColors (light/dark), TextTheme, ttRadius
│  ├─ widgets/       component dùng chung (nút, thẻ, toast, popup xác nhận, ảnh mặc định, ếch)
│  └─ utils/
├─ models/           freezed + json_serializable, sinh từ types/*.ts của web
└─ features/
   ├─ auth/          đăng nhập, đăng ký, xác thực email, quên / đặt lại mật khẩu
   ├─ home/          trang chủ phụ huynh: "Cho bé đọc", tóm tắt hôm nay của từng bé
   ├─ children/      hồ sơ bé, Learning Profile, vòng đời hồ sơ
   ├─ safety/        Safety Policy
   ├─ access/        mã QR EasyLogin, giao máy cho bé
   ├─ learning/      thống kê học tập của bé: tổng quan, kết quả đọc, lộ trình (chỉ xem)
   ├─ wishes/        điều ước của bé (phía phụ huynh, chỉ xem)
   ├─ account/       hồ sơ tài khoản, phiên đăng nhập, đổi mật khẩu / email
   ├─ notifications/ thông báo trong app và thông báo đẩy
   └─ kid/
      ├─ entry/      quét QR EasyLogin
      ├─ home/       trang chính của bé: truyện hôm nay, hành trình, kệ truyện
      ├─ reader/     màn đọc, giọng đọc, tương tác khi nghe, luyện đọc to
      ├─ quiz/       quiz, cảm xúc, kể lại, cảnh còn thắc mắc
      ├─ rewards/    EXP, huy hiệu, cây tri thức, sổ tay từ vựng
      ├─ wish/       gửi điều ước bằng thẻ
      └─ gate/       cổng phụ huynh
assets/
├─ fonts/            Baloo 2, Nunito (có tiếng Việt, đóng gói sẵn)
├─ images/           ảnh mặc định, đầm sen
└─ rive/             linh vật ếch
```

---

## Giai đoạn 1: Nền tảng

- [x] Thêm package: `go_router`, `flutter_riverpod`, `dio`, `flutter_secure_storage`, `freezed`, `json_serializable`, `flutter_animate`, `rive`.
- [x] Theme: `TtColors` light / dark theo token của web (`styles/tokens.css`), font Baloo 2 + Nunito, có màu vàng mật `#ffd166`.
- [x] API client: base URL, gắn token, tự refresh token, đổi mã lỗi thành câu dễ hiểu và hiện bằng toast.
- [x] Component dùng chung: nút (lá sen), thẻ có viền rõ và nền trong suốt, popup xác nhận, toast, ảnh có hình mặc định, trạng thái rỗng / đang tải.
- [x] Router: khu phụ huynh có thanh đáy; Chế độ của bé là route toàn màn hình, không có thanh đáy.
- [x] Thanh đáy phụ huynh: **Trang chủ · Bé · Học tập · Tài khoản** (bỏ tab "(+) Tạo" và "Thư viện"; tab Học tập tạm là màn trống tới giai đoạn 4). Đã xoá thư mục rỗng `studio/`, `stories/`, `library/`, `payment/`, `roadmap/`.
- [x] Đăng nhập, đăng ký, xác thực email, quên / đặt lại mật khẩu (nhập mã OTP gửi qua email, như web).
- [x] Chặn tài khoản Moderator / Admin / Creator ở mobile: báo dùng web.
- [x] Linh vật ếch (SVG chuyển từ `Frog.tsx` của web: idle / happy / think) trong `TtFrog`.
- [x] Thêm nền tảng web (`web/`) chỉ để chụp màn hình kiểm tra UI bằng Playwright; app chính vẫn là Android / iOS. Chạy thử trên web cần Backend cho phép CORS origin localhost (hiện chưa có, app thật không bị).
- [x] Nút đăng nhập có hiện vòng quay khi đang gửi (đã có test `login_loading_test.dart`; ghi chú cũ là do lúc chụp màn hình bản build web bị thiếu file).

## Giai đoạn 2: Bé, trải nghiệm đọc (F-02, F-08, F-13, F-14)

Tham khảo web: `features/kid/*`, `childAccessService.ts`, `childReadingService.ts`, `storyWishService.ts`.

- [x] Vào app bằng quét QR EasyLogin (đọc link `?kid=` của web hoặc mã trần; lỗi / khoá do Backend trả hiện bằng toast). Chưa thử camera thật.
- [x] Phụ huynh giao máy: tab Bé có danh sách hồ sơ + nút "Cho bé đọc" (`POST /ChildAccessCredential/{id}/handover`); mở lại app vẫn ở Chế độ của bé. Chưa có "Cho bé đọc ngay" kèm truyện (giai đoạn 3).
- [x] Cổng phụ huynh khi thoát (`POST /ParentalGate/verify`) khi `parentalGateEnabled` bật; chặn nút Back của Android. Phiên bé hết hạn → màn "Phiên đọc đã kết thúc".
- [x] Trang chính của bé (bố cục A đã chốt): thẻ "Hôm nay em đọc", hàng lá sen hành trình (`GET /MyRoadmap`), lưới 2×2; bốn ô mở Thư viện, Sổ tay, Điều ước, Phần thưởng.
- [x] Thư viện của bé (`GET /child/reading/stories`, trang đánh số từ 1 như Backend): lưới bìa, tìm kiếm, tải thêm khi cuộn, nút xoá nhanh ô tìm kiếm.
- [x] Hỏi lại phiên bé định kỳ như web: kiểm tra mỗi 15 giây, chỉ gọi `GET /ChildAccessCredential/me` (tối đa 1 lần/phút) khi bé vừa chạm màn hình; 20 phút không hoạt động → "Phiên đọc đã kết thúc". Mất mạng thì giữ phiên.
- [x] Ảnh bìa có đuôi `#crop=x,y,w,h`: `TtNetworkImage` tự cắt đúng vùng như web.
- [x] Màn đọc (bố cục A: tranh trên, chữ dưới, thanh ◀ 🔊 🎤 ▶ ở đáy): xong vuốt lật trang, ListenFirst / ReadFirst, phát giọng đọc có sẵn (`just_audio`, tô sáng đoạn đang đọc), từ vựng (xem nghĩa, cất vào sổ tay), lưu tiến độ (1-based, tối đa 600 giây/lần), dấu trang, yêu thích, theo dõi tín hiệu dừng đọc (`/signal` mỗi 8 giây), sự kiện `PageCompleted` / `TtsStarted` / `TtsCompleted`, nút "Em đọc xong rồi" → màn +EXP. Bố cục theo màn (`KidReaderLayout`): dọc = tranh trên chữ dưới (máy tính bảng dọc rộng tối đa 720); điện thoại ngang = tranh trái sát mép trên, chữ phải tự cuộn; máy tính bảng ngang = sách mở (phương án A, chốt 16/11): tranh trang trái, chữ trang phải, gáy sách, ếch đồng hành ở góc (nghĩ khi đang ghi âm / chấm, vui khi có kết quả hoặc giọng kể đang đọc).
- [x] 5 loại tương tác khi nghe (kiểu Quizlet, toàn màn hình): Checkpoint, Đoán tranh, Nhập vai, Điền chữ, Xếp thứ tự. Hỏi khi nghe hết cảnh, chặn lật trang khi chưa trả lời; "Để sau" thì đọc tiếp; truyện chỉ nghe không hỏi.
- [x] Luyện đọc to bằng micro (giống web): bấm 🎤 dừng giọng kể và ghi âm đoạn đang đọc (WAV 16 kHz, tự dừng ở 3 MB, khoảng 98 giây, như web), đoạn đang ghi tô nền vàng; kết quả tô từng chữ (đúng: màu chính in đậm, cần đọc lại: nền vàng, bỏ qua: chữ mờ), lời khen / lỗi hiện bằng toast; bấm lần sau sang đoạn kế. Lật trang, thoát, mở tương tác, bật giọng kể hoặc ẩn app thì huỷ bản ghi, không gửi. Chưa thử ghi âm trên máy thật (web không ghi âm được).
- [x] Hoàn thành truyện (phương án A, từng bước toàn màn hình, có Bỏ qua): cảm xúc (kèm +EXP, huy hiệu mới, bước lộ trình) → quiz (đáp án xáo trộn, trả lời ngắn, kết quả, làm lại) → ghi âm kể lại (`record`, WAV 16 kHz, tự dừng ở 3 MB) → đánh dấu tối đa 5 cảnh còn thắc mắc. Giọng đọc đang phát cũng tính là bé đang hoạt động. Chưa thử ghi âm trên máy thật; trên web không ghi âm được (báo bằng toast). Huy hiệu mới hiện tên (tra từ phần thưởng như web).
- [x] Phần thưởng (phương án A: cây trên, huy hiệu dưới): EXP, chuỗi ngày đọc, cây tri thức 5 giai đoạn (`TtKnowledgeTree` chuyển từ web) và tưới cây, 7 huy hiệu lưới 2 cột. Sổ tay từ vựng: danh sách, xoá có xác nhận. Đọc xong mở bước lộ trình tiếp theo do Backend xử lý, mobile báo ở bước Cảm xúc.
- [x] Gửi điều ước bằng thẻ (phương án A: lưới thẻ + thanh đáy): Nhân vật → Nơi chốn → Thử thách → Bài học (hoặc "Để bố mẹ chọn"), phát âm thanh thẻ, danh sách điều ước đã gửi kèm nút đọc truyện. Gợi ý chỉ có truyện cộng đồng tạm ẩn (xem mục đọc truyện cộng đồng).
- [ ] Đọc truyện cộng đồng đã duyệt. Lưu ý: Backend `StartReadingRequestDto` chưa có `communitySubmissionId` (web và mobile đều gửi trường này) — cần hỏi Backend (kiểm tra lại 16/11: vẫn chưa có, mobile chưa làm được).
- [x] Nút tối thiểu 64dp, chữ nội dung 22sp trên các màn của bé (`kKidMinTap`). Màn đọc bật chế độ toàn màn hình (ẩn thanh trạng thái và thông báo), thoát thì trả lại. Thông báo đẩy của app (giai đoạn 4) phải không hiện khi bé đang ở Chế độ của bé. Chưa thử trên máy thật.
- [x] Luyện đọc to: chạm chữ cần đọc lại thì hiện gợi ý theo `hint` như web (sai dấu / chưa nghe rõ / đọc thành chữ khác / quên đọc).

### Lỗi giao diện phát hiện khi chụp màn hình (16/11)

- [x] Màn đọc ở khổ rộng (800): tranh bị lệch xuống dưới, góc trên trống. Đã sửa cùng bố cục sách mở / máy tính bảng dọc.
- [x] Màn tương tác "Đoán tranh": ô trắng là do ảnh chưa tải xong lúc chụp (chụp lại: cả hai ảnh đáp án trả 200 và hiện đủ), không phải lỗi.
- [x] Khổ 360: toast hiện đè lên thanh đáy ◀ 🔊 🎤 ▶ của màn đọc (toast ở màn đọc nâng lên 96dp, `showTtToast(bottomOffset:)`).

## Giai đoạn 3: Phụ huynh, thông tin của bé (F-01, F-02, F-12)

Tham khảo web: `features/children`, `features/safety`, `childProfileService.ts`, `guardianService.ts`, `profileLifecycleService.ts`.

- [ ] **Một phần** — Trang chủ (phương án A): lời chào theo giờ + ếch, mỗi bé đang hoạt động một thẻ ("📖 N hôm nay", truyện gần nhất kèm cảm xúc và % quiz từ `/ParentReadingFeedback`, bước tiếp theo từ `/ChildRoadmap`, nút "Cho bé đọc" dùng chung với tab Bé), lỗi của một bé chỉ hiện trong thẻ bé đó, kéo xuống để tải lại, màn rộng 2 cột. Còn thiếu: truyện làm dở.
- [ ] **Một phần** — Hồ sơ bé: tab Bé (phương án A: dải chọn bé, thẻ bé, lưới Hồ sơ / Học tập / An toàn / Mã QR), sửa, kích hoạt / tạm dừng / tiếp tục / lưu trữ / khôi phục, lịch sử hoạt động. Thêm bé bằng wizard toàn màn hình 4 bước (Bé → Học tập → An toàn → Xong), lỗi giữa chừng bấm lại không tạo trùng. Còn thiếu: chọn ảnh đại diện (đang dùng ảnh mặc định vì chưa có cách đổi `avatarId` ra ảnh).
- [x] Learning Profile: mức đọc, chế độ đọc, mục tiêu, chủ đề yêu thích / cần chú ý.
- [x] Safety Policy: các mục ảnh hưởng tới lúc bé đọc (cổng phụ huynh, điều ước, tương tác khi nghe, trả lời bằng giọng nói, chủ đề Cho phép / Chặn); đồng ý điều khoản. Tự lưu như web, luôn gửi đủ các trường (Backend ghi đè và không nhận null). Các mục chỉ dùng khi tạo truyện (chế độ duyệt, độ dài truyện, ngưỡng tự duyệt) để trên web.
- [x] Mã QR EasyLogin: tạo, tạo lại, thu hồi (`qr_flutter`, link `?kid=` giống web, nền trắng cả khi giao diện tối).
- [x] Tài khoản (phương án A): thẻ hồ sơ + sửa họ tên, Bảo mật (đổi mật khẩu, đổi email có mã OTP, phiên đăng nhập, lịch sử hoạt động), Xoá tài khoản mở trang web, đăng xuất.

## Giai đoạn 4: Phụ huynh, thống kê học tập (F-08)

Tham khảo web: `features/learning`, `roadmapService.ts`, `storyWishService.ts`.

- [ ] Tổng quan học tập của từng bé: EXP, chuỗi ngày đọc, số truyện đã đọc, huy hiệu, cây tri thức (số liệu lấy hoàn toàn từ API, không tự tính).
- [ ] Kết quả đọc từng truyện: câu trả lời quiz, cảm xúc, nghe bản kể lại, chỗ còn thắc mắc, xoá bản kể lại (có popup xác nhận).
- [ ] Tiến độ lộ trình của bé (chỉ xem; sửa lộ trình trên web).
- [ ] Điều ước bé đã gửi (chỉ xem; dùng truyện có sẵn / tạo truyện / từ chối làm trên web).
- [ ] Thông báo: danh sách, đánh dấu đã đọc, xoá; thông báo đẩy khi bé gửi điều ước, bé đọc xong truyện.

---

## Không làm trên mobile

- Tạo truyện: Studio AI, nhập truyện có sẵn, tự viết, Truyện của tôi, gửi cộng đồng, giao cho nhiều bé (F-06, F-07, F-09, F-10).
- Sửa lộ trình, thư viện lộ trình mẫu.
- Gói, lượt AI, thanh toán, lịch sử giao dịch (F-03, F-04, F-05).
- Creator, Moderator, Admin: dùng web.
- Ngoài phạm vi chung (tài liệu 6): đa ngôn ngữ, nhân bản giọng nói, đọc offline.

## Cần sửa trong DESIGN.md (mục Mobile)

- [x] Bỏ "3 chỉ số", "biểu đồ 7 ngày" và tab "Báo cáo" của phụ huynh (dashboard, báo cáo tuần đã bỏ).
- [x] Bỏ nút "Lưu trữ" ở màn Duyệt (đã bỏ thao tác lưu trữ truyện của phụ huynh).
- [x] Cài đặt an toàn tự lưu, bỏ nút "Lưu" cố định.
- [x] Theo phạm vi mới (15/11): thanh đáy là Trang chủ · Bé · Học tập · Tài khoản; bỏ màn Studio, Duyệt, Thư viện, Thanh toán của phụ huynh.
