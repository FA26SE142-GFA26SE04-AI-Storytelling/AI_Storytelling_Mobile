# Mobile (Flutter): chức năng theo vai trò

Cập nhật: 12/11/2026.

Căn cứ:

- Frontend đã làm: `AI_Storytelling_Frontend/TASKS.md` (22 chức năng F-01 → F-22 của tài liệu 6).
- Thiết kế mobile: mục "Mobile (Flutter)" trong `DESIGN.md` ở thư mục gốc dự án.
- Sản phẩm: `PRODUCT.md` (người dùng chính là Phụ huynh và Bé).
- API: REST `/api/v1`. Hàm gọi API tham khảo từ `AI_Storytelling_Frontend/src/app/services/*.ts`, kiểu dữ liệu từ `src/app/types/*.ts`.

Phạm vi đã chốt (12/11): **ưu tiên Phụ huynh và Bé**. Creator làm sau (chỉ màn theo dõi). Moderator và Admin dùng web, không làm trên mobile.

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
   ├─ home/          trang chủ phụ huynh: "Cho bé đọc", truyện làm dở, việc cần làm
   ├─ children/      hồ sơ bé, Learning Profile, vòng đời hồ sơ
   ├─ safety/        Safety Policy
   ├─ access/        mã QR EasyLogin, giao máy cho bé
   ├─ learning/      học tập của bé: tổng quan, kết quả đọc
   ├─ roadmap/       lộ trình, thư viện lộ trình mẫu
   ├─ wishes/        điều ước của bé (phía phụ huynh)
   ├─ studio/        tạo truyện bằng AI dạng wizard, nhập truyện có sẵn
   ├─ stories/       Truyện của tôi, gửi cộng đồng
   ├─ library/       thư viện cộng đồng, báo cáo nội dung
   ├─ account/       hồ sơ tài khoản, phiên đăng nhập, đổi mật khẩu / email
   ├─ payment/       gói, lượt AI, thanh toán QR, lịch sử giao dịch
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
- [x] Router: khu phụ huynh có thanh đáy (Trang chủ · Thư viện · (+) Tạo · Bé · Tài khoản); Chế độ của bé là route toàn màn hình, không có thanh đáy.
- [x] Đăng nhập, đăng ký, xác thực email, quên / đặt lại mật khẩu (nhập mã OTP gửi qua email, như web).
- [x] Chặn tài khoản Moderator / Admin / Creator ở mobile: báo dùng web (Creator làm ở giai đoạn 6).
- [x] Linh vật ếch (SVG chuyển từ `Frog.tsx` của web: idle / happy / think) trong `TtFrog`.
- [x] Thêm nền tảng web (`web/`) chỉ để chụp màn hình kiểm tra UI bằng Playwright; app chính vẫn là Android / iOS. Chạy thử trên web cần Backend cho phép CORS origin localhost (hiện chưa có, app thật không bị).
- [ ] Nút đang gửi chưa hiện vòng quay (TtButton.isLoading) ở màn đăng nhập — sửa ở giai đoạn sau.

## Giai đoạn 2: Bé (F-02, F-08, F-13, F-14)

Tham khảo web: `features/kid/*`, `childAccessService.ts`, `childReadingService.ts`, `storyWishService.ts`.

