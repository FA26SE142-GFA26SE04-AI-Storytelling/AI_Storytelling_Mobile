import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_text_field.dart';
import '../../../core/widgets/tt_toast.dart';
import '../../../models/event_dto.dart';
import '../data/event_logic.dart';
import '../data/event_repository.dart';
import 'event_widgets.dart';

// Các thao tác trên màn chi tiết sự kiện: mỗi thao tác mở popup, gửi API trong
// popup (khoá nút lúc gửi), xong thì làm mới dữ liệu và báo toast.

/// Tải lại mọi dữ liệu liên quan tới sự kiện [eventId]. Dùng container (không
/// dùng ref của màn) để vẫn chạy được khi người dùng đã rời màn.
void refreshEventData(ProviderContainer container, int eventId) {
  container
    ..invalidate(eventDetailProvider(eventId))
    ..invalidate(missionDashboardProvider(eventId))
    ..invalidate(myParticipationsProvider)
    ..invalidate(myRewardsProvider)
    ..invalidate(eventListProvider);
}

/// Chạy [send]; lỗi thì toast [fallback] (hoặc lời Backend) và trả false.
Future<bool> _send(
  BuildContext context,
  int eventId,
  Future<(String, TtToastType)> Function(EventRepository repo) send,
  String fallback,
) async {
  final container = ProviderScope.containerOf(context, listen: false);
  try {
    final (message, type) = await send(container.read(eventRepositoryProvider));
    refreshEventData(container, eventId);
    if (context.mounted) {
      showTtToast(context, message, type: type);
    }
    return true;
  } catch (e) {
    if (context.mounted) {
      showTtToast(
        context,
        e is ApiException ? e.message : fallback,
        type: TtToastType.error,
      );
    }
    return false;
  }
}

/// Popup thể lệ → "Đồng ý & đăng ký". Gia đình kiểu cũ: [trackType] 'Parent';
/// kiểu hoạt động: [activityType] + [eventActivityId].
Future<void> confirmEventRegister(
  BuildContext context,
  EventDetailDto detail, {
  String? trackType,
  String? activityType,
  int? eventActivityId,
  required String successText,
}) {
  final rules = detail.activeRule?.rulesText.trim() ?? '';
  return showEventDialog(
    context,
    title: 'Thể lệ sự kiện',
    confirmLabel: 'Đồng ý & đăng ký',
    confirmIcon: Icons.auto_awesome_rounded,
    body: (_) => Text(
      rules.isEmpty ? 'Sự kiện chưa công bố thể lệ chi tiết.' : rules,
      style: Theme.of(context).textTheme.bodyMedium,
    ),
    onConfirm: () => _send(context, detail.id, (repo) async {
      final p = await repo.register(
        detail.id,
        trackType: trackType,
        activityType: activityType,
        eventActivityId: eventActivityId,
      );
      final warning = p.safetyWarning?.trim() ?? '';
      return warning.isEmpty
          ? (successText, TtToastType.success)
          : (warning, TtToastType.info);
    }, 'Chưa đăng ký được. Bạn thử lại nhé.'),
  );
}

/// Nhiệm vụ tự xác nhận: chọn truyện gia đình đã làm rồi gửi.
Future<void> confirmEventCheckin(
  BuildContext context,
  int eventId,
  EventTaskProgressItemDto task,
  List<EventStoryLibraryItemDto> stories,
) {
  int? picked;
  final tt = context.tt;
  final textTheme = Theme.of(context).textTheme;
  return showEventDialog(
    context,
    title: 'Xác nhận nhiệm vụ',
    confirmLabel: 'Xác nhận',
    confirmIcon: Icons.check_rounded,
    ready: () => picked != null,
    body: (setState) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          stories.isEmpty
              ? 'Sự kiện chưa có truyện để chọn.'
              : 'Chọn truyện gia đình đã cùng làm "${task.title}":',
          style: textTheme.bodyMedium,
        ),
        for (final s in stories) ...[
          const SizedBox(height: 8),
          Material(
            color: picked == s.storyId
                ? tt.gold.withValues(alpha: 0.18)
                : tt.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(TtRadius.md),
              side: BorderSide(
                color: picked == s.storyId ? tt.goldDeep : tt.line2,
                width: 1.2,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => setState(() => picked = s.storyId),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(
                      picked == s.storyId
                          ? Icons.radio_button_checked_rounded
                          : Icons.radio_button_unchecked_rounded,
                      color: picked == s.storyId ? tt.goldDeep : tt.muted,
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Text(s.title, style: textTheme.titleSmall)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ],
    ),
    onConfirm: () => _send(context, eventId, (repo) async {
      await repo.completeTask(
        eventId,
        task.taskDefinitionId,
        storyId: picked,
        selfDeclaredPayloadJson: jsonEncode({
          'confirmedAt': DateTime.now().toUtc().toIso8601String(),
        }),
      );
      return ('Đã cập nhật tiến độ nhiệm vụ.', TtToastType.success);
    }, 'Chưa ghi nhận được nhiệm vụ. Bạn thử lại nhé.'),
  );
}

/// Nhận thưởng: quà / chuyển khoản thì nhập thông tin nhận, còn lại chỉ xác nhận.
Future<void> confirmEventClaim(
  BuildContext context,
  int eventId,
  EventAwardSlotDto award,
) {
  final keys = claimFieldsFor(award.rewardType);
  final fields = <String, String>{};
  final textTheme = Theme.of(context).textTheme;
  return showEventDialog(
    context,
    title: 'Nhận thưởng: ${award.rewardName}',
    confirmLabel: 'Nhận thưởng',
    confirmIcon: Icons.card_giftcard_rounded,
    body: (_) => keys.isEmpty
        ? Text(
            award.rewardType == 'PlatformCredits'
                ? 'Xác nhận nhận ${award.creditGrantAmount} lượt AI vào tài khoản.'
                : 'Xác nhận nhận ${rewardTypeLabel[award.rewardType] ?? 'phần thưởng'} vào tài khoản.',
            style: textTheme.bodyMedium,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final key in keys) ...[
                if (key != keys.first) const SizedBox(height: 12),
                TtTextField(
                  label: claimFieldLabels[key] ?? key,
                  keyboardType: switch (key) {
                    'phoneNumber' => TextInputType.phone,
                    'bankAccountNumber' => TextInputType.number,
                    'shippingAddress' => TextInputType.streetAddress,
                    _ => TextInputType.text,
                  },
                  textInputAction: key == keys.last
                      ? TextInputAction.done
                      : TextInputAction.next,
                  onChanged: (v) => fields[key] = v,
                ),
              ],
            ],
          ),
    onConfirm: () async {
      final built = buildClaimRequest(award.rewardType, fields);
      if (built.error != null) {
        showTtToast(context, built.error!, type: TtToastType.error);
        return false;
      }
      return _send(context, eventId, (repo) async {
        await repo.claimReward(award.id, built.request!);
        return ('Đã nhận thưởng thành công.', TtToastType.success);
      }, 'Chưa nhận được thưởng. Bạn thử lại nhé.');
    },
  );
}
