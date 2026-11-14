import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_button.dart';
import '../../../core/widgets/tt_card.dart';
import '../../../core/widgets/tt_network_image.dart';
import '../../../core/widgets/tt_state_views.dart';
import '../../../core/widgets/tt_text_field.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/child_reading_dto.dart';
import '../data/kid_reading_repository.dart';

// ─── Controller State ────────────────────────────────────────────────────────

class KidLibraryState {
  final bool isLoadingInitial;
  final bool isLoadingMore;
  final String? errorMessage;
  final List<ChildStory> stories;
  final bool isLocked;
  final int? unlockStoryId;
  final String? lockedMessage;
  final int pageIndex;
  final bool hasMore;
  final String searchQuery;

  const KidLibraryState({
    this.isLoadingInitial = true,
    this.isLoadingMore = false,
    this.errorMessage,
    this.stories = const <ChildStory>[],
    this.isLocked = false,
    this.unlockStoryId,
    this.lockedMessage,
    this.pageIndex = 1,
    this.hasMore = true,
    this.searchQuery = '',
  });

  KidLibraryState copyWith({
    bool? isLoadingInitial,
    bool? isLoadingMore,
    String? errorMessage,
    bool clearError = false,
    List<ChildStory>? stories,
    bool? isLocked,
    int? unlockStoryId,
    String? lockedMessage,
    int? pageIndex,
    bool? hasMore,
    String? searchQuery,
  }) {
    return KidLibraryState(
      isLoadingInitial: isLoadingInitial ?? this.isLoadingInitial,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      stories: stories ?? this.stories,
      isLocked: isLocked ?? this.isLocked,
      unlockStoryId: unlockStoryId ?? this.unlockStoryId,
      lockedMessage: lockedMessage ?? this.lockedMessage,
      pageIndex: pageIndex ?? this.pageIndex,
      hasMore: hasMore ?? this.hasMore,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

// ─── Riverpod Notifier ───────────────────────────────────────────────────────

class KidLibraryController extends Notifier<KidLibraryState> {
  int _requestId = 0;
  static const int _pageSize = 20;

  @override
  KidLibraryState build() {
    Future.microtask(() => loadInitial());
    return const KidLibraryState();
  }

  Future<void> loadInitial({
    String? search,
    void Function(String message)? onErrorToast,
  }) async {
    final reqId = ++_requestId;
    final query = search ?? state.searchQuery;

    state = state.copyWith(
      isLoadingInitial: true,
      clearError: true,
      searchQuery: query,
    );

    try {
      final repository = ref.read(kidReadingRepositoryProvider);
      final page = await repository.storyPage(
        search: query.trim().isEmpty ? null : query.trim(),
        pageIndex: 1,
        pageSize: _pageSize,
      );

      if (reqId != _requestId) return;

      final items = page.items;
      final hasMore = items.length >= _pageSize;

      state = state.copyWith(
        isLoadingInitial: false,
        clearError: true,
        stories: items,
        isLocked: page.isLocked,
        unlockStoryId: page.unlockStoryId,
        lockedMessage: page.message,
        pageIndex: 1,
        hasMore: hasMore,
      );
    } catch (e) {
      if (reqId != _requestId) return;

      final message = e is ApiException
          ? e.message
          : 'Không thể tải thư viện truyện. Em hãy thử lại nhé.';

      state = state.copyWith(isLoadingInitial: false, errorMessage: message);
      if (onErrorToast != null) {
        onErrorToast(message);
      }
    }
  }

  Future<void> loadMore({void Function(String message)? onErrorToast}) async {
    if (state.isLoadingInitial ||
        state.isLoadingMore ||
        !state.hasMore ||
        state.isLocked) {
      return;
    }

    final reqId = _requestId;
    state = state.copyWith(isLoadingMore: true);

    final nextPage = state.pageIndex + 1;

    try {
      final repository = ref.read(kidReadingRepositoryProvider);
      final query = state.searchQuery.trim();
      final page = await repository.storyPage(
        search: query.isEmpty ? null : query,
        pageIndex: nextPage,
        pageSize: _pageSize,
      );

      if (reqId != _requestId) return;

      final newItems = page.items;
      final hasMore = newItems.length >= _pageSize;

      state = state.copyWith(
        isLoadingMore: false,
        stories: [...state.stories, ...newItems],
        pageIndex: nextPage,
        hasMore: hasMore,
      );
    } catch (e) {
      if (reqId != _requestId) return;

      final message = e is ApiException
          ? e.message
          : 'Không thể tải thêm truyện. Em hãy thử lại nhé.';

      state = state.copyWith(isLoadingMore: false);
      if (onErrorToast != null) {
        onErrorToast(message);
      }
    }
  }
}

final kidLibraryControllerProvider =
    NotifierProvider.autoDispose<KidLibraryController, KidLibraryState>(
      KidLibraryController.new,
    );

// ─── Screen Widget ──────────────────────────────────────────────────────────

class KidLibraryScreen extends ConsumerStatefulWidget {
  const KidLibraryScreen({super.key});

  @override
  ConsumerState<KidLibraryScreen> createState() => _KidLibraryScreenState();
}

class _KidLibraryScreenState extends ConsumerState<KidLibraryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounceTimer;
  String _lastSubmittedQuery = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _searchController.addListener(_onSearchInput);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.removeListener(_onSearchInput);
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= 200) {
      ref
          .read(kidLibraryControllerProvider.notifier)
          .loadMore(
            onErrorToast: (message) {
              if (mounted) {
                showTtToast(context, message, type: TtToastType.error);
              }
            },
          );
    }
  }

