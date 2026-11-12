import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../../../core/network/api_exception.dart';
import '../../../models/reading_content_dto.dart';
import '../../../models/reading_start_dto.dart';
import '../data/kid_session_controller.dart';
import 'data/reading_repository.dart';
import 'media/authed_media.dart';
import 'reader_narrator.dart';
import 'reader_pages.dart';

/// Trạng thái bất biến của màn hình đọc truyện.
class ReaderState {
  const ReaderState({
    this.sessionId,
    this.title = '',
    this.pages = const [],
    this.index = 0,
    this.readingMode = 'ReadFirst',
    this.listenOnly = false,
    this.isBookmarked = false,
    this.isFavorited = false,
    this.loading = true,
    this.completing = false,
    this.playing = false,
    this.error,
    this.exitMessage,
    this.completed,
    this.activeSegmentId,
    this.content,
  });

  /// Mã phiên đọc truyện hiện tại.
  final int? sessionId;

  /// Tên câu chuyện.
  final String title;

  /// Danh sách các trang đọc đã tách.
  final List<ReaderPage> pages;

  /// Vị trí trang hiện tại (0-based).
  final int index;

  /// Chế độ đọc: 'ReadFirst' hoặc 'ListenFirst'.
  final String readingMode;

  /// Chế độ chỉ nghe (không tự lật hoặc tương tác chữ).
  final bool listenOnly;

  /// Trạng thái đã đánh dấu trang hay chưa.
  final bool isBookmarked;

  /// Trạng thái truyện yêu thích của bé.
  final bool isFavorited;

  /// Đang tải dữ liệu truyện hoặc phiên đọc.
  final bool loading;

  /// Đang gửi yêu cầu hoàn thành câu chuyện.
  final bool completing;

  /// Trạng thái giọng đọc TTS đang phát.
  final bool playing;

  /// Thông báo lỗi nếu có.
  final String? error;

  /// Thông báo yêu cầu thoát phiên đọc từ phụ huynh.
  final String? exitMessage;

  /// Kết quả nhận thưởng khi hoàn thành truyện.
  final ReadingCompletedDto? completed;

  /// Mã phân đoạn đang được đọc bởi giọng đọc TTS.
  final int? activeSegmentId;

  /// Nội dung câu chuyện đọc được tải về.
  final ReadingContentDto? content;

  /// Trang đọc hiện tại hoặc `null` nếu chưa có trang.
  ReaderPage? get current => pages.isEmpty ? null : pages[index];

  /// Sao chép trạng thái với các giá trị thay đổi.
  ReaderState copyWith({
    int? sessionId,
    String? title,
    List<ReaderPage>? pages,
    int? index,
    String? readingMode,
    bool? listenOnly,
    bool? isBookmarked,
    bool? isFavorited,
    bool? loading,
    bool? completing,
    bool? playing,
    Object? error = _sentinel,
    Object? exitMessage = _sentinel,
    Object? completed = _sentinel,
    Object? activeSegmentId = _sentinel,
    Object? content = _sentinel,
  }) {
    return ReaderState(
      sessionId: sessionId ?? this.sessionId,
      title: title ?? this.title,
      pages: pages ?? this.pages,
      index: index ?? this.index,
      readingMode: readingMode ?? this.readingMode,
      listenOnly: listenOnly ?? this.listenOnly,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      isFavorited: isFavorited ?? this.isFavorited,
      loading: loading ?? this.loading,
      completing: completing ?? this.completing,
      playing: playing ?? this.playing,
      error: identical(error, _sentinel) ? this.error : error as String?,
      exitMessage:
          identical(exitMessage, _sentinel) ? this.exitMessage : exitMessage as String?,
      completed: identical(completed, _sentinel)
          ? this.completed
          : completed as ReadingCompletedDto?,
      activeSegmentId: identical(activeSegmentId, _sentinel)
          ? this.activeSegmentId
          : activeSegmentId as int?,
      content: identical(content, _sentinel)
          ? this.content
          : content as ReadingContentDto?,
    );
  }

  static const _sentinel = Object();
}

/// Provider quản lý controller đọc truyện theo từng câu chuyện.
final readerControllerProvider =
    NotifierProvider.autoDispose.family<ReaderController, ReaderState, int>(
  ReaderController.new,
);

/// Controller điều phối phiên đọc truyện của bé.
class ReaderController extends Notifier<ReaderState> {
  ReaderController(this.storyId);

  /// Mã truyện đang đọc.
  final int storyId;

