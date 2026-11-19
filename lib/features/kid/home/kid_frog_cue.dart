import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

/// Động tác mặt/tay của ếch (giống FrogPokeAction trên web).
enum KidFrogAction { wave, spin, tongue, dance, wink }

/// Kênh nối sảnh với ếch: nút gọi [act] khi bé chạm xuống; [pointer] là vị trí ngón tay
/// trên sảnh (toạ độ màn hình), null khi nhấc tay.
class KidFrogCue extends ChangeNotifier {
  KidFrogAction? action;
  int count = 0;
  final ValueNotifier<Offset?> pointer = ValueNotifier(null);

  void act(KidFrogAction a) {
    action = a;
    count++;
    notifyListeners();
  }

  @override
  void dispose() {
    pointer.dispose();
    super.dispose();
  }
}
