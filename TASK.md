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
- [x] Thanh đáy phụ huynh: **Trang chủ · Sự kiện · Học tập · Tài khoản** (26/11: tab Tìm kiếm đổi thành Sự kiện; màn Tìm kiếm thành màn đẩy `/search` có nút quay lại, mở bằng nút 🔍 ở Trang chủ. 19/11: tab Bé đổi thành Tìm kiếm, quản lý bé chuyển vào Học tập; trước đó đã bỏ tab "(+) Tạo" và "Thư viện"). Đã xoá thư mục rỗng `studio/`, `stories/`, `library/`, `payment/`, `roadmap/`.
- [x] Đăng nhập, đăng ký, xác thực email, quên / đặt lại mật khẩu (nhập mã OTP gửi qua email, như web).
- [x] Chặn tài khoản Moderator / Admin / Creator ở mobile: báo dùng web.
- [x] Linh vật ếch (SVG chuyển từ `Frog.tsx` của web: idle / happy / think) trong `TtFrog`.
- [x] Tên app **Taletale** (26/11, như web): nhãn Android/iOS, tiêu đề `MaterialApp`, bản web Flutter, màn chờ. Icon launcher = mặt ếch như logo góc trang chủ web (`Frog variant="face"`, khung cắt `68 20 270 162`) trên nền `#1d2b24`: Android 5 cỡ `mipmap-*` (bo góc), iOS 15 cỡ (nền đặc, không alpha). Chưa làm icon adaptive Android 8+ và favicon bản web.
- [x] Ảnh mạng giải mã theo đúng cỡ khung (26/11, `TtNetworkImage` `cacheWidth` = cạnh dài × dpr) để cuộn Trang chủ bớt giật; khung đã có width/height thì không dùng LayoutBuilder (chạy được dưới `IntrinsicHeight`). Ảnh ngang hiện `cover` trong khung dọc có thể hơi mờ. Chưa đo bằng `--profile` trên máy thật.
- [x] Thêm nền tảng web (`web/`) chỉ để chụp màn hình kiểm tra UI bằng Playwright; app chính vẫn là Android / iOS. Chạy thử trên web cần Backend cho phép CORS origin localhost (hiện chưa có, app thật không bị).
- [x] Nút đăng nhập có hiện vòng quay khi đang gửi (đã có test `login_loading_test.dart`; ghi chú cũ là do lúc chụp màn hình bản build web bị thiếu file).

## Giai đoạn 2: Bé, trải nghiệm đọc (F-02, F-08, F-13, F-14)

Tham khảo web: `features/kid/*`, `childAccessService.ts`, `childReadingService.ts`, `storyWishService.ts`.