- [x] Vào app bằng quét QR EasyLogin (đọc link `?kid=` của web hoặc mã trần; lỗi / khoá do Backend trả hiện bằng toast). Chưa thử camera thật.
- [x] Phụ huynh giao máy: tab Bé có danh sách hồ sơ + nút "Cho bé đọc" (`POST /ChildAccessCredential/{id}/handover`); mở lại app vẫn ở Chế độ của bé. Chưa có "Cho bé đọc ngay" kèm truyện (giai đoạn 3/4).
- [x] Cổng phụ huynh khi thoát (`POST /ParentalGate/verify`) khi `parentalGateEnabled` bật; chặn nút Back của Android. Phiên bé hết hạn → màn "Phiên đọc đã kết thúc".
- [ ] **Một phần** — Trang chính của bé (bố cục A đã chốt): thẻ "Hôm nay em đọc", hàng lá sen hành trình (`GET /MyRoadmap`), lưới 2×2 đã xong; các ô Truyện / Sổ tay / Điều ước / Phần thưởng còn mở màn "Sắp có" (2b/2c).
- [x] Hỏi lại phiên bé định kỳ như web (`GET /ChildAccessCredential/me` mỗi 15 giây); màn đọc hỏi `signal` mỗi 8 giây, `shouldExit` thì dừng và về trang bé.
- [x] Ảnh bìa có đuôi `#crop=x,y,w,h` được cắt như web (`TtCroppedImage`).
- [x] Màn đọc (bố cục A: tranh trên, chữ dưới, thanh ◀ 🔊 🎤 ▶ ở đáy; màn ngang tranh trái chữ phải): mỗi tranh một trang như web, vuốt lật trang, giọng đọc (just_audio, dừng cuối trang, tô vàng chữ đang đọc), từ vựng gạch chân → sheet nghĩa, lưu tiến độ + mở lại đúng trang, dấu trang, yêu thích, dải mờ báo còn chữ, nút "Em đọc xong rồi!" → màn chúc mừng tạm (+EXP). Đã chụp với Backend local (truyện 908).
- [ ] Giọng đọc với file cần token (truyện gia đình tự soạn) chưa thử trên máy thật.
- [ ] Sheet từ vựng chưa có nút "Thêm vào sổ tay" (2c).
- [x] 5 loại tương tác khi nghe: Checkpoint, RolePlay, FillBlank, EventOrdering, PicturePrediction — hỏi khi bé qua hết cảnh như web, ếch phản ứng, chỉ khen, nút "Đọc tiếp" / "Để sau" / "Nghe lại cảnh". Đã thử thật Checkpoint + PicturePrediction (attempts 200, Backend local, truyện 908). Chưa thử thật FillBlank, EventOrdering, RolePlay (truyện demo không có).
- [ ] **Một phần** — Luyện đọc to: ghi WAV (`record`), gửi `.../segments/{id}/read-aloud`, tô chữ xanh / vàng / xám, nút Đọc lại; nút 🎤 luôn hiện như web, 403 thì toast + ẩn. Chưa thử trên máy thật (web không ghi âm). Lệch web: kết quả hiện thành dãy chữ dưới đoạn văn (web tô ngay trên đoạn văn); RolePlay chưa ghi âm.
- [ ] Hoàn thành truyện: chọn cảm xúc, quiz (trắc nghiệm, đúng/sai, trả lời ngắn), ghi âm kể lại, đánh dấu tối đa 5 cảnh còn thắc mắc.
- [ ] EXP, 7 huy hiệu, cây tri thức 5 giai đoạn, sổ tay từ vựng; đọc xong mở bước lộ trình tiếp theo.
- [ ] Gửi điều ước bằng thẻ.
- [ ] Đọc truyện cộng đồng đã duyệt.
- [ ] Tắt thông báo của app khi bé đang đọc; nút tối thiểu 64dp, chữ 22–28sp.

## Giai đoạn 3: Phụ huynh, phần cốt lõi (F-01, F-02, F-08, F-12)

Tham khảo web: `features/children`, `features/safety`, `features/learning`, `childProfileService.ts`, `guardianService.ts`, `profileLifecycleService.ts`.

- [ ] Trang chủ: lời chào, thẻ "Cho bé đọc", truyện làm dở, việc cần làm (truyện chờ duyệt, điều ước mới), kéo xuống để tải lại.
- [ ] Hồ sơ bé: tạo (tên, ảnh, nhóm tuổi), sửa, kích hoạt / tạm dừng / tiếp tục / lưu trữ / khôi phục, lịch sử hoạt động.
- [ ] Learning Profile: mức đọc, chế độ đọc, mục tiêu, chủ đề yêu thích / cần chú ý.
- [ ] Safety Policy: chủ đề Cho phép / Chặn, chế độ duyệt, độ dài truyện, cổng phụ huynh, điều ước, tương tác khi nghe, trả lời bằng giọng nói, ngưỡng tự duyệt; đồng ý điều khoản. Tự lưu như web.
- [ ] Mã QR EasyLogin: tạo, tạo lại, thu hồi.
- [ ] Học tập của bé: tổng quan, kết quả đọc (câu trả lời, nghe bản kể lại, chỗ còn thắc mắc, xoá bản kể lại).
- [ ] Điều ước: xem, dùng truyện có sẵn, tạo truyện mới bằng AI, từ chối.
- [ ] Thông báo: danh sách, đánh dấu đã đọc, xoá; thông báo đẩy (AI viết xong, bé gửi điều ước, gói sắp hết hạn).
- [ ] Tài khoản: hồ sơ, đổi mật khẩu / email, phiên đăng nhập, đăng xuất. Xoá tài khoản mở trang web.

