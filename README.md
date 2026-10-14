# Taletale Mobile (Flutter)

Ứng dụng Taletale cho điện thoại và máy tính bảng (iOS, Android). Thiết kế theo `../DESIGN.md`, sản phẩm theo `../PRODUCT.md`.

## Chạy

```sh
flutter pub get
flutter run                                   # dữ liệu mẫu (mặc định), đăng nhập bằng bất kỳ tài khoản nào
flutter run --dart-define=USE_MOCK=false      # gọi API thật https://api.taletale.site/api/v1
flutter run --dart-define=USE_MOCK=false --dart-define=API_URL=http://10.0.2.2:5000   # backend chạy trên máy (Android emulator)
```

`API_URL` được chuẩn hoá giống web: tự thêm `/api/v1`, bỏ `/swagger`, `/index.html` và dấu `/` ở cuối.

## Kiểm tra

```sh
flutter analyze
flutter test
dart format lib test        # độ rộng dòng 160 (analysis_options.yaml)
```

## Cấu trúc

```
lib/
├─ main.dart, app/          App, router (go_router, chặn theo đăng nhập), providers (Riverpod), theme
│  └─ theme/                Token màu TtColors (chép từ web tokens.css), TtTheme, chế độ sáng/tối
├─ core/                    env (--dart-define), ApiClient (dio, tự refresh token), SessionStorage (secure storage)
├─ data/auth/               Model, ApiAuthRepository, MockAuthRepository
├─ features/                auth (đăng nhập…), shell (thanh đáy / NavigationRail), home, library, review, account, studio
└─ shared/                  motion (riseIn, giảm chuyển động), widgets (TtButton, Frog, PondBackdrop, EmptyState, Notice, StatusPill)
```

- Material được import từ `package:material_ui/material_ui.dart` (đã tách khỏi Flutter SDK), **không** dùng `package:flutter/material.dart`.
- Màu luôn lấy qua `context.tt`, không viết mã màu trong widget.
- Font Nunito và Baloo 2 (có tiếng Việt) đóng gói trong `assets/fonts/`.
- `android/gradle.properties` tắt `kotlin.incremental` vì dự án và pub cache nằm khác ổ đĩa trên Windows.

## Lộ trình

- [x] P0 – Nền tảng: theme, font, router, API client, đăng nhập / đăng ký / quên & đặt lại mật khẩu, chế độ dữ liệu mẫu
- [ ] P1 – Chọn bé, Trang chủ, Thư viện, Chi tiết truyện
- [ ] P2 – Chế độ của bé: đọc, câu đố, cổng phụ huynh, giọng đọc
- [ ] P3 – Duyệt nội dung, Studio tạo truyện
- [ ] P4 – Báo cáo, Cài đặt an toàn
- [ ] P5 – Hoàn thiện: chuyển theme circle reveal, accessibility, deep link native (App Links / Universal Links)