- [x] Vào app bằng quét QR EasyLogin (đọc link `?kid=` của web hoặc mã trần; lỗi / khoá do Backend trả hiện bằng toast). Chưa thử camera thật.
- [x] Phụ huynh giao máy: nút "Vào học" ở tab Học tập (bé đang chọn) và "Cho bé đọc" trong Quản lý bé (`POST /ChildAccessCredential/{id}/handover`); mở lại app vẫn ở Chế độ của bé. Chưa có "Cho bé đọc ngay" kèm truyện (giai đoạn 3).
- [x] Cổng phụ huynh khi thoát (`POST /ParentalGate/verify`) khi `parentalGateEnabled` bật; chặn nút Back của Android. Phiên bé hết hạn → màn "Phiên đọc đã kết thúc".
- [x] Trang chính của bé, sảnh "hai cột kẹp ếch" như web (19/11): thẻ Hôm nay (bấm là đọc, chưa có truyện thì mời chọn), ếch giữa trên lá sen (chạm thì nhún + đổi mặt), 4 nút tròn 3D ở góc (Hành trình → `/kid/journey` dùng lại dải lá sen `GET /MyRoadmap`, Sổ tay, Điều ước, Huy hiệu), hàng dưới Kho truyện · ĐỌC NGAY · Cây. Badge Huy hiệu / giọt nước của Cây từ `/child/rewards`, ẩn khi 0 hoặc lỗi. Vừa một màn ở 360×740 và 390×844 (đã chụp màn hình thật). Màn ngang (`kid_lobby_layout.dart`): tablet/ngang đủ cao xếp thẻ Hôm nay hẹp ở trên, hai cột nút sát hai bên ếch, hàng nút ngay dưới ếch, cụm rộng tối đa 900; điện thoại xoay ngang (cao < 520) đưa thẻ Hôm nay + hàng nút thành cột bên phải. Đã kiểm tra không tràn, đủ 7 nút ở 844×390, 740×360, 1024×768, 1180×820, 1366×1024.
  - Animation như web (chép thông số kid-lobby.css / Frog.tsx, dùng `flutter_animate` + `AnimationController`, không thêm thư viện): ếch vẽ bằng `CustomPainter` theo bộ phận (chớp mắt, thở, mắt nhìn theo ngón tay, nháy mắt / lè lưỡi / vẫy tay, chạm ếch xoay vòng hop · spin · squash · dance, đứng yên 8s thì cười mỉm, rung nhẹ thay tiếng "ộp"); bấm nút thì ếch làm động tác của nút; lá sen + hoa sen + quầng sáng lệch theo ngón tay; nút tròn nhấp nhô lệch pha, nghiêng theo ngón tay khi giữ, lún/nảy kiểu `kid-btn3d`; thẻ Hôm nay trôi, tên bé lắc lư, badge nảy. Tắt chuyển động lặp khi bật "giảm chuyển động". `KidBtn3D` ở mọi màn bé có nền chuyển sáng, viền 3px, bóng 6px.
  - Sửa trợ năng: nút sảnh, thẻ Hôm nay, ếch, thẻ truyện thư viện phụ huynh dùng `excludeSemantics` nhưng thiếu `onTap` nên TalkBack/VoiceOver không bấm được — đã gắn lại.
  - 20/11: bỏ thẻ Hôm nay (xoá `kid_today_card.dart`) và nút tròn Kho truyện; nút ĐỌC NGAY / CHỌN TRUYỆN vẫn mở Kho truyện khi chưa có truyện mở. Góc Huy hiệu thành cúp vàng chỉ để xem (`KidTrophyMedal`, số huy hiệu đã đạt, chưa tải được hiện "–"); `/kid/rewards` vẫn mở từ nút Cây. Hàng dưới còn ĐỌC NGAY · Cây; sân khấu ếch to hơn nhờ bỏ thẻ. Không tràn ở 7 khổ test (dọc + ngang).
  - 20/11: màn Hành trình (`kid_roadmap_strip.dart`) đổi sang đường dọc từ trên xuống: đã đọc (dấu tích) → truyện đang mở (khung viền vàng + ếch + nút phát/khoá) → sắp tới (khoá, mờ) → cờ đích / ngôi sao khi đọc hết; đường nối đoạn đã đi màu primary. Các chặng hiện dần lần lượt, mở màn tự cuộn tới chặng đang đọc.