## Giai đoạn 4: Phụ huynh, tạo truyện (F-06, F-07, F-09, F-10, F-12)

Tham khảo web: `features/studio`, `features/story-workflow`, `aiStoryCreationService.ts`, `existingStoryService.ts`, `roadmapService.ts`.

- [ ] Studio AI dạng wizard: ① Ý tưởng → ② Tiến trình → ③ Dàn ý (sửa, viết lại, duyệt, từ chối) → ④ Duyệt cảnh (vuốt từng cảnh, sửa trong bottom sheet) → ⑤ Tranh và giọng đọc → xác nhận gói media → Ready. Mở lại app vẫn tiếp tục được.
- [ ] Hết lượt AI: báo rõ kèm nút "Nâng cấp gói"; nhãn "Còn N lượt AI".
- [ ] Nhập truyện có sẵn: chỉ dán văn bản (không tải .docx trên mobile), xem đánh giá, tiếp tục / nhờ AI chỉnh / giữ nguyên.
- [ ] Truyện của tôi theo kệ (Đã xong / Chờ bạn duyệt / Đang soạn), ảnh bìa.
- [ ] Gửi truyện Ready lên cộng đồng, rút lại; thư viện cộng đồng, báo cáo nội dung.
- [ ] Lộ trình: thêm truyện, đổi thứ tự, gỡ bước, làm trống; thư viện lộ trình mẫu (xem, sao chép cho bé).
- Để trên web: Tự viết truyện (soạn dài, nhiều phiên bản, trợ lý AI), Giao cho nhiều bé.

## Giai đoạn 5: Phụ huynh, gói và thanh toán (F-03, F-04, F-05)

Tham khảo web: `features/account/PaymentSection.tsx`, `paymentService.ts`.

- [ ] Gói của bạn và lượt còn lại (`GET /TokenQuota/me`).
- [ ] Mua gói / gia hạn / nâng cấp / Add-on, popup xác nhận kèm hệ quả.
- [ ] Thanh toán QR: vì không quét được QR trên chính máy đang hiện, cần nút **lưu ảnh QR**, **chép số tài khoản / nội dung chuyển khoản**, mở app ngân hàng nếu được; đếm ngược 15 phút, tự kiểm tra trạng thái mỗi 5 giây.
- [ ] Lịch sử giao dịch, "Tiếp tục thanh toán" cho giao dịch chờ còn hạn.

## Giai đoạn 6: Creator (làm sau, tuỳ thời gian)

- [ ] Thống kê doanh thu (F-20) và lượt đọc (F-21).
- [ ] Lượt còn lại và mua gói Creator.
- [ ] Thông báo kết quả duyệt, rút yêu cầu duyệt.
- Để trên web: soạn truyện, media từng đoạn, gửi duyệt.

---

## Không làm trên mobile

- Moderator, Admin: dùng web.
- Tự viết truyện dài, Giao cho nhiều bé: dùng web.
- Ngoài phạm vi chung (tài liệu 6): đa ngôn ngữ, nhân bản giọng nói, đọc offline.

## Cần sửa trong DESIGN.md (mục Mobile)

- [x] Bỏ "3 chỉ số", "biểu đồ 7 ngày" và tab "Báo cáo" của phụ huynh (dashboard, báo cáo tuần đã bỏ).
- [x] Bỏ nút "Lưu trữ" ở màn Duyệt (đã bỏ thao tác lưu trữ truyện của phụ huynh).
- [x] Cài đặt an toàn tự lưu, bỏ nút "Lưu" cố định.
- [x] Thanh đáy đổi thành Trang chủ · Thư viện · (+) Tạo · Bé · Tài khoản; "Duyệt" vào danh sách việc cần làm ở Trang chủ.
