# ai_storytelling_mobile

A new Flutter project.

## Chạy với backend local

```powershell
copy .env.example .env   # sửa API_URL nếu cần (xem chú thích trong file)
flutter run --dart-define-from-file=.env                                   # điện thoại / emulator
flutter run -d chrome --web-port 3000 --dart-define-from-file=.env         # web (CORS chỉ cho cổng 3000)
```

Android cắm USB: chạy `adb reverse tcp:5259 tcp:5259` trước (chạy lại mỗi lần cắm cáp). Không truyền `--dart-define-from-file` thì app gọi `https://api.taletale.site/api/v1`.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