- [x] Thư viện của bé (`GET /child/reading/stories`, trang đánh số từ 1 như Backend): lưới bìa, tìm kiếm, tải thêm khi cuộn, nút xoá nhanh ô tìm kiếm.
- [x] Hỏi lại phiên bé định kỳ như web: kiểm tra mỗi 15 giây, chỉ gọi `GET /ChildAccessCredential/me` (tối đa 1 lần/phút) khi bé vừa chạm màn hình; 20 phút không hoạt động → "Phiên đọc đã kết thúc". Mất mạng thì giữ phiên.
- [x] Ảnh bìa có đuôi `#crop=x,y,w,h`: `TtNetworkImage` tự cắt đúng vùng như web.
- [x] Màn đọc (bố cục A: tranh trên, chữ dưới, thanh ◀ 🔊 🎤 ▶ ở đáy): xong vuốt lật trang, ListenFirst / ReadFirst, phát giọng đọc có sẵn (`just_audio`, tô sáng đoạn đang đọc), từ vựng (xem nghĩa, cất vào sổ tay), lưu tiến độ (1-based, tối đa 600 giây/lần), dấu trang, yêu thích, theo dõi tín hiệu dừng đọc (`/signal` mỗi 8 giây), sự kiện `PageCompleted` / `TtsStarted` / `TtsCompleted`, nút "Em đọc xong rồi" → màn +EXP. Bố cục theo màn (`KidReaderLayout`): dọc = tranh trên chữ dưới (máy tính bảng dọc rộng tối đa 720); điện thoại ngang = tranh trái sát mép trên, chữ phải tự cuộn; máy tính bảng ngang = sách mở (phương án A, chốt 16/11): tranh trang trái, chữ trang phải, gáy sách, ếch đồng hành ở góc (nghĩ khi đang ghi âm / chấm, vui khi có kết quả hoặc giọng kể đang đọc).
- [x] 5 loại tương tác khi nghe (kiểu Quizlet, toàn màn hình): Checkpoint, Đoán tranh, Nhập vai, Điền chữ, Xếp thứ tự. Hỏi khi nghe hết cảnh, chặn lật trang khi chưa trả lời; "Để sau" thì đọc tiếp; truyện chỉ nghe không hỏi.
- [x] Điền chữ có nút "Nghe câu" phát `audioUrls['text']` (22/11, theo backend: bài thiếu audio câu bị ẩn).
- [x] Luyện đọc to bằng micro (giống web): bấm 🎤 dừng giọng kể và ghi âm đoạn đang đọc (WAV 16 kHz, tự dừng ở 3 MB, khoảng 98 giây, như web), đoạn đang ghi tô nền vàng; kết quả tô từng chữ (đúng: màu chính in đậm, cần đọc lại: nền vàng, bỏ qua: chữ mờ), lời khen / lỗi hiện bằng toast; bấm lần sau sang đoạn kế. Lật trang, thoát, mở tương tác, bật giọng kể hoặc ẩn app thì huỷ bản ghi, không gửi. Chưa thử ghi âm trên máy thật (web không ghi âm được).
- [x] Hoàn thành truyện (phương án A, từng bước toàn màn hình, có Bỏ qua): cảm xúc (kèm +EXP, huy hiệu mới, bước lộ trình) → quiz (đáp án xáo trộn, trả lời ngắn, kết quả, làm lại) → ghi âm kể lại (`record`, WAV 16 kHz, tự dừng ở 3 MB) → đánh dấu tối đa 5 cảnh còn thắc mắc. Giọng đọc đang phát cũng tính là bé đang hoạt động. Chưa thử ghi âm trên máy thật; trên web không ghi âm được (báo bằng toast). Huy hiệu mới hiện tên (tra từ phần thưởng như web).
- [x] Phần thưởng (phương án A: cây trên, huy hiệu dưới): EXP, chuỗi ngày đọc, cây tri thức 5 giai đoạn (`TtKnowledgeTree` chuyển từ web) và tưới cây, 7 huy hiệu lưới 2 cột. Sổ tay từ vựng: danh sách, xoá có xác nhận. Đọc xong mở bước lộ trình tiếp theo do Backend xử lý, mobile báo ở bước Cảm xúc.
- [x] Gửi điều ước bằng thẻ (phương án A: lưới thẻ + thanh đáy): Nhân vật → Nơi chốn → Thử thách → Bài học (hoặc "Để bố mẹ chọn"), phát âm thanh thẻ, danh sách điều ước đã gửi kèm nút đọc truyện. Gợi ý chỉ có truyện cộng đồng tạm ẩn (xem mục đọc truyện cộng đồng).
- [ ] Đọc truyện cộng đồng đã duyệt qua `communitySubmissionId` — **không làm**: Backend đã gỡ `CommunitySubmission` (11/11, xem `AI_Storytelling_Frontend/TASKS.md` mục Cộng đồng), `StartReadingRequestDto` chỉ còn `StoryId`. Gợi ý điều ước dạng truyện cộng đồng vẫn tạm ẩn.
- [x] Nút tối thiểu 64dp, chữ nội dung 22sp trên các màn của bé (`kKidMinTap`). Màn đọc bật chế độ toàn màn hình (ẩn thanh trạng thái và thông báo), thoát thì trả lại. Thông báo đẩy của app (giai đoạn 4) phải không hiện khi bé đang ở Chế độ của bé. Chưa thử trên máy thật.
- [x] Luyện đọc to: chạm chữ cần đọc lại thì hiện gợi ý theo `hint` như web (sai dấu / chưa nghe rõ / đọc thành chữ khác / quên đọc).
- [x] Tô sáng khi nghe đọc (26/11, như web): đoạn đang phát không có mốc thời gian từng chữ (`wordTimingsJson` rỗng/sai) thì không tô sáng, toast một lần mỗi lần mở truyện "Truyện này chưa có tô sáng chữ khi nghe đọc.". Mobile đã tô từng chữ trong chế độ phụ đề.
  - Chế độ phụ đề: khi xoay ngang màn đọc, tranh phủ toàn màn hình, chữ chạy theo giọng đọc ở đáy, thanh điều khiển tự ẩn; truyện không có mốc thời gian từng chữ thì không bật được.
