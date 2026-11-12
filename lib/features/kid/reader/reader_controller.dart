import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../../../core/network/api_exception.dart';
import '../../../models/listening_dto.dart';
import '../../../models/read_aloud_dto.dart';
import '../../../models/reading_content_dto.dart';
import '../../../models/reading_interaction_dto.dart';
import '../../../models/reading_start_dto.dart';
import '../data/kid_session_controller.dart';
import 'data/reading_repository.dart';
import 'media/authed_media.dart';
import 'reader_narrator.dart';
import 'reader_pages.dart';
import 'reader_recorder.dart';

/// Trạng thái ghi âm đọc to của bé.
enum AloudState {
  /// Đang rảnh rỗi, không ghi âm.
  idle,

  /// Đang trong quá trình ghi âm giọng đọc của bé.
  recording,

  /// Đang xử lý hoặc gửi âm thanh lên máy chủ để chấm điểm.
  busy,
}

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
    this.pendingInteraction,
    this.attemptResult,
    this.attemptedInteractionIds = const [],
    this.voiceEnabled = false,
    this.aloudState = AloudState.idle,
    this.aloudResult,
    this.notice,
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

  /// Tương tác đang chờ bé trả lời hoặc hiển thị.
  final ReadingInteractionDto? pendingInteraction;

  /// Kết quả làm bài tương tác vừa gửi.
  final ListeningAttemptResultDto? attemptResult;

  /// Danh sách mã các tương tác đã hoàn thành trong phiên đọc.
  final List<int> attemptedInteractionIds;

  /// Cho phép tương tác hoặc đọc to bằng giọng nói.
  final bool voiceEnabled;

  /// Trạng thái tiến trình đọc to bằng micro.
  final AloudState aloudState;

  /// Kết quả đọc to vừa nhận.
  final ReadAloudResultDto? aloudResult;

  /// Thông báo ngắn cho toast cảnh báo.
  final String? notice;

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
    Object? pendingInteraction = _sentinel,
    Object? attemptResult = _sentinel,
    List<int>? attemptedInteractionIds,
    bool? voiceEnabled,
    AloudState? aloudState,
    Object? aloudResult = _sentinel,
    Object? notice = _sentinel,
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
      pendingInteraction: identical(pendingInteraction, _sentinel)
          ? this.pendingInteraction
          : pendingInteraction as ReadingInteractionDto?,
      attemptResult: identical(attemptResult, _sentinel)
          ? this.attemptResult
          : attemptResult as ListeningAttemptResultDto?,
      attemptedInteractionIds:
          attemptedInteractionIds ?? this.attemptedInteractionIds,
      voiceEnabled: voiceEnabled ?? this.voiceEnabled,
      aloudState: aloudState ?? this.aloudState,
      aloudResult: identical(aloudResult, _sentinel)
          ? this.aloudResult
          : aloudResult as ReadAloudResultDto?,
      notice: identical(notice, _sentinel) ? this.notice : notice as String?,
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
  AudioPlayer? _feedbackPlayer;
  ReaderRecorder? _recorder;
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
      _feedbackPlayer?.dispose();
      _recorder?.dispose();
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

      state = state.copyWith(voiceEnabled: kMicSupported);
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
    state = state.copyWith(
      index: target,
      playing: false,
      aloudResult: null,
      attemptResult: null,
      pendingInteraction: null,
    );

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
    _feedbackPlayer?.stop();
    await _recorder?.dispose();
    _recorder = null;
    _cancelTimers();
    await saveNow();
  }

  /// Kiểm tra xem trang hiện tại có cần hiển thị tương tác hay không.
  bool needsInteraction() {
    if (state.listenOnly) return false;
    final pages = state.pages;
    final index = state.index;
    if (pages.isEmpty || index < 0 || index >= pages.length) return false;

    final currentPage = pages[index];
    final isLastPageOfScene = index == pages.length - 1 ||
        pages[index + 1].sceneIndex != currentPage.sceneIndex;
    if (!isLastPageOfScene) return false;

    final content = state.content;
    if (content == null) return false;

    ReadingSceneDto? scene;
    for (final s in content.scenes) {
      if (s.sceneIndex == currentPage.sceneIndex) {
        scene = s;
        break;
      }
    }
    if (scene == null) return false;

    final interaction = scene.interaction;
    if (interaction == null) return false;
    if (scene.attemptedInSession) return false;
    if (state.attemptedInteractionIds.contains(interaction.id)) return false;

    return true;
  }

  /// Lấy tương tác cần hiển thị của trang hiện tại nếu có.
  ReadingInteractionDto? get currentInteraction {
    if (!needsInteraction()) return null;
    final pages = state.pages;
    final index = state.index;
    if (pages.isEmpty || index < 0 || index >= pages.length) return null;
    final currentSceneIndex = pages[index].sceneIndex;
    final content = state.content;
    if (content == null) return null;
    for (final s in content.scenes) {
      if (s.sceneIndex == currentSceneIndex) {
        return s.interaction;
      }
    }
    return null;
  }

  /// Gửi câu trả lời cho câu hỏi tương tác.
  Future<ListeningAttemptResultDto?> submitAttempt(
    ReadingInteractionDto q,
    ListeningAttemptRequestDto body,
  ) async {
    final token = _token();
    final sessionId = state.sessionId;
    if (token == null || sessionId == null) return null;

    try {
      final result = await _repo.attemptInteraction(
        token: token,
        sessionId: sessionId,
        interactionId: q.id,
        body: body,
      );
      state = state.copyWith(
        attemptResult: result,
        attemptedInteractionIds: [...state.attemptedInteractionIds, q.id],
      );
      final audioUrl = result.feedbackAudioUrl;
      if (audioUrl != null && audioUrl.trim().isNotEmpty) {
        unawaited(_playFeedback(audioUrl));
      }
      return result;
    } on ApiException catch (e) {
      state = state.copyWith(notice: e.message);
      return null;
    }
  }

  /// Phát âm thanh phản hồi cho tương tác bằng AudioPlayer riêng.
  Future<void> _playFeedback(String url) async {
    try {
      final player = _feedbackPlayer ??= AudioPlayer();
      await player.stop();
      final source = await _resolveSource(url);
      await player.setAudioSource(source);
      await player.play();
    } catch (_) {
      // Bỏ qua lỗi phát âm thanh phản hồi
    }
  }

  /// Đóng tương tác hiện tại và dừng phát âm thanh phản hồi.
  void closeInteraction() {
    _feedbackPlayer?.stop();
    state = state.copyWith(
      pendingInteraction: null,
      attemptResult: null,
    );
  }

  /// Phát lại cảnh từ trang đầu tiên của cảnh có chỉ số [sceneIndex].
  Future<void> replayScene(int sceneIndex) async {
    final idx = state.pages.indexWhere((p) => p.sceneIndex == sceneIndex);
    closeInteraction();
    if (idx != -1) {
      await goTo(idx);
    }
  }

  /// Bật hoặc dừng chế độ đọc to bằng giọng nói qua micro.
  Future<void> toggleReadAloud() async {
    if (!state.voiceEnabled) return;
    if (!kMicSupported) return;

    if (state.aloudState == AloudState.idle) {
      final rec = _recorder ??= ReaderRecorder();

      await _narrator?.stop();
      state = state.copyWith(playing: false);

      final ok = await rec.start(
        onLimit: () {
          if (state.aloudState == AloudState.recording) {
            toggleReadAloud();
          }
        },
      );
      if (!ok) {
        state = state.copyWith(notice: 'Em cho phép dùng micro để đọc to nhé.');
        return;
      }

      state = state.copyWith(
        aloudState: AloudState.recording,
        aloudResult: null,
      );
      return;
    }

    if (state.aloudState == AloudState.recording) {
      state = state.copyWith(aloudState: AloudState.busy);
      final rec = _recorder;
      final bytes = await rec?.stop();

      if (state.pages.isEmpty ||
          state.index < 0 ||
          state.index >= state.pages.length) {
        state = state.copyWith(
          notice: 'Em thử đọc lại nhé.',
          aloudState: AloudState.idle,
        );
        return;
      }

      final segment = segmentAtPageStart(state.pages[state.index]);
      if (segment == null || bytes == null) {
        state = state.copyWith(
          notice: 'Em thử đọc lại nhé.',
          aloudState: AloudState.idle,
        );
        return;
      }

      final segmentId = segment.segmentId;

      final token = _token();
      final sessionId = state.sessionId;
      if (token == null || sessionId == null) {
        state = state.copyWith(aloudState: AloudState.idle);
        return;
      }

      try {
        final r = await _repo.readAloud(
          token: token,
          sessionId: sessionId,
          segmentId: segmentId,
          wavBytes: bytes,
        );
        state = state.copyWith(
          aloudResult: r,
          notice: r.message.isEmpty ? null : r.message,
        );
      } on ApiException catch (e) {
        final isDenied = e.statusCode == 401 || e.statusCode == 403;
        state = state.copyWith(
          notice: e.message,
          voiceEnabled: isDenied ? false : state.voiceEnabled,
        );
      } finally {
        state = state.copyWith(aloudState: AloudState.idle);
      }
    }
  }

  /// Xóa kết quả đọc to hiện tại.
  void clearReadAloud() {
    state = state.copyWith(aloudResult: null);
  }

  /// Xóa thông báo toast hiện tại sau khi hiển thị.
  void clearNotice() {
    state = state.copyWith(notice: null);
  }

  /// Gán tương tác đang chờ phản hồi.
  void setPendingInteraction(ReadingInteractionDto? interaction) {
    state = state.copyWith(pendingInteraction: interaction);
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
