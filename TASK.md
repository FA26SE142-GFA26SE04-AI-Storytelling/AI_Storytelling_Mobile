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
- [x] Thanh đáy phụ huynh: **Trang chủ · Tìm kiếm · Học tập · Tài khoản** (19/11: tab Bé đổi thành Tìm kiếm, quản lý bé chuyển vào Học tập; trước đó đã bỏ tab "(+) Tạo" và "Thư viện"). Đã xoá thư mục rỗng `studio/`, `stories/`, `library/`, `payment/`, `roadmap/`.
- [x] Đăng nhập, đăng ký, xác thực email, quên / đặt lại mật khẩu (nhập mã OTP gửi qua email, như web).
- [x] Chặn tài khoản Moderator / Admin / Creator ở mobile: báo dùng web.
- [x] Linh vật ếch (SVG chuyển từ `Frog.tsx` của web: idle / happy / think) trong `TtFrog`.
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
- [x] Thư viện của bé (`GET /child/reading/stories`, trang đánh số từ 1 như Backend): lưới bìa, tìm kiếm, tải thêm khi cuộn, nút xoá nhanh ô tìm kiếm.
- [x] Hỏi lại phiên bé định kỳ như web: kiểm tra mỗi 15 giây, chỉ gọi `GET /ChildAccessCredential/me` (tối đa 1 lần/phút) khi bé vừa chạm màn hình; 20 phút không hoạt động → "Phiên đọc đã kết thúc". Mất mạng thì giữ phiên.
- [x] Ảnh bìa có đuôi `#crop=x,y,w,h`: `TtNetworkImage` tự cắt đúng vùng như web.
- [x] Màn đọc (bố cục A: tranh trên, chữ dưới, thanh ◀ 🔊 🎤 ▶ ở đáy): xong vuốt lật trang, ListenFirst / ReadFirst, phát giọng đọc có sẵn (`just_audio`, tô sáng đoạn đang đọc), từ vựng (xem nghĩa, cất vào sổ tay), lưu tiến độ (1-based, tối đa 600 giây/lần), dấu trang, yêu thích, theo dõi tín hiệu dừng đọc (`/signal` mỗi 8 giây), sự kiện `PageCompleted` / `TtsStarted` / `TtsCompleted`, nút "Em đọc xong rồi" → màn +EXP. Bố cục theo màn (`KidReaderLayout`): dọc = tranh trên chữ dưới (máy tính bảng dọc rộng tối đa 720); điện thoại ngang = tranh trái sát mép trên, chữ phải tự cuộn; máy tính bảng ngang = sách mở (phương án A, chốt 16/11): tranh trang trái, chữ trang phải, gáy sách, ếch đồng hành ở góc (nghĩ khi đang ghi âm / chấm, vui khi có kết quả hoặc giọng kể đang đọc).
- [x] 5 loại tương tác khi nghe (kiểu Quizlet, toàn màn hình): Checkpoint, Đoán tranh, Nhập vai, Điền chữ, Xếp thứ tự. Hỏi khi nghe hết cảnh, chặn lật trang khi chưa trả lời; "Để sau" thì đọc tiếp; truyện chỉ nghe không hỏi.
- [x] Luyện đọc to bằng micro (giống web): bấm 🎤 dừng giọng kể và ghi âm đoạn đang đọc (WAV 16 kHz, tự dừng ở 3 MB, khoảng 98 giây, như web), đoạn đang ghi tô nền vàng; kết quả tô từng chữ (đúng: màu chính in đậm, cần đọc lại: nền vàng, bỏ qua: chữ mờ), lời khen / lỗi hiện bằng toast; bấm lần sau sang đoạn kế. Lật trang, thoát, mở tương tác, bật giọng kể hoặc ẩn app thì huỷ bản ghi, không gửi. Chưa thử ghi âm trên máy thật (web không ghi âm được).
- [x] Hoàn thành truyện (phương án A, từng bước toàn màn hình, có Bỏ qua): cảm xúc (kèm +EXP, huy hiệu mới, bước lộ trình) → quiz (đáp án xáo trộn, trả lời ngắn, kết quả, làm lại) → ghi âm kể lại (`record`, WAV 16 kHz, tự dừng ở 3 MB) → đánh dấu tối đa 5 cảnh còn thắc mắc. Giọng đọc đang phát cũng tính là bé đang hoạt động. Chưa thử ghi âm trên máy thật; trên web không ghi âm được (báo bằng toast). Huy hiệu mới hiện tên (tra từ phần thưởng như web).
- [x] Phần thưởng (phương án A: cây trên, huy hiệu dưới): EXP, chuỗi ngày đọc, cây tri thức 5 giai đoạn (`TtKnowledgeTree` chuyển từ web) và tưới cây, 7 huy hiệu lưới 2 cột. Sổ tay từ vựng: danh sách, xoá có xác nhận. Đọc xong mở bước lộ trình tiếp theo do Backend xử lý, mobile báo ở bước Cảm xúc.
- [x] Gửi điều ước bằng thẻ (phương án A: lưới thẻ + thanh đáy): Nhân vật → Nơi chốn → Thử thách → Bài học (hoặc "Để bố mẹ chọn"), phát âm thanh thẻ, danh sách điều ước đã gửi kèm nút đọc truyện. Gợi ý chỉ có truyện cộng đồng tạm ẩn (xem mục đọc truyện cộng đồng).
- [ ] Đọc truyện cộng đồng đã duyệt qua `communitySubmissionId` — **không làm**: Backend đã gỡ `CommunitySubmission` (11/11, xem `AI_Storytelling_Frontend/TASKS.md` mục Cộng đồng), `StartReadingRequestDto` chỉ còn `StoryId`. Gợi ý điều ước dạng truyện cộng đồng vẫn tạm ẩn.
- [x] Nút tối thiểu 64dp, chữ nội dung 22sp trên các màn của bé (`kKidMinTap`). Màn đọc bật chế độ toàn màn hình (ẩn thanh trạng thái và thông báo), thoát thì trả lại. Thông báo đẩy của app (giai đoạn 4) phải không hiện khi bé đang ở Chế độ của bé. Chưa thử trên máy thật.
- [x] Luyện đọc to: chạm chữ cần đọc lại thì hiện gợi ý theo `hint` như web (sai dấu / chưa nghe rõ / đọc thành chữ khác / quên đọc).
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
- [ ] Biểu mẫu Điều ước (`kid_wish_wizard.dart`) vẫn là màn nhiều bước toàn màn hình, chưa đổi sang popup (thay đổi lớn). Chưa chụp màn hình kiểm tra (hoãn theo yêu cầu).