- [x] Trang **Luyện đọc to** sau cảnh cuối (26/11, như `KidReadAloudPractice.tsx`): hiện khi nội dung đọc có `readAloudPractice`; ếch + "Luyện đọc to", câu trích trong ngoặc kép, nút Nghe mẫu / Đọc to (Dừng / Đang chấm) / Đọc lại; gửi `POST .../read-aloud-practice/{interactionId}` (`audio/wav`), tô từng chữ như đọc theo đoạn, chưa đúng hết thì hiện `praiseFeedback` + phát `praiseAudioUrl`. Không lưu làm vị trí đọc; "Trang x/y" tính cả trang luyện; nút "Em đọc xong rồi" chuyển sang trang này. `ReadAloudResult.segmentId` thành nullable (kết quả luyện trả null). 26/11: bố mẹ tắt giọng nói (`child.voice`) thì bỏ trang này như web. Chưa thử ghi âm trên máy thật.
- [x] Mỗi tranh là một trang (20/11, như `scenePictures.ts` của web): `kid_reader_pages.dart` tách cảnh theo tranh (tranh sắp theo `beatOrder`, cảnh không có tranh riêng = 1 trang), mỗi trang chỉ hiện đoạn chữ của tranh; giọng đọc / tô sáng / đọc to chỉ dùng các đoạn thuộc trang (đoạn vắt qua 2 tranh thuộc tranh chứa điểm bắt đầu). "Trang x/y" đếm theo tranh. Tương tác chỉ hỏi ở trang cuối của cảnh. Tiến độ gửi Backend vẫn theo cảnh; mở lại truyện thì về trang đầu của cảnh đã lưu. Chưa chụp màn hình thật.

### Lỗi giao diện phát hiện khi chụp màn hình (16/11)

- [x] Màn đọc ở khổ rộng (800): tranh bị lệch xuống dưới, góc trên trống. Đã sửa cùng bố cục sách mở / máy tính bảng dọc.
- [x] Màn tương tác "Đoán tranh": ô trắng là do ảnh chưa tải xong lúc chụp (chụp lại: cả hai ảnh đáp án trả 200 và hiện đủ), không phải lỗi.
- [x] Khổ 360: toast hiện đè lên thanh đáy ◀ 🔊 🎤 ▶ của màn đọc (toast ở màn đọc nâng lên 96dp, `showTtToast(bottomOffset:)`).

### Giao diện chế độ bé đồng bộ với web (18/11)

- [x] Khung `KidPanel` / `KidPanelHeader` / nút nổi `KidBtn3D` (`core/widgets/kid_panel.dart`) dùng cho Hành trình, Kho truyện, Sổ tay, Điều ước, Huy hiệu, câu đố, kể lại, chọn cảnh thắc mắc, cảm xúc, màn đọc (khung chữ, nút "Em đọc xong rồi") và nút Gửi của Điều ước. Màn đọc / câu đố có khung xương khi đang tải. Tiêu đề thẻ Hành trình luôn là "Hôm nay em đọc"; chuỗi trống Sổ tay dùng "Chưa có từ vựng" (như web). Sửa tràn 10px thẻ huy hiệu ở máy rất nhỏ.
- [x] Giao diện chung (19/11): app luôn dùng theme sáng; viền `line2` xanh đậm hơn cho mọi khung/thẻ/ô nhập; nút ">" ở tiêu đề mục tab Học tập sát mép phải. Chạy với backend local qua `.env` (`--dart-define-from-file`, xem README); Android tắt `kotlin.incremental` vì project ở ổ D: còn pub cache ở ổ C:.
- [x] Màn đọc (20/11, theo web 19/11): tranh hiện trọn trong khung 16:10, phần thừa là chính tranh làm mờ (`TtWholeImage`, dùng chung với banner Thư viện). Chưa chụp được tranh thật (dữ liệu local trỏ ảnh example.com).
- [x] Sau khi đọc (20/11, theo web 19/11): 7 trang mỗi trang một việc — mức thích → cảm xúc (tối đa 2) → tranh thích nhất → lời gửi bố mẹ → kể lại → thắc mắc theo tranh (tối đa 5) → câu đố. Chọn là lưu và tự sang trang, không còn nút "Tiếp"; thanh dưới ‹ 7 chấm › "Về thư viện"; dòng phần thưởng ở đầu màn; mở lại thì nhảy tới bước chưa làm. API mới `/reflection` (emotions, favorite-scene, note) và `summary/questions`; bỏ `summary/flags` (Backend đã gỡ, trước đó bước thắc mắc bị 404). Gửi lời bị 403 (bố mẹ chưa bật giọng nói) chỉ ẩn micro, không đẩy bé ra.
  - 26/11: "Điều gì em thích ở tranh này" nhớ trạng thái đã gửi như web (lấy từ `/reflection` khi mở lại): đã gửi thì thay nút bằng ✓ "Đã gửi cho bố mẹ" / "Đã gửi lời kể cho bố mẹ", giữ bản ghi vừa gửi để nghe lại (ẩn nút xoá); đã gửi thì khoá: ẩn ô viết, nút ghi âm mới và nút gửi (không còn "Gửi lại"). Sửa lỗi bước "Truyện làm em cảm thấy gì": quay lại thì mất cảm xúc đã chọn (so `initialCodes` theo đối tượng nên mỗi lần màn cha dựng lại bị đặt về dữ liệu cũ; nay so theo nội dung). "Kể lại": gửi file với `contentType audio/wav` (trước đó Dio tự đoán `audio/x-wav`, kho lưu Backend không nhận → 500 "Hệ thống đang bận"); gửi rồi thì ẩn nút xoá bản ghi. Còn thiếu: "Kể lại" mở lại phiên đã kể chưa lấy trạng thái đã gửi từ server.
  - 26/11: bước Câu đố mở bằng màn "Em bắt đầu vào câu hỏi nhé" (ếch, "N câu hỏi", nút Bắt đầu) rồi mới vào câu 1; "Làm lại câu đố" vào thẳng câu hỏi. Riêng mobile (web vào thẳng câu đố).