  void _onSearchInput() {
    final query = _searchController.text;
    if (query == _lastSubmittedQuery) return;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _lastSubmittedQuery = _searchController.text;
      _triggerSearch(_searchController.text);
    });
  }

  void _triggerSearch(String query) {
    _debounceTimer?.cancel();
    _lastSubmittedQuery = query;
    ref
        .read(kidLibraryControllerProvider.notifier)
        .loadInitial(
          search: query,
          onErrorToast: (message) {
            if (mounted) {
              showTtToast(context, message, type: TtToastType.error);
            }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(kidLibraryControllerProvider);
    final tt = context.tt;

    return Scaffold(
      backgroundColor: tt.bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context),
            _buildSearchBar(context),
            Expanded(child: _buildContent(context, state)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final tt = context.tt;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          TtIconButton(
            icon: Icons.arrow_back_rounded,
            tooltip: 'Quay lại',
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/kid');
              }
            },
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Thư viện truyện',
              style: TextStyle(
                fontFamily: 'Baloo2',
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: tt.text,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TtTextField(
              label: 'Tìm kiếm',
              hint: 'Em muốn đọc truyện gì?',
              controller: _searchController,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) => _triggerSearch(value),
              validator: null,
            ),
          ),
          // Nút xoá nhanh chỉ hiện khi đã gõ chữ; xoá xong listener tự tải lại danh sách.
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _searchController,
            builder: (context, value, _) => value.text.isEmpty
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 2),
                    child: TtIconButton(
                      icon: Icons.close_rounded,
                      tooltip: 'Xoá tìm kiếm',
                      onPressed: _searchController.clear,
                    ),
                  ),
          ),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: TtIconButton(
              icon: Icons.search_rounded,
              tooltip: 'Tìm kiếm',
              onPressed: () => _triggerSearch(_searchController.text),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, KidLibraryState state) {
    final tt = context.tt;

    if (state.isLoadingInitial) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) =>
              TtSkeleton(radius: BorderRadius.circular(TtRadius.lg)),
        ),
      );
    }

    if (state.errorMessage != null && state.stories.isEmpty) {
      return Center(
        child: TtErrorState(
          title: 'Chưa mở được thư viện truyện',
          message: state.errorMessage!,
          onRetry: () => ref
              .read(kidLibraryControllerProvider.notifier)
              .loadInitial(search: _searchController.text),
        ),
      );
    }

    if (state.stories.isEmpty) {
      if (state.isLocked) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: _buildLockedCard(context, state),
        );
      }

      final hasSearch = state.searchQuery.trim().isNotEmpty;
      return RefreshIndicator(
        onRefresh: () async {
          await ref
              .read(kidLibraryControllerProvider.notifier)
              .loadInitial(search: _searchController.text);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: TtEmptyState(
              icon: Icons.menu_book_rounded,
              title: hasSearch
                  ? 'Không tìm thấy truyện phù hợp'
                  : 'Thư viện chưa có truyện',
              message: hasSearch
                  ? 'Em thử tìm tên khác hoặc gõ từ khoá ngắn hơn nhé.'
                  : 'Em hãy quay lại sau hoặc nhờ bố mẹ chọn truyện nhé.',
              actionLabel: hasSearch ? 'Xoá tìm kiếm' : null,
              onAction: hasSearch
                  ? () {
                      _searchController.clear();
                      _triggerSearch('');
                    }
                  : null,
            ),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref
            .read(kidLibraryControllerProvider.notifier)
            .loadInitial(search: _searchController.text);
      },
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          if (state.isLocked)
            SliverToBoxAdapter(child: _buildLockedCard(context, state)),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final story = state.stories[index];
                return _buildStoryCard(context, story);
              }, childCount: state.stories.length),
            ),
          ),
          if (state.isLoadingMore)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(tt.primary),
                    ),
                  ),
                ),
              ),
            )
          else
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
    );
  }

  Widget _buildStoryCard(BuildContext context, ChildStory story) {
    final tt = context.tt;

    return TtCard(
      padding: const EdgeInsets.all(10),
      onTap: () => context.push('/kid/read/${story.storyId}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SizedBox.expand(
              child: TtNetworkImage(
                url: story.coverImageUrl,
                fit: BoxFit.cover,
                radius: BorderRadius.circular(TtRadius.md),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            story.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: tt.text,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLockedCard(BuildContext context, KidLibraryState state) {
    final tt = context.tt;
    final message =
        (state.lockedMessage != null && state.lockedMessage!.trim().isNotEmpty)
        ? state.lockedMessage!.trim()
        : 'Thư viện đang tạm khoá. Em hoàn thành truyện đang mở trước nhé!';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: tt.gold.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(TtRadius.lg),
        border: Border.all(
          color: tt.goldDeep.withValues(alpha: 0.6),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.lock_rounded, color: tt.goldDeep, size: 28),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Thư viện đang tạm khoá',
                  style: TextStyle(
                    fontFamily: 'Baloo2',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: tt.text,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: tt.text,
            ),
          ),
          if (state.unlockStoryId != null) ...[
            const SizedBox(height: 12),
            TtButton(
              label: 'Đọc truyện mở khoá',
              icon: Icons.menu_book_rounded,
              variant: TtButtonVariant.primary,
              onPressed: () => context.push('/kid/read/${state.unlockStoryId}'),
            ),
          ],
        ],
      ),
    );
  }
}