## Giai đoạn 3: Phụ huynh, thông tin của bé (F-01, F-02, F-12)

Tham khảo web: `features/children`, `features/safety`, `childProfileService.ts`, `guardianService.ts`, `profileLifecycleService.ts`.

- [x] Trang chủ = thư viện truyện như web (19/11, `lib/features/library`), bố cục kiểu app xem phim: thanh trên dính đầu (tên "Kể chuyện thông minh", nút 🔍 chuyển sang tab Tìm kiếm và focus sẵn ô tìm, chuông, avatar tài khoản → tab Tài khoản; ảnh lỗi/không có thì chữ cái đầu), hàng chip chủ đề cuộn ngang (bấm → lưới "Chủ đề: X"), banner 5 truyện mới nhất có ảnh bìa (vuốt, tự chuyển 5 giây, chấm vàng, ẩn khi không có ảnh); kệ không khung: Đọc nhiều nhất / Được yêu thích (`/Story/community?orderBy=views|favorites`, có số hạng), Mới nhất (nhãn MỚI cho truyện tạo trong 7 ngày), Đang chuẩn bị, Tất cả truyện (chip nguồn, hàng ngang như các kệ trên, 20/11); "Xem thêm ›" mở lưới đầy đủ; xem trước (chữ, ảnh, giọng đọc) từ `/Story/{id}` + media. Thẻ từng bé cũ đã bỏ (xem ở tab Học tập / Quản lý bé). Không làm bộ lọc, lộ trình mẫu, giao cho bé, báo cáo.
  - Thanh cố định ở đáy màn xem trước (20/11, `story_preview_actions.dart`): **Lộ trình** (popup chọn một/nhiều bé, bé không Active bị khoá kèm lý do → `POST /ChildRoadmap/stories` position `End`, toast tổng kết bé đã thêm / bỏ qua kèm lý do, làm mới `learningRoadmapProvider`; không có lộ trình mẫu, chọn chặng, số ngày, ghi chú) và **Đọc ngay** (popup `GET /ChildAccessCredential/story-handover`, bé gợi ý lên đầu, bé không đọc được bị khoá kèm lý do → `POST /ChildAccessCredential/{id}/handover-story` → vào Chế độ của bé và mở thẳng `/kid/read/{storyId}`, dùng chung luồng `handover_action.dart`).
  - Truyện Creator xem trước lấy chữ + media từ `/Story/community/{id}/media` (`/Story/{id}` trả 404, 20/11).
  - Media xem trước của truyện không phải creator gọi `/stories/{id}/media/package` → Backend trả 403 (truyện 1 trả 500) với phụ huynh không phải tác giả, nên chỉ hiện chữ + ảnh mặc định (web cũng vậy) — **chờ Backend**.