- [x] **Thời gian & thói quen phía bé** (26/11, như `KidTimeLayer.tsx`, `useChildStatus.ts`, `useReadingReminders.ts`, `KidHabitStrip.tsx`; `lib/features/kid/time/`): hỏi `/ChildAccessCredential/me` mỗi 60 giây và khi app quay lại (`kidStatusProvider`); sảnh bé phủ màn chặn (ngoài khung giờ / giờ ngủ / hết phút màn hình / nghỉ giữa giờ) có ếch, đếm ngược, nút "Về với bố mẹ" (qua cổng phụ huynh), đếm về 0 thì hỏi lại; dải vàng "Sắp hết giờ…" khi `EndingSoon`/`Grace`; chip đồng hồ dưới tên bé ở đầu sảnh (chỉ ở sảnh, không trong truyện) cho bé biết "Còn N phút" (giới hạn màn hình) hoặc "Đọc đến HH:mm" (khung giờ / giờ ngủ), còn ≤ 5 phút thì nền vàng đậm, không đặt giới hạn thì ẩn; dải thói quen (chuỗi ngày, tiến độ tuần, chấm mục tiêu) và thẻ nhắc đọc trong app khi tới giờ nhắc (không nhắc trong giờ ngủ, không thêm package thông báo nên app đóng thì không nhắc). Trong truyện: chỉ phủ màn nghỉ giữa giờ, signal vẫn chạy; hết giờ khác thì về sảnh kèm lời backend như web. 403 `READING_TIME_*` / `CHILD_FEATURE_DISABLED` không còn kết thúc phiên bé (trước đây mọi 403 đều đá bé ra).
- [x] **Tính năng bố mẹ tắt** (26/11, `disabledFeatures` trong `/me`): Sổ tay / Điều ước / Cây phần thưởng / cúp huy hiệu (phần thưởng) / "Chọn truyện" khi chưa có truyện mở (thư viện) mờ đi, bấm thì toast; bố mẹ bật lại thì sáng lại (hỏi lại `/me` mỗi 60 giây, khi app quay lại, khi bé kéo tải lại sảnh hoặc quay về từ màn con) "Bố mẹ chưa bật chức năng này. Em hỏi bố mẹ nhé." (web ẩn hẳn; sảnh mobile xếp nút cố định quanh ếch nên làm mờ thay vì ẩn). Sau khi đọc bỏ trang cảm nhận (0–3) khi tắt `child.reflection`, trang kể lại khi tắt `child.voice`, câu đố khi tắt `child.quiz` (như `KidAfterReading.tsx`).
- [ ] Biểu mẫu Điều ước (`kid_wish_wizard.dart`) vẫn là màn nhiều bước toàn màn hình, chưa đổi sang popup (thay đổi lớn). Chưa chụp màn hình kiểm tra (hoãn theo yêu cầu).

## Giai đoạn 3: Phụ huynh, thông tin của bé (F-01, F-02, F-12)

Tham khảo web: `features/children`, `features/safety`, `childProfileService.ts`, `guardianService.ts`, `profileLifecycleService.ts`.

