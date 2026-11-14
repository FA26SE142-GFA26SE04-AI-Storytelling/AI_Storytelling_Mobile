import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../models/child_reading_dto.dart';
import '../data/kid_reading_repository.dart';

// ─── Enum chế độ đọc ─────────────────────────────────────────────────────────

enum KidReadingMode { readFirst, listenFirst }

// ─── Trạng thái ──────────────────────────────────────────────────────────────

enum KidReaderStatus { loading, ready, error }

class KidReaderState {
  const KidReaderState({
    this.status = KidReaderStatus.loading,
    this.content,
    this.sessionId,
    this.currentPage = 0,
    this.readingMode = KidReadingMode.readFirst,
    this.totalPages = 0,
    this.isCompleting = false,
    this.isFinished = false,
    this.completedResult,
    this.lastErrorMessage,
    this.exitReason,
    this.isBookmarked = false,
    this.isFavorite = false,
    this.flags,
    this.collectedVocabIds = const <int>{},
  });

  final KidReaderStatus status;
  final ReadingContent? content;

  /// sessionId kiểu int từ backend; lưu tham chiếu để gọi các API tiếp theo.
  final int? sessionId;

  /// Trang hiện tại (0-based index vào content.scenes).
  final int currentPage;

  final KidReadingMode readingMode;

  /// Tổng số trang = số scenes.
  final int totalPages;

  /// Đang gọi API complete.
  final bool isCompleting;

  /// Đã hoàn thành truyện.
  final bool isFinished;

  final ReadingCompleted? completedResult;

  /// Thông báo lỗi API (không hiện JSON; UI đọc để toast).
  final String? lastErrorMessage;

  /// Lý do thoát từ signal hoặc lỗi 401/403/404; UI điều hướng về /kid.
  final String? exitReason;

  final bool isBookmarked;
  final bool isFavorite;

  /// Flags mới nhất trả về từ bookmark/favorite.
  final ReadingFlags? flags;

  /// Tập vocabularyId đã cất vào sổ tay trong phiên này.
  final Set<int> collectedVocabIds;

  KidReaderState copyWith({
    KidReaderStatus? status,
    ReadingContent? content,
    Object? sessionId = _sentinel,
    int? currentPage,
    KidReadingMode? readingMode,
    int? totalPages,
    bool? isCompleting,
    bool? isFinished,
    ReadingCompleted? completedResult,
    Object? lastErrorMessage = _sentinel,
    Object? exitReason = _sentinel,
    bool? isBookmarked,
    bool? isFavorite,
    ReadingFlags? flags,
    Set<int>? collectedVocabIds,
  }) {
    return KidReaderState(
      status: status ?? this.status,
      content: content ?? this.content,
      sessionId:
          sessionId == _sentinel ? this.sessionId : sessionId as int?,
      currentPage: currentPage ?? this.currentPage,
      readingMode: readingMode ?? this.readingMode,
      totalPages: totalPages ?? this.totalPages,
      isCompleting: isCompleting ?? this.isCompleting,
      isFinished: isFinished ?? this.isFinished,
      completedResult: completedResult ?? this.completedResult,
      lastErrorMessage: lastErrorMessage == _sentinel
          ? this.lastErrorMessage
          : lastErrorMessage as String?,
      exitReason:
          exitReason == _sentinel ? this.exitReason : exitReason as String?,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      isFavorite: isFavorite ?? this.isFavorite,
      flags: flags ?? this.flags,
      collectedVocabIds: collectedVocabIds ?? this.collectedVocabIds,
    );
  }
}

/// Sentinel dùng để phân biệt null rõ ràng vs "không truyền vào".
const Object _sentinel = Object();

// ─── Controller ──────────────────────────────────────────────────────────────

class KidReaderController extends Notifier<KidReaderState> {
  KidReaderController(this._storyId);
  final String _storyId;

  late KidReadingRepository _repo;

  /// Số giây hoạt động chưa được gửi lên server.
  int _pendingSeconds = 0;

  /// Chỉ cộng giây khi app ở foreground.
  bool _isForegrounded = true;

  /// Đã dispose chưa — dùng để guard trước khi set state.
  bool _disposed = false;

