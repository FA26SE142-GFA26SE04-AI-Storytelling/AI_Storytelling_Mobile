/// Các hằng số và hàm tính toán giới hạn dung lượng ghi âm đọc to.
library;

/// Giới hạn dung lượng tối đa cho file âm thanh đọc to (bytes).
const int kReadAloudMaxBytes = 1000000;

/// Tần số lấy mẫu WAV (Hz).
const int kWavSampleRate = 12000;

/// Số bytes trên mỗi giây cho chuẩn WAV 12kHz mono 16-bit.
const int kWavBytesPerSecond = 24000;

/// Tính toán thời lượng tối đa (giây) cho phép ghi âm đọc to.
int readAloudMaxSeconds() =>
    ((kReadAloudMaxBytes - 44) / kWavBytesPerSecond * 0.95).floor();