- [x] Trang chủ = thư viện truyện như web (19/11, `lib/features/library`), bố cục kiểu app xem phim: thanh trên dính đầu (tên "Kể chuyện thông minh", nút 🔍 chuyển sang tab Tìm kiếm và focus sẵn ô tìm, chuông, avatar tài khoản → tab Tài khoản; ảnh lỗi/không có thì chữ cái đầu), hàng chip chủ đề cuộn ngang (bấm → lưới "Chủ đề: X"), banner 5 truyện mới nhất có ảnh bìa (vuốt, tự chuyển 5 giây, chấm vàng, ẩn khi không có ảnh); kệ không khung: Đọc nhiều nhất / Được yêu thích (`/Story/community?orderBy=views|favorites`, có số hạng), Mới nhất (nhãn MỚI cho truyện tạo trong 7 ngày), Đang chuẩn bị, Tất cả truyện (chip nguồn, hàng ngang như các kệ trên, 20/11); "Xem thêm ›" mở lưới đầy đủ; xem trước (chữ, ảnh, giọng đọc) từ `/Story/{id}` + media. Thẻ từng bé cũ đã bỏ (xem ở tab Học tập / Quản lý bé). Không làm bộ lọc, lộ trình mẫu, giao cho bé, báo cáo.
  - Thanh cố định ở đáy màn xem trước (20/11, `story_preview_actions.dart`): **Lộ trình** (popup chọn một/nhiều bé, bé không Active bị khoá kèm lý do → `POST /ChildRoadmap/stories` position `End`, toast tổng kết bé đã thêm / bỏ qua kèm lý do, làm mới `learningRoadmapProvider`; không có lộ trình mẫu, chọn chặng, số ngày, ghi chú) và **Đọc ngay** (popup `GET /ChildAccessCredential/story-handover`, bé gợi ý lên đầu, bé không đọc được bị khoá kèm lý do → `POST /ChildAccessCredential/{id}/handover-story` → vào Chế độ của bé và mở thẳng `/kid/read/{storyId}`, dùng chung luồng `handover_action.dart`).
  - Truyện Creator xem trước lấy chữ + media từ `/Story/community/{id}/media` (`/Story/{id}` trả 404, 20/11).
  - Thẻ truyện theo web (25/11): dưới tên thêm dòng "chủ đề · tuổi" (icon câu đố vàng khi `/Story/community` trả `hasQuiz: true`, thiếu trường thì ẩn) và dòng "tác giả … N chữ" (không có tên thì hiện nguồn; tên dài cắt "...", số chữ luôn đủ); truyện community có huy hiệu 👁 lượt đọc ♡ yêu thích ở góc dưới bìa. Xem trước ghi "N chữ" thay "N tiếng". Đã chụp 360/412 px, chữ 1.3 với API local. **26/11:** bỏ dòng "tác giả · N chữ" trên thẻ theo yêu cầu (chiều cao thẻ giảm 1 dòng); xem trước vẫn hiện tác giả và độ dài.
  - Hàng **Tác giả nổi bật** (26/11, như `LibraryTopAuthors` row của web): ngay dưới banner, tối đa 6 tác giả cuộn ngang (ô tròn chữ cái đầu nền vàng, tên, "N truyện"), gom từ truyện creator đã công khai có `authorUserId` > 0 và tên; bấm mở lưới "Tác giả: …". `LibraryStoryDto` thêm `authorUserId`. Chưa chụp màn hình thật.
  - Media xem trước của truyện không phải creator gọi `/stories/{id}/media/package` → Backend trả 403 (truyện 1 trả 500) với phụ huynh không phải tác giả, nên chỉ hiện chữ + ảnh mặc định (web cũng vậy) — **chờ Backend**.