  // Timers
  Timer? _secondTimer;
  Timer? _signalTimer;

  /// Debounce lưu tiến độ khi lật trang.
  Timer? _progressDebounce;

  AppLifecycleListener? _lifecycleListener;

  /// Bản sao trạng thái mới nhất, dùng trong [_onDispose].
  KidReaderState _last = const KidReaderState();

  // Khoá chống bấm trùng cho các thao tác đơn lẻ.
  bool _completeLock = false;
  bool _bookmarkLock = false;
  bool _favoriteLock = false;
  bool _collectLock = false;

  @override
  KidReaderState build() {
    _repo = ref.read(kidReadingRepositoryProvider);

    ref.onDispose(_onDispose);

    // Lắng nghe vòng đời app để dừng/tiếp tục đếm giây.
    _lifecycleListener = AppLifecycleListener(
      onResume: () => _isForegrounded = true,
      onPause: () => _isForegrounded = false,
      onInactive: () => _isForegrounded = false,
      onHide: () => _isForegrounded = false,
    );

    return const KidReaderState();
  }

  // ─── Dispose ───────────────────────────────────────────────────────────────

  void _onDispose() {
    _disposed = true;
    _stopAllTimers();
    _lifecycleListener?.dispose();

    // Nếu còn tiến độ chưa gửi thì cố gắng gửi (fire-and-forget).
    // Riverpod cấm đọc `state` trong onDispose nên dùng bản sao [_last].
    final last = _last;
    final sid = last.sessionId;
    final page = last.currentPage;
    final mode = _readingModeString(last.readingMode);
    final seconds = _pendingSeconds;
    if (sid != null && seconds > 0 && !last.isFinished) {
      _repo
          .progress(
            sid.toString(),
            page: page + 1, // 1-based gửi lên server
            readingMode: mode,
            addedSeconds: seconds,
          )
          .ignore();
    }
  }

  void _stopAllTimers() {
    _secondTimer?.cancel();
    _secondTimer = null;
    _signalTimer?.cancel();
    _signalTimer = null;
    _progressDebounce?.cancel();
    _progressDebounce = null;
  }

  // ─── Khởi tải ──────────────────────────────────────────────────────────────

  /// Gọi start → content; kiểm tra sessionId/storyId khớp.
  Future<void> load() async {
    if (_disposed) return;
    _safeSetState(state.copyWith(
      status: KidReaderStatus.loading,
      exitReason: null,
      lastErrorMessage: null,
    ));

    try {
      // Bước 1: start phiên đọc.
      final started = await _repo.start(storyId: _storyId);

      if (_disposed) return;

      // Kiểm tra storyId khớp.
      if (started.storyId.toString() != _storyId) {
        _safeSetState(state.copyWith(
          status: KidReaderStatus.error,
          lastErrorMessage: 'Truyện trả về không khớp với truyện yêu cầu.',
        ));
        return;
      }

      // Bước 2: lấy nội dung.
      final loaded = await _repo.content(started.sessionId.toString());

      if (_disposed) return;

      // Kiểm tra sessionId và storyId khớp.
      if (loaded.sessionId != started.sessionId ||
          loaded.storyId != started.storyId) {
        _safeSetState(state.copyWith(
          status: KidReaderStatus.error,
          lastErrorMessage: 'Nội dung không khớp phiên đọc.',
        ));
        return;
      }

      final totalPages = loaded.scenes.length;

      // Trang bắt đầu: lastPage từ server (1-based) → 0-based index.
      final lastPage0 = started.lastPage - 1;
      final startPage = (lastPage0 >= 0 && lastPage0 < totalPages)
          ? lastPage0
          : 0;

      // Chế độ đọc ban đầu từ lastReadingMode.
      final initialMode =
          started.lastReadingMode == 'ListenFirst'
              ? KidReadingMode.listenFirst
              : KidReadingMode.readFirst;

      _safeSetState(state.copyWith(
        status: KidReaderStatus.ready,
        content: loaded,
        sessionId: started.sessionId,
        currentPage: startPage,
        readingMode: initialMode,
        totalPages: totalPages,
        isBookmarked: started.isBookmarked,
        isFavorite: started.isFavorited,
        isFinished: false,
        lastErrorMessage: null,
        exitReason: null,
        collectedVocabIds: const <int>{},
      ));

      _pendingSeconds = 0;
      _startTimers();
    } on ApiException catch (e) {
      if (_disposed) return;
      _handleApiError(e);
    } catch (e) {
      if (_disposed) return;
      _safeSetState(state.copyWith(
        status: KidReaderStatus.error,
        lastErrorMessage: 'Không tải được truyện. Vui lòng thử lại.',
      ));
    }
  }