  ReaderNarrator? _narrator;
  bool _narratorListening = false;
  Timer? _signalTimer;
  Timer? _activeSecondsTimer;
  Timer? _saveDebounceTimer;
  int _activeSeconds = 0;

  ReadingRepository get _repo => ref.read(readingRepositoryProvider);

  @override
  ReaderState build() {
    ref.onDispose(() {
      _cancelTimers();
      _narrator?.dispose();
    });
    return const ReaderState();
  }

  /// Lấy access token hiện tại từ phiên đọc của bé.
  String? _token() {
    final s = ref.read(kidSessionProvider);
    if (s is KidActive) {
      return s.session.accessToken;
    }
    return null;
  }

  /// Khởi tạo phiên đọc và tải nội dung câu chuyện.
  Future<void> open() async {
    final token = _token();
    if (token == null) {
      state = state.copyWith(
        loading: false,
        error: 'Phiên của bé đã hết hạn.',
      );
      return;
    }

    state = state.copyWith(loading: true, error: null);

    try {
      final started = await _repo.start(token: token, storyId: storyId);
      final content =
          await _repo.content(token: token, sessionId: started.sessionId);
      final pages = buildReaderPages(content);

      if (pages.isEmpty) {
        state = state.copyWith(
          loading: false,
          error: 'Truyện chưa có trang để đọc.',
        );
        return;
      }

      final index = indexForLastPage(pages, started.lastPage);
      final readingMode =
          started.lastReadingMode == 'ListenFirst' ? 'ListenFirst' : 'ReadFirst';

      state = state.copyWith(
        sessionId: started.sessionId,
        content: content,
        title: content.title,
        pages: pages,
        index: index,
        readingMode: readingMode,
        listenOnly: content.listenOnly,
        isBookmarked: started.isBookmarked,
        isFavorited: started.isFavorited,
        loading: false,
        error: null,
      );

      _signalTimer?.cancel();
      _signalTimer = Timer.periodic(
        const Duration(seconds: 8),
        (_) => _checkSignal(),
      );

      _activeSecondsTimer?.cancel();
      _activeSecondsTimer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => _activeSeconds++,
      );
    } on ApiException catch (e) {
      state = state.copyWith(loading: false, error: e.message);
    }
  }

  /// Chuyển tới trang có chỉ số [i].
  Future<void> goTo(int i) async {
    if (state.pages.isEmpty) return;
    final target = i.clamp(0, state.pages.length - 1);
    if (target == state.index) return;

    final oldPage = state.pages[state.index];
    final newPage = state.pages[target];

    if (newPage.sceneIndex != oldPage.sceneIndex) {
      _scheduleSave();
      final token = _token();
      if (token != null && state.sessionId != null) {
        _repo
            .sendEvent(
              token: token,
              sessionId: state.sessionId!,
              eventType: 'PageCompleted',
            )
            .catchError((_) {});
      }
    }

    await _narrator?.stop();
    state = state.copyWith(index: target, playing: false);

    if (state.readingMode == 'ListenFirst') {
      await _play();
    }
  }

  /// Chuyển sang trang tiếp theo.
  Future<void> next() => goTo(state.index + 1);

  /// Quay lại trang trước đó.
  Future<void> prev() => goTo(state.index - 1);

  /// Bật hoặc tạm dừng giọng đọc minh họa.
  Future<void> togglePlay() async {
    if (state.playing) {
      await _narrator?.stop();
      state = state.copyWith(playing: false);
    } else {
      await _play();
    }
  }

  /// Phát âm thanh phân đoạn của trang hiện tại.
  Future<void> _play() async {
    final current = state.current;
    if (current == null) return;

    final narrator = _narrator ??= ReaderNarrator(resolve: _resolveSource);
    if (!_narratorListening) {
      _narratorListening = true;
      narrator.activeSegmentId.addListener(() {
        state = state.copyWith(activeSegmentId: narrator.activeSegmentId.value);
      });
    }

    try {
      await narrator.playSegments(
        current.segments,
        onStarted: () {
          state = state.copyWith(playing: true);
          final token = _token();
          if (token != null && state.sessionId != null) {
            _repo
                .sendEvent(
                  token: token,
                  sessionId: state.sessionId!,
                  eventType: 'TtsStarted',
                )
                .catchError((_) {});
          }
        },
        onFinished: () {
          state = state.copyWith(playing: false);
          final token = _token();
          if (token != null && state.sessionId != null) {
            _repo
                .sendEvent(
                  token: token,
                  sessionId: state.sessionId!,
                  eventType: 'TtsCompleted',
                )
                .catchError((_) {});
          }
        },
      );
    } catch (_) {
      state = state.copyWith(
        playing: false,
        error: 'Chưa phát được giọng đọc.',
      );
    }
  }

  /// Chuyển đổi đường dẫn URL thành nguồn âm thanh phù hợp cho just_audio.
  Future<AudioSource> _resolveSource(String url) async {
    if (isAuthedMediaUrl(url)) {
      final bytes = await ref.read(authedBytesProvider(url).future);
      return AuthedBytesAudioSource(bytes);
    }
    return AudioSource.uri(Uri.parse(url));
  }

  /// Bật/tắt trạng thái đánh dấu trang.
  Future<void> toggleBookmark() async {
    final token = _token();
    if (token == null || state.sessionId == null) return;

    try {
      final flags = await _repo.setBookmark(
        token: token,
        sessionId: state.sessionId!,
        value: !state.isBookmarked,
      );
      state = state.copyWith(isBookmarked: flags.isBookmarked);
    } on ApiException catch (e) {
      state = state.copyWith(error: e.message);
    }
  }

  /// Bật/tắt trạng thái yêu thích truyện.
  Future<void> toggleFavorite() async {
    final token = _token();
    if (token == null || state.sessionId == null) return;

    try {
      final flags = await _repo.setFavorite(
        token: token,
        sessionId: state.sessionId!,
        value: !state.isFavorited,
      );
      state = state.copyWith(isFavorited: flags.isFavorited);
    } on ApiException catch (e) {
      state = state.copyWith(error: e.message);
    }
  }

  /// Hoàn thành phiên đọc và nhận thưởng.
  Future<ReadingCompletedDto?> complete() async {
    if (state.completing || state.sessionId == null) return null;
    final token = _token();
    if (token == null) return null;

    state = state.copyWith(completing: true);
    await saveNow();

    try {
      final result = await _repo.complete(
        token: token,
        sessionId: state.sessionId!,
      );
      state = state.copyWith(completed: result, completing: false);
      return result;
    } on ApiException catch (e) {
      state = state.copyWith(completing: false, error: e.message);
      return null;
    }
  }

  /// Dừng phiên đọc và lưu tiến độ khi rời màn hình.
  Future<void> leave() async {
    await _narrator?.stop();
    _cancelTimers();
    await saveNow();
  }

  /// Lên lịch lưu tiến độ đọc (debounce 1.5 giây).
  void _scheduleSave() {
    _saveDebounceTimer?.cancel();
    _saveDebounceTimer = Timer(
      const Duration(milliseconds: 1500),
      () => saveNow(),
    );
  }

  /// Lưu tiến độ đọc trang hiện tại và thời gian đọc lên hệ thống.
  Future<void> saveNow() async {
    _saveDebounceTimer?.cancel();
    _saveDebounceTimer = null;

    if (state.sessionId == null || state.pages.isEmpty) return;
    final current = state.current;
    if (current == null) return;

    final token = _token();
    if (token == null) return;

    final seconds = _activeSeconds;
    _activeSeconds = 0;

    try {
      await _repo.saveProgress(
        token: token,
        sessionId: state.sessionId!,
        page: current.savePage,
        readingMode: state.readingMode,
        addedSeconds: seconds,
      );
    } catch (_) {
      // Bỏ qua lỗi lưu tiến độ định kỳ
    }
  }

  /// Kiểm tra tín hiệu từ phụ huynh định kỳ.
  Future<void> _checkSignal() async {
    if (state.exitMessage != null) return;
    final token = _token();
    if (token == null || state.sessionId == null) return;

    try {
      final signal = await _repo.signal(
        token: token,
        sessionId: state.sessionId!,
      );
      if (signal.shouldExit) {
        await _narrator?.stop();
        _cancelTimers();
        state = state.copyWith(
          exitMessage: signal.message ?? 'Bố mẹ đã kết thúc phiên đọc này.',
        );
      }
    } catch (_) {
      // Bỏ qua lỗi kiểm tra tín hiệu
    }
  }

  /// Hủy các bộ đếm thời gian đang chạy.
  void _cancelTimers() {
    _signalTimer?.cancel();
    _signalTimer = null;
    _activeSecondsTimer?.cancel();
    _activeSecondsTimer = null;
    _saveDebounceTimer?.cancel();
    _saveDebounceTimer = null;
  }
}