- [x] Màn **Tìm kiếm** (`/search`, 26/11 không còn là tab, mở bằng nút 🔍 ở Trang chủ; `lib/features/library/presentation/search_screen.dart`, 19/11): ô tìm theo tên (có nút xoá), chip chủ đề cuộn ngang (bấm lọc, bấm lại bỏ lọc), lưới kết quả; chưa gõ và chưa chọn chủ đề thì hiện "Tất cả truyện" + chip nguồn; không có kết quả thì trạng thái rỗng + nút Xoá tìm kiếm. Tìm không cần gõ dấu (`foldVietnamese`, 20/11). Dùng chung `libraryProvider` với Trang chủ (không tải 2 lần), kéo làm mới, lỗi + thử lại, bấm thẻ mở xem trước.
- [x] Hồ sơ bé: màn **Quản lý bé** (`/kids`, màn đẩy có nút quay lại, mở bằng nút ⚙ ở tab Học tập; phương án A: dải chọn bé, thẻ bé, lưới Hồ sơ / Học tập / An toàn / Thời gian / Mã QR), sửa, kích hoạt / tạm dừng / tiếp tục / lưu trữ / khôi phục, lịch sử hoạt động. Thêm bé bằng wizard toàn màn hình 4 bước (Bé → Học tập → An toàn → Xong), lỗi giữa chừng bấm lại không tạo trùng. Ảnh đại diện giống web (`TtChildAvatar`, 14 con vật emoji theo mã `avatar-*`, mã lạ / `avatar-default` hiện ếch): hiện ở tab Học tập, Quản lý bé, hồ sơ; chọn trong hộp thoại Sửa thông tin (nút Lưu chỉ hiện khi đổi). Wizard thêm bé không chọn avatar (web cũng không). Sửa lỗi cũ: mobile gửi `avatarId` kiểu số (luôn null) nên không đổi được avatar.
- [x] Learning Profile: mức đọc, chế độ đọc, mục tiêu, chủ đề yêu thích / cần chú ý.
- [x] Safety Policy: các mục ảnh hưởng tới lúc bé đọc (cổng phụ huynh, điều ước, tương tác khi nghe, trả lời bằng giọng nói, chủ đề Cho phép / Chặn); đồng ý điều khoản. Tự lưu như web, luôn gửi đủ các trường (Backend ghi đè và không nhận null).
  - 26/11 đủ như `SafetyWorkspace.tsx`: Chế độ duyệt (luôn duyệt / tự duyệt khi đạt ngưỡng + 2 ngưỡng điểm, cảnh báo khi đang hỏi mật khẩu), Giới hạn và quyền (độ dài truyện Theo mức đọc / Tự chỉnh 200–5000 từ, cảnh báo quá dài; hỏi mật khẩu khi thoát), Mức đọc hiểu mục tiêu 50–90%, Tính năng cho bé (thêm 5 công tắc: câu đố, sổ từ, tìm truyện trong thư viện, cảm nhận, phần thưởng). Thanh kéo chỉ lưu khi thả tay. Sửa lỗi mất dữ liệu: trước đây lưu trên mobile không gửi `storyLengthTarget` và 5 cờ nên xoá độ dài phụ huynh tự chỉnh trên web.
- [x] **Thời gian & thói quen** (26/11, `/kids/:id/time`, như `TimeHabitsTab.tsx`; `lib/features/time_habits/`): thẻ xếp dọc — Giới hạn thời gian đọc (công tắc tổng) gồm Khung giờ được đọc (tối đa 2 khung mỗi loại ngày) và Giờ đi ngủ (18:00–23:30); Thời gian nhìn màn hình; Nghỉ giữa các phiên đọc (+ lời nhắc mắt / nước / vận động); Thói quen & mục tiêu đọc (giờ nhắc, mục tiêu 1–7 ngày, tiến độ tuần, chuỗi ngày). Chưa lưu lần nào thì hiện gợi ý theo tuổi + "Lưu gợi ý". Thanh lưu ở đáy chỉ hiện khi có thay đổi, lỗi backend toast + viền đỏ đúng thẻ, thoát khi chưa lưu thì hỏi lại. Chỉ người quản lý chính sửa được. Ô "Thời gian" ở lưới Quản lý bé tóm tắt "Ngủ 21:00 · Màn hình 60 phút" / "Đang tắt" / "Chưa thiết lập". Chưa chụp màn hình thật (Docker tắt).
- [x] Mã QR EasyLogin: tạo, tạo lại, thu hồi (`qr_flutter`, link `?kid=` giống web, nền trắng cả khi giao diện tối).
- [x] Tài khoản (phương án A): thẻ hồ sơ + sửa họ tên, Bảo mật (đổi mật khẩu, đổi email có mã OTP, phiên đăng nhập, lịch sử hoạt động), Xoá tài khoản mở trang web, đăng xuất.

## Sự kiện cho phụ huynh (26/11, theo `features/events` của web)

- [x] Đợt 1: tầng dữ liệu `lib/models/event_dto.dart`, `lib/features/events/data/` (danh sách, chi tiết, đăng ký, tham gia của tôi, bảng nhiệm vụ, xác nhận nhiệm vụ, quà của tôi, nhận quà; nhãn và hàm thời gian/nhóm/quà như web).
  - Tab **Sự kiện** (`/events`): ô tìm không dấu, chip Tất cả / Đang mở / Sắp diễn ra / Đã kết thúc / Đã tham gia (có số đếm), thẻ ảnh 16:9 + nhãn trạng thái, MỚI, trạng thái tham gia, ngày, tuổi, chủ đề, ngân sách; đang tải / lỗi / rỗng; kéo làm mới.
  - Chi tiết (`/events/:id`, vẫn có thanh tab): phần giới thiệu, chip "Nhiệm vụ & Quà" / "Thông tin". Kiểu cũ: đăng ký gia đình (popup thể lệ, ngoài thời gian đăng ký thì khoá + câu nhắc), 3 ô số liệu, nhiệm vụ có thanh tiến độ, nhiệm vụ tự xác nhận chọn truyện trong popup, truyện của sự kiện (có trong thư viện thì mở xem trước). ActivityBased: danh sách hoạt động đủ điều kiện, đăng ký từng hoạt động, nhiệm vụ đọc khi đã đăng ký ReadingMissions. Phần thưởng của tôi + popup nhận thưởng theo loại quà. Thông tin: hành trình, thể lệ (thu gọn), điều kiện nhận thưởng, cơ cấu giải.
  - Banner "Sự kiện đang mở" ở Trang chủ (trên banner truyện), bấm mở chi tiết sự kiện đầu tiên.
  - Chưa chụp màn hình thật, chưa gọi API thật (kiểm bằng JSON mẫu theo DTO Backend).
