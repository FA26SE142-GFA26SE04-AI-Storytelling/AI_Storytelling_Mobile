/// Số cột lưới của bé: điện thoại giữ [phone]; màn từ 600 thêm 1 cột; từ 1000 thêm 2 cột (máy tính bảng).
int kidGridColumns(double width, {required int phone}) {
  if (width >= 1000) return phone + 2;
  if (width >= 600) return phone + 1;
  return phone;
}
