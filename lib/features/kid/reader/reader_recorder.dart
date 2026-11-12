/// Thư viện ghi âm đọc to với hỗ trợ đa nền tảng qua conditional export.
library;

export 'reader_recorder_stub.dart'
    if (dart.library.io) 'reader_recorder_io.dart'
    show ReaderRecorder, kMicSupported;
export 'reader_recorder_limits.dart';