- [ ] Đợt 2: nộp truyện dự thi, bình chọn, bảng xếp hạng, khiếu nại kết quả.

## Giai đoạn 4: Phụ huynh, thống kê học tập (F-08)

Tham khảo web: `features/learning`, `roadmapService.ts`, `storyWishService.ts`.

- [x] Tab Học tập (`lib/features/learning`): dải chọn bé (chỉ bé Active, dùng chung `selectedChildIdProvider` với Quản lý bé), cùng hàng có nút "Vào học" (giao máy cho bé đang chọn bằng `handoverChildToKid`, chặn bấm đúp) và ⚙ "Quản lý bé"; chưa có bé Active thì có nút Quản lý bé / Thêm bé, 4 tab Tổng quan · Lộ trình · Kết quả đọc · Điều ước (20/11: Lộ trình trống vẫn hiện Tiến độ 0/0 + nút Thêm truyện; màn Hành trình của bé trống vẫn hiện dải kèm lời nhắn); mỗi tab có đang tải / rỗng / lỗi + thử lại, kéo xuống để tải lại.
- [x] Tổng quan của từng bé như web: 4 ô số liệu bấm được (Lộ trình `đã đọc/tổng`, Đã đọc xong, Bé kể lại, Điều ước chờ), thẻ Đang đọc (bìa, hạn, tiến độ, 3 truyện kế tiếp), thẻ Mới đọc xong (3 truyện). Phụ huynh không có API EXP / chuỗi ngày / huy hiệu / cây tri thức (chỉ phiên của bé có) nên không hiện các số này.
- [x] Kết quả đọc như web: lưới ô truyện (2/3/4 cột theo độ rộng), các lần đọc cùng truyện gộp một ô (bìa, mức thích, % câu đố, lần gần nhất, nút "N lần đọc"); bấm mở bảng các lần đọc, bấm một lần mở chi tiết: Tóm tắt, Cảm nhận (gọi API reflection, nghe lời bé), Đọc to, Câu đố, Từ mới, Bé trả lời, Kể lại (nghe ghi âm, câu bé còn thắc mắc, xoá có popup). Bỏ mục "Bé kể lại" riêng (ô số liệu Tổng quan mở thẳng Kết quả đọc). Chưa làm: danh sách bản ghi đọc to từng đoạn, popup chi tiết câu đố, xoá lời bé gửi.
- [x] Tiến độ lộ trình của bé (chỉ xem; sửa lộ trình trên web): Đang đọc / Tiếp theo / Đã đọc / Đã gỡ hoặc bỏ qua.
- [x] Điều ước bé đã gửi (chỉ xem; dùng truyện có sẵn / tạo truyện / từ chối làm trên web — điều ước đang chờ có nút mở web).
- [x] Thông báo trong app (`lib/features/notifications`, `/Notification`): danh sách (câu chữ theo loại thông báo như web, không hiện JSON), chưa đọc nổi bật, chạm để đánh dấu đã đọc và mở đúng màn (điều ước / lộ trình / kể lại → tab Học tập đúng bé; giám sát → màn Quản lý bé (thay màn Thông báo, Back về tab cũ); bảo mật → Tài khoản), đánh dấu tất cả đã đọc, xoá có popup. Lối vào: chuông có số chưa đọc ở Trang chủ, dòng "Thông báo" trong Tài khoản; số chưa đọc làm mới khi mở / kéo tải lại / quay lại / app trở lại foreground.
- [ ] Thông báo đẩy khi bé gửi điều ước, bé đọc xong truyện — **chờ Backend** (chưa có API đăng ký thiết bị nhận thông báo đẩy). Khi làm: không hiện khi máy đang ở Chế độ của bé.

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
- [x] Theo phạm vi mới (15/11): thanh đáy là Trang chủ · Bé · Học tập · Tài khoản (19/11 đổi Bé → Tìm kiếm); bỏ màn Studio, Duyệt, Thư viện, Thanh toán của phụ huynh.