  // ─── Timers ────────────────────────────────────────────────────────────────

  void _startTimers() {
    _stopAllTimers();

    // Đếm giây đọc, tối đa 600 giây tích lũy.
    _secondTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_isForegrounded && !state.isFinished) {
        _pendingSeconds = (_pendingSeconds + 1).clamp(0, 600);
      }
    });

    // Kiểm tra signal mỗi 8 giây.
    _signalTimer = Timer.periodic(const Duration(seconds: 8), (_) {
      _checkSignal();
    });
  }

  Future<void> _checkSignal() async {
    final sid = state.sessionId;
    if (sid == null || state.isFinished || _disposed) return;

    try {
      final signal = await _repo.signal(sid.toString());
      if (_disposed) return;

      if (signal.shouldExit) {
        _stopAllTimers();
        _safeSetState(state.copyWith(
          exitReason: signal.message ??
              'Truyện này đang nghỉ một chút, mình đọc truyện khác nhé!',
        ));
      }
    } on ApiException catch (e) {
      if (_disposed) return;
      // 401/403/404 → thoát phiên; lỗi khác bỏ qua.
      final code = e.statusCode;
      if (code == 401 || code == 403 || code == 404) {
        _stopAllTimers();
        _safeSetState(state.copyWith(
          exitReason: e.message.isNotEmpty
              ? e.message
              : 'Truyện này đang nghỉ một chút, mình đọc truyện khác nhé!',
        ));
      }
      // Lỗi khác: bỏ qua, không làm gì.
    } catch (_) {
      // Lỗi mạng khác: bỏ qua.
    }
  }

  // ─── Điều hướng trang ──────────────────────────────────────────────────────

  /// Chuyển đến trang chỉ định (0-based); debounce lưu tiến độ ~1 giây.
  void goToPage(int page) {
    if (page < 0 || page >= state.totalPages) return;
    _safeSetState(state.copyWith(currentPage: page));
    _scheduleProgressSave();
  }

  void nextPage() {
    if (state.currentPage < state.totalPages - 1) {
      goToPage(state.currentPage + 1);
    }
  }

  void prevPage() {
    if (state.currentPage > 0) {
      goToPage(state.currentPage - 1);
    }
  }

  void setReadingMode(KidReadingMode mode) {
    if (state.readingMode == mode) return;
    _safeSetState(state.copyWith(readingMode: mode));
    _scheduleProgressSave();
  }

  // ─── Lưu tiến độ ───────────────────────────────────────────────────────────

  /// Debounce: đợi ~1 giây sau thao tác cuối mới gửi.
  void _scheduleProgressSave() {
    _progressDebounce?.cancel();
    _progressDebounce = Timer(const Duration(milliseconds: 1000), () {
      if (!_disposed) saveProgressNow();
    });
  }

  /// Gửi ngay tiến độ hiện tại lên server; dùng khi thoát màn hình.
  Future<void> saveProgressNow() async {
    final sid = state.sessionId;
    if (sid == null || state.isFinished || _disposed) return;

    final seconds = _pendingSeconds;
    final page = state.currentPage;
    final mode = _readingModeString(state.readingMode);

    try {
      final result = await _repo.progress(
        sid.toString(),
        page: page + 1, // 1-based
        readingMode: mode,
        addedSeconds: seconds,
      );
      if (_disposed) return;

      // Trừ phần giây đã gửi; server có thể trả về page/mode đã chuẩn hóa.
      _pendingSeconds = (_pendingSeconds - seconds).clamp(0, 600);

      final serverPage = result.page - 1; // về 0-based
      final serverMode = result.readingMode == 'ListenFirst'
          ? KidReadingMode.listenFirst
          : KidReadingMode.readFirst;

      // Chỉ cập nhật nếu server trả về khác (tránh giật UI).
      if (serverPage != state.currentPage ||
          serverMode != state.readingMode) {
        _safeSetState(state.copyWith(
          currentPage: serverPage.clamp(0, state.totalPages - 1),
          readingMode: serverMode,
        ));
      }
    } on ApiException catch (e) {
      if (_disposed) return;
      // Không block UI, chỉ ghi lỗi vào state nếu nghiêm trọng.
      final code = e.statusCode;
      if (code == 401 || code == 403) {
        _stopAllTimers();
        _safeSetState(state.copyWith(exitReason: e.message));
      }
    } catch (_) {
      // Lỗi mạng: bỏ qua, sẽ thử lại lần sau.
    }
  }

  // ─── Hoàn thành truyện ─────────────────────────────────────────────────────

  /// Khoá chống bấm trùng: gửi progress trước, sau đó gọi complete.
  /// Trả về [ReadingCompleted] nếu thành công, null nếu thất bại.
  Future<ReadingCompleted?> complete() async {
    if (_completeLock || state.isFinished || state.isCompleting) return null;
    final sid = state.sessionId;
    if (sid == null) return null;

    _completeLock = true;
    _safeSetState(state.copyWith(isCompleting: true));

    try {
      // Gửi tiến độ trước.
      await saveProgressNow();
      if (_disposed) return null;

      // Gọi complete.
      final result = await _repo.complete(sid.toString());
      if (_disposed) return null;

      _stopAllTimers();
      _safeSetState(state.copyWith(
        isCompleting: false,
        isFinished: true,
        completedResult: result,
        lastErrorMessage: null,
      ));
      return result;
    } on ApiException catch (e) {
      if (_disposed) return null;
      _safeSetState(state.copyWith(
        isCompleting: false,
        lastErrorMessage: _friendlyError(e),
      ));
      return null;
    } catch (_) {
      if (_disposed) return null;
      _safeSetState(state.copyWith(
        isCompleting: false,
        lastErrorMessage: 'Không thể hoàn thành truyện. Vui lòng thử lại.',
      ));
      return null;
    } finally {
      _completeLock = false;
    }
  }

  // ─── Bookmark / Favorite ───────────────────────────────────────────────────

  Future<void> toggleBookmark() async {
    if (_bookmarkLock) return;
    final sid = state.sessionId;
    if (sid == null) return;

    _bookmarkLock = true;
    try {
      final newValue = !state.isBookmarked;
      final flags = await _repo.bookmark(sid.toString(), value: newValue);
      if (_disposed) return;
      _safeSetState(state.copyWith(
        isBookmarked: flags.isBookmarked,
        isFavorite: flags.isFavorited,
        flags: flags,
        lastErrorMessage: null,
      ));
    } on ApiException catch (e) {
      if (_disposed) return;
      _safeSetState(state.copyWith(lastErrorMessage: _friendlyError(e)));
    } catch (_) {
      if (_disposed) return;
      _safeSetState(state.copyWith(
        lastErrorMessage: 'Không lưu được đánh dấu. Vui lòng thử lại.',
      ));
    } finally {
      _bookmarkLock = false;
    }
  }

  Future<void> toggleFavorite() async {
    if (_favoriteLock) return;
    final sid = state.sessionId;
    if (sid == null) return;

    _favoriteLock = true;
    try {
      final newValue = !state.isFavorite;
      final flags = await _repo.favorite(sid.toString(), value: newValue);
      if (_disposed) return;
      _safeSetState(state.copyWith(
        isBookmarked: flags.isBookmarked,
        isFavorite: flags.isFavorited,
        flags: flags,
        lastErrorMessage: null,
      ));
    } on ApiException catch (e) {
      if (_disposed) return;
      _safeSetState(state.copyWith(lastErrorMessage: _friendlyError(e)));
    } catch (_) {
      if (_disposed) return;
      _safeSetState(state.copyWith(
        lastErrorMessage: 'Không lưu được yêu thích. Vui lòng thử lại.',
      ));
    } finally {
      _favoriteLock = false;
    }
  }

  // ─── Từ vựng ───────────────────────────────────────────────────────────────

  /// Cất từ vựng vào sổ tay; khoá chống bấm trùng theo vocabularyId.
  Future<bool> collectWord(int vocabularyId) async {
    if (_disposed) return false;
    if (_collectLock) return false;
    final sid = state.sessionId;
    if (sid == null) return false;
    if (state.collectedVocabIds.contains(vocabularyId)) return true;

    _collectLock = true;
    try {
      await _repo.collectWord(sid.toString(), vocabularyId: vocabularyId);
      if (_disposed) return false;
      _safeSetState(state.copyWith(
        collectedVocabIds: {...state.collectedVocabIds, vocabularyId},
        lastErrorMessage: null,
      ));
      return true;
    } on ApiException catch (e) {
      if (_disposed) return false;
      _safeSetState(state.copyWith(lastErrorMessage: _friendlyError(e)));
      return false;
    } catch (_) {
      if (_disposed) return false;
      _safeSetState(state.copyWith(
        lastErrorMessage: 'Không lưu được từ vựng. Vui lòng thử lại.',
      ));
      return false;
    } finally {
      _collectLock = false;
    }
  }

  // ─── Event helpers ─────────────────────────────────────────────────────────

  /// Gửi sự kiện TTS bắt đầu (tương đương 'TtsStarted' trong TS).
  Future<void> markTtsStarted({String? payload}) =>
      _sendEvent('TtsStarted', payload: payload);

  /// Gửi sự kiện TTS hoàn thành.
  Future<void> markTtsCompleted({String? payload}) =>
      _sendEvent('TtsCompleted', payload: payload);

  /// Gửi sự kiện trang đọc xong.
  Future<void> markPageCompleted({String? payload}) =>
      _sendEvent('PageCompleted', payload: payload);

  Future<void> _sendEvent(String eventType, {String? payload}) async {
    final sid = state.sessionId;
    if (sid == null || state.isFinished || _disposed) return;
    try {
      await _repo.event(sid.toString(),
          eventType: eventType, payload: payload);
    } on ApiException catch (e) {
      if (_disposed) return;
      // Không block UI với lỗi event; chỉ ghi message nếu cần.
      final code = e.statusCode;
      if (code == 401 || code == 403) {
        _stopAllTimers();
        _safeSetState(state.copyWith(exitReason: e.message));
      }
    } catch (_) {
      // Lỗi mạng: bỏ qua.
    }
  }

  // ─── Tiện ích ──────────────────────────────────────────────────────────────

  void _safeSetState(KidReaderState next) {
    if (_disposed) return;
    // Kiểm tra ref.mounted để tránh set state sau khi provider bị hủy.
    if (!ref.mounted) return;
    state = next;
    _last = next;
  }

  String _readingModeString(KidReadingMode mode) =>
      mode == KidReadingMode.listenFirst ? 'ListenFirst' : 'ReadFirst';

  /// Trích thông điệp lỗi từ [ApiException]; không để lộ JSON.
  String _friendlyError(ApiException e) {
    final msg = e.message.trim();
    return msg.isNotEmpty ? msg : 'Có lỗi xảy ra. Vui lòng thử lại.';
  }

  /// Xử lý lỗi API nghiêm trọng khi load.
  void _handleApiError(ApiException e) {
    final code = e.statusCode;
    if (code == 401 || code == 403 || code == 404) {
      _safeSetState(state.copyWith(
        status: KidReaderStatus.error,
        exitReason: _friendlyError(e),
      ));
    } else {
      _safeSetState(state.copyWith(
        status: KidReaderStatus.error,
        lastErrorMessage: _friendlyError(e),
      ));
    }
  }
}

// ─── Provider ────────────────────────────────────────────────────────────────

/// Family theo storyId (String).
/// Dùng: ref.watch(kidReaderControllerProvider(storyId))
final kidReaderControllerProvider = NotifierProvider.autoDispose.family<
    KidReaderController, KidReaderState, String>(
  KidReaderController.new,
);
