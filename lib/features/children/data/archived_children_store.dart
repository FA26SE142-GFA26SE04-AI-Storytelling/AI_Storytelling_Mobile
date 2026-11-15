import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../auth/application/auth_controller.dart';

/// Thông tin tóm tắt của hồ sơ bé đã lưu trữ.
class ArchivedChild {
  final int id;
  final String nickname;
  final int? avatarId;

  const ArchivedChild({
    required this.id,
    required this.nickname,
    this.avatarId,
  });

  factory ArchivedChild.fromJson(Map<String, dynamic> json) {
    final rawAvatarId = json['avatarId'];
    return ArchivedChild(
      id: (json['id'] as num?)?.toInt() ?? int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      nickname: (json['nickname'] as String?) ?? '',
      avatarId: rawAvatarId is num
          ? rawAvatarId.toInt()
          : (rawAvatarId != null ? int.tryParse(rawAvatarId.toString()) : null),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nickname': nickname,
      'avatarId': avatarId,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArchivedChild &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nickname == other.nickname &&
          avatarId == other.avatarId;

  @override
  int get hashCode => Object.hash(id, nickname, avatarId);
}

/// Lưu trữ danh sách hồ sơ bé đã lưu trữ trên bộ nhớ an toàn theo tài khoản hiện tại.
class ArchivedChildrenStore {
  ArchivedChildrenStore({
    FlutterSecureStorage? storage,
    this._ref,
    int? Function()? getUserId,
  })  : _storage = storage ?? const FlutterSecureStorage(),
        _getUserIdOverride = getUserId;

  final FlutterSecureStorage _storage;
  final Ref? _ref;
  final int? Function()? _getUserIdOverride;

  int? _getUserId() {
    if (_getUserIdOverride != null) {
      return _getUserIdOverride();
    }
    if (_ref != null) {
      final authState = _ref.read(authControllerProvider);
      if (authState is AuthSignedIn) {
        return authState.user.id;
      }
      if (authState is AuthBlocked) {
        return authState.user.id;
      }
    }
    return null;
  }

  String _key(int userId) => 'archived_children_$userId';

  /// Tải danh sách hồ sơ bé đã lưu trữ.
  /// Trả về [] nếu chưa có user hoặc chưa có dữ liệu, hoặc khi JSON bị lỗi.
  Future<List<ArchivedChild>> load() async {
    final userId = _getUserId();
    if (userId == null) {
      return [];
    }

    try {
      final raw = await _storage.read(key: _key(userId));
      if (raw == null || raw.isEmpty) {
        return [];
      }

      final decoded = jsonDecode(raw);
      if (decoded is! List) {
        return [];
      }

      final list = <ArchivedChild>[];
      for (final item in decoded) {
        if (item is Map) {
          list.add(ArchivedChild.fromJson(Map<String, dynamic>.from(item)));
        }
      }
      return list;
    } catch (_) {
      return [];
    }
  }

  /// Thêm hoặc thay thế thông tin hồ sơ bé đã lưu trữ.
  Future<void> add(ArchivedChild c) async {
    final userId = _getUserId();
    if (userId == null) {
      return;
    }

    final current = await load();
    final index = current.indexWhere((element) => element.id == c.id);
    if (index >= 0) {
      current[index] = c;
    } else {
      current.add(c);
    }

    final raw = jsonEncode(current.map((e) => e.toJson()).toList());
    await _storage.write(key: _key(userId), value: raw);
  }

  /// Xoá hồ sơ bé đã lưu trữ theo [id].
  Future<void> remove(int id) async {
    final userId = _getUserId();
    if (userId == null) {
      return;
    }

    final current = await load();
    current.removeWhere((element) => element.id == id);

    final raw = jsonEncode(current.map((e) => e.toJson()).toList());
    await _storage.write(key: _key(userId), value: raw);
  }
}

/// Provider cung cấp instance [ArchivedChildrenStore].
final archivedChildrenStoreProvider = Provider<ArchivedChildrenStore>((ref) {
  return ArchivedChildrenStore(ref: ref);
});

/// Provider tải danh sách hồ sơ bé đã lưu trữ của người dùng hiện tại.
final archivedChildrenProvider =
    FutureProvider.autoDispose<List<ArchivedChild>>((ref) async {
  final store = ref.watch(archivedChildrenStoreProvider);
  return store.load();
});
