import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../data/models/child_models.dart';
import '../../data/models/story_models.dart';
import '../../domain/story_view.dart';
import '../auth/auth_controller.dart';

// Dữ liệu chung của khu người lớn (tương đương WorkspaceDataContext bên web):
// danh sách bé, bé đang chọn, truyện của bé đó và hàng chờ duyệt.

/// Không tự thử lại khi lỗi: hiện lỗi kèm nút "Thử lại" để phụ huynh chủ động.
Duration? _noRetry(int retryCount, Object error) => null;

/// Hồ sơ các bé của tài khoản đang đăng nhập. Tải lại khi đổi tài khoản.
final childrenProvider = FutureProvider<List<ChildProfile>>((ref) async {
  ref.watch(authControllerProvider.select((a) => a.value?.id));
  return (await ref.watch(childRepositoryProvider).getMyChildren()).unwrap();
}, retry: _noRetry);

/// Bé đang chọn, nhớ giữa các lần mở app.
final selectedChildIdProvider = NotifierProvider<SelectedChildController, int?>(SelectedChildController.new);

class SelectedChildController extends Notifier<int?> {
  static const _key = 'taletale-child-id';

  @override
  int? build() => ref.watch(sharedPreferencesProvider).getInt(_key);

  void select(int id) {
    state = id;
    ref.read(sharedPreferencesProvider).setInt(_key, id);
  }
}

/// Bé được chọn; nếu chưa chọn (hoặc bé đã chọn không còn) thì lấy bé đang hoạt động đầu tiên.
ChildProfile? pickChild(List<ChildProfile> kids, int? wanted) {
  if (kids.isEmpty) return null;
  return kids.where((k) => k.id == wanted).firstOrNull ?? kids.where((k) => k.isActive).firstOrNull ?? kids.first;
}

final selectedChildProvider = Provider<AsyncValue<ChildProfile?>>((ref) {
  final wanted = ref.watch(selectedChildIdProvider);
  return ref.watch(childrenProvider).whenData((kids) => pickChild(kids, wanted));
});

/// Truyện của bé đang chọn, mới nhất trước. Kéo xuống để tải lại: `ref.refresh(storiesProvider.future)`.
final storiesProvider = FutureProvider<List<Story>>((ref) async {
  final child = pickChild(await ref.watch(childrenProvider.future), ref.watch(selectedChildIdProvider));
  if (child == null) return const [];
  final res = await ref.watch(storyRepositoryProvider).getStories(StoryFilter(childProfileId: child.id));
  return res.unwrap().items;
}, retry: _noRetry);

/// Truyện AI viết xong, đang chờ phụ huynh duyệt nội dung.
final reviewQueueProvider = Provider<List<Story>>((ref) => ref.watch(storiesProvider).value?.where(awaitsReview).toList() ?? const []);

/// Một truyện theo id (màn chi tiết).
final storyDetailProvider = FutureProvider.family<Story, int>(
  (ref, id) async => (await ref.watch(storyRepositoryProvider).getStory(id)).unwrap(),
  retry: _noRetry,
);