- [x] Tab **Tìm kiếm** (`/search`, `lib/features/library/presentation/search_screen.dart`, 19/11): ô tìm theo tên (có nút xoá), chip chủ đề cuộn ngang (bấm lọc, bấm lại bỏ lọc), lưới kết quả; chưa gõ và chưa chọn chủ đề thì hiện "Tất cả truyện" + chip nguồn; không có kết quả thì trạng thái rỗng + nút Xoá tìm kiếm. Tìm không cần gõ dấu (`foldVietnamese`, 20/11). Dùng chung `libraryProvider` với Trang chủ (không tải 2 lần), kéo làm mới, lỗi + thử lại, bấm thẻ mở xem trước.
- [x] Hồ sơ bé: màn **Quản lý bé** (`/kids`, màn đẩy có nút quay lại, mở bằng nút ⚙ ở tab Học tập; phương án A: dải chọn bé, thẻ bé, lưới Hồ sơ / Học tập / An toàn / Mã QR), sửa, kích hoạt / tạm dừng / tiếp tục / lưu trữ / khôi phục, lịch sử hoạt động. Thêm bé bằng wizard toàn màn hình 4 bước (Bé → Học tập → An toàn → Xong), lỗi giữa chừng bấm lại không tạo trùng. Ảnh đại diện giống web (`TtChildAvatar`, 14 con vật emoji theo mã `avatar-*`, mã lạ / `avatar-default` hiện ếch): hiện ở tab Học tập, Quản lý bé, hồ sơ; chọn trong hộp thoại Sửa thông tin (nút Lưu chỉ hiện khi đổi). Wizard thêm bé không chọn avatar (web cũng không). Sửa lỗi cũ: mobile gửi `avatarId` kiểu số (luôn null) nên không đổi được avatar.
- [x] Learning Profile: mức đọc, chế độ đọc, mục tiêu, chủ đề yêu thích / cần chú ý.
- [x] Safety Policy: các mục ảnh hưởng tới lúc bé đọc (cổng phụ huynh, điều ước, tương tác khi nghe, trả lời bằng giọng nói, chủ đề Cho phép / Chặn); đồng ý điều khoản. Tự lưu như web, luôn gửi đủ các trường (Backend ghi đè và không nhận null). Các mục chỉ dùng khi tạo truyện (chế độ duyệt, độ dài truyện, ngưỡng tự duyệt) để trên web.
- [x] Mã QR EasyLogin: tạo, tạo lại, thu hồi (`qr_flutter`, link `?kid=` giống web, nền trắng cả khi giao diện tối).
- [x] Tài khoản (phương án A): thẻ hồ sơ + sửa họ tên, Bảo mật (đổi mật khẩu, đổi email có mã OTP, phiên đăng nhập, lịch sử hoạt động), Xoá tài khoản mở trang web, đăng xuất.

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
