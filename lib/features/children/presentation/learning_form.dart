import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/tt_colors.dart';
import '../../../core/theme/tt_radius.dart';
import '../../../core/widgets/tt_card.dart';

/// Giá trị biểu mẫu học tập của bé.
class LearningFormValue {
  const LearningFormValue({
    required this.readingLevel,
    required this.readingMode,
    this.comprehensionGoal = '',
    this.favoriteTopics = const [],
    this.priorityFocusAreas = const [],
  });

  /// Mức đọc từ 1 đến 5.
  final int readingLevel;

  /// Chế độ đọc: 'ListenFirst' hoặc 'ReadFirst'.
  final String readingMode;

  /// Mục tiêu đọc hiểu.
  final String comprehensionGoal;

  /// Danh sách chủ đề bé yêu thích (relation: FavoriteTopic).
  final List<String> favoriteTopics;

  /// Danh sách kỹ năng muốn ưu tiên (relation: PriorityFocusArea).
  final List<String> priorityFocusAreas;

  LearningFormValue copyWith({
    int? readingLevel,
    String? readingMode,
    String? comprehensionGoal,
    List<String>? favoriteTopics,
    List<String>? priorityFocusAreas,
  }) {
    return LearningFormValue(
      readingLevel: readingLevel ?? this.readingLevel,
      readingMode: readingMode ?? this.readingMode,
      comprehensionGoal: comprehensionGoal ?? this.comprehensionGoal,
      favoriteTopics: favoriteTopics ?? this.favoriteTopics,
      priorityFocusAreas: priorityFocusAreas ?? this.priorityFocusAreas,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LearningFormValue &&
        other.readingLevel == readingLevel &&
        other.readingMode == readingMode &&
        other.comprehensionGoal == comprehensionGoal &&
        listEquals(other.favoriteTopics, favoriteTopics) &&
        listEquals(other.priorityFocusAreas, priorityFocusAreas);
  }

  @override
  int get hashCode => Object.hash(
        readingLevel,
        readingMode,
        comprehensionGoal,
        Object.hashAll(favoriteTopics),
        Object.hashAll(priorityFocusAreas),
      );
}

/// Biểu mẫu cấu hình hồ sơ học tập cho bé.
class LearningForm extends StatefulWidget {
  const LearningForm({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  final LearningFormValue value;
  final ValueChanged<LearningFormValue> onChanged;
  final bool enabled;

  @override
  State<LearningForm> createState() => _LearningFormState();
}

class _LearningFormState extends State<LearningForm> {
  late final TextEditingController _goalController;
  late final TextEditingController _favoriteTopicInputController;
  late final TextEditingController _priorityAreaInputController;

  String _lastReportedGoal = '';

  static const Map<int, String> _readingLevelDescriptions = {
    1: 'Tương đương lớp 1',
    2: 'Tương đương lớp 2',
    3: 'Tương đương lớp 3',
    4: 'Tương đương lớp 4',
    5: 'Tương đương lớp 5',
  };

  @override
  void initState() {
    super.initState();
    _lastReportedGoal = widget.value.comprehensionGoal;
    _goalController = TextEditingController(text: widget.value.comprehensionGoal);
    _favoriteTopicInputController = TextEditingController();
    _priorityAreaInputController = TextEditingController();
  }

  @override
  void didUpdateWidget(LearningForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value.comprehensionGoal != _lastReportedGoal) {
      _lastReportedGoal = widget.value.comprehensionGoal;
      _goalController.text = widget.value.comprehensionGoal;
    }
  }

  @override
  void dispose() {
    _goalController.dispose();
    _favoriteTopicInputController.dispose();
    _priorityAreaInputController.dispose();
    super.dispose();
  }

  void _onGoalChanged(String text) {
    final trimmed = text.trim();
    _lastReportedGoal = trimmed;
    widget.onChanged(widget.value.copyWith(comprehensionGoal: trimmed));
  }

  void _addTopic({
    required TextEditingController controller,
    required List<String> currentList,
    required ValueChanged<List<String>> onListChanged,
  }) {
    final text = controller.text.trim();
    if (text.isEmpty) {
      return;
    }

    final isDuplicate = currentList.any(
      (item) => item.toLowerCase() == text.toLowerCase(),
    );

    if (!isDuplicate) {
      onListChanged([...currentList, text]);
    }
    controller.clear();
  }

  void _removeTopic({
    required String itemToRemove,
    required List<String> currentList,
    required ValueChanged<List<String>> onListChanged,
  }) {
    onListChanged(
      currentList
          .where((item) => item.toLowerCase() != itemToRemove.toLowerCase())
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final titleStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: tt.text,
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // a. Mức đọc
        TtCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Mức đọc', style: titleStyle),
              const SizedBox(height: 12),
              Row(
                children: [
                  for (int level = 1; level <= 5; level++) ...[
                    if (level > 1) const SizedBox(width: 8),
                    Expanded(
                      child: _ReadingLevelButton(
                        level: level,
                        isSelected: widget.value.readingLevel == level,
                        enabled: widget.enabled,
                        onTap: widget.enabled
                            ? () {
                                if (widget.value.readingLevel != level) {
                                  widget.onChanged(
                                    widget.value.copyWith(readingLevel: level),
                                  );
                                }
                              }
                            : null,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _readingLevelDescriptions[widget.value.readingLevel] ??
                    'Tương đương lớp ${widget.value.readingLevel}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: tt.muted,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // b. Chế độ đọc
        TtCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Chế độ đọc', style: titleStyle),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _ReadingModeCard(
                      label: 'Nghe trước',
                      icon: Icons.headphones,
                      hint: 'Tự đọc to cả truyện, chữ to, tranh lớn',
                      isSelected: widget.value.readingMode == 'ListenFirst',
                      enabled: widget.enabled,
                      onTap: widget.enabled
                          ? () {
                              if (widget.value.readingMode != 'ListenFirst') {
                                widget.onChanged(
                                  widget.value.copyWith(
                                    readingMode: 'ListenFirst',
                                  ),
                                );
                              }
                            }
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ReadingModeCard(
                      label: 'Tự đọc',
                      icon: Icons.menu_book,
                      hint: 'Bé tự đọc, bấm loa khi cần nghe',
                      isSelected: widget.value.readingMode == 'ReadFirst',
                      enabled: widget.enabled,
                      onTap: widget.enabled
                          ? () {
                              if (widget.value.readingMode != 'ReadFirst') {
                                widget.onChanged(
                                  widget.value.copyWith(
                                    readingMode: 'ReadFirst',
                                  ),
                                );
                              }
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // c. Mục tiêu đọc hiểu (không bắt buộc)
        TtCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Mục tiêu đọc hiểu (không bắt buộc)', style: titleStyle),
              const SizedBox(height: 12),
              TextField(
                controller: _goalController,
                readOnly: !widget.enabled,
                enabled: widget.enabled,
                minLines: 1,
                maxLines: 3,
                maxLength: 500,
                onChanged: _onGoalChanged,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: tt.text,
                    ),
                decoration: InputDecoration(
                  hintText: 'Ví dụ: hiểu ý chính, nhớ tên nhân vật',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: tt.muted,
                      ),
                  counterText: '',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(TtRadius.md),
                    borderSide: BorderSide(color: tt.line2, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(TtRadius.md),
                    borderSide: BorderSide(color: tt.line2, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(TtRadius.md),
                    borderSide: BorderSide(color: tt.primaryStrong, width: 1.5),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(TtRadius.md),
                    borderSide: BorderSide(
                      color: tt.line2.withValues(alpha: 0.5),
                      width: 1.5,
                    ),
                  ),
                  fillColor: tt.panel,
                  filled: true,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // d. Chủ đề bé yêu thích
        TtCard(
          child: _TopicInputSection(
            title: 'Chủ đề bé yêu thích',
            titleStyle: titleStyle,
            items: widget.value.favoriteTopics,
            hintText: 'Ví dụ: khủng long',
            controller: _favoriteTopicInputController,
            enabled: widget.enabled,
            onAdd: () => _addTopic(
              controller: _favoriteTopicInputController,
              currentList: widget.value.favoriteTopics,
              onListChanged: (updated) => widget.onChanged(
                widget.value.copyWith(favoriteTopics: updated),
              ),
            ),
            onRemove: (topic) => _removeTopic(
              itemToRemove: topic,
              currentList: widget.value.favoriteTopics,
              onListChanged: (updated) => widget.onChanged(
                widget.value.copyWith(favoriteTopics: updated),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // e. Kỹ năng muốn ưu tiên
        TtCard(
          child: _TopicInputSection(
            title: 'Kỹ năng muốn ưu tiên',
            titleStyle: titleStyle,
            items: widget.value.priorityFocusAreas,
            hintText: 'Ví dụ: suy luận, từ vựng',
            controller: _priorityAreaInputController,
            enabled: widget.enabled,
            onAdd: () => _addTopic(
              controller: _priorityAreaInputController,
              currentList: widget.value.priorityFocusAreas,
              onListChanged: (updated) => widget.onChanged(
                widget.value.copyWith(priorityFocusAreas: updated),
              ),
            ),
            onRemove: (area) => _removeTopic(
              itemToRemove: area,
              currentList: widget.value.priorityFocusAreas,
              onListChanged: (updated) => widget.onChanged(
                widget.value.copyWith(priorityFocusAreas: updated),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ReadingLevelButton extends StatelessWidget {
  const _ReadingLevelButton({
    required this.level,
    required this.isSelected,
    required this.enabled,
    required this.onTap,
  });

  final int level;
  final bool isSelected;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final borderRadius = BorderRadius.circular(TtRadius.md);

    return Material(
      color: isSelected ? tt.primaryStrong : tt.panel,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Container(
          constraints: const BoxConstraints(minHeight: 48),
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: isSelected
                ? null
                : Border.all(
                    color: tt.line2,
                    width: 1.5,
                  ),
          ),
          alignment: Alignment.center,
          child: Text(
            '$level',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : tt.text,
                ),
          ),
        ),
      ),
    );
  }
}

class _ReadingModeCard extends StatelessWidget {
  const _ReadingModeCard({
    required this.label,
    required this.icon,
    required this.hint,
    required this.isSelected,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final String hint;
  final bool isSelected;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;
    final borderRadius = BorderRadius.circular(TtRadius.md);

    return Material(
      color: isSelected ? tt.gold.withValues(alpha: 0.12) : tt.panel,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Container(
          constraints: const BoxConstraints(minHeight: 48),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(
              color: isSelected ? tt.primaryStrong : tt.line2,
              width: isSelected ? 2.0 : 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 20,
                    color: isSelected ? tt.primaryStrong : tt.muted,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      label,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? tt.primaryStrong : tt.text,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                hint,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: tt.muted,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopicInputSection extends StatelessWidget {
  const _TopicInputSection({
    required this.title,
    required this.titleStyle,
    required this.items,
    required this.hintText,
    required this.controller,
    required this.enabled,
    required this.onAdd,
    required this.onRemove,
  });

  final String title;
  final TextStyle? titleStyle;
  final List<String> items;
  final String hintText;
  final TextEditingController controller;
  final bool enabled;
  final VoidCallback onAdd;
  final ValueChanged<String> onRemove;

  @override
  Widget build(BuildContext context) {
    final tt = context.tt;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: titleStyle),
        if (items.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map((item) {
              return InputChip(
                label: Text(item),
                labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: tt.text,
                    ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(TtRadius.md),
                  side: BorderSide(color: tt.line2, width: 1.0),
                ),
                backgroundColor: tt.panel,
                deleteIconColor: tt.muted,
                onDeleted: enabled ? () => onRemove(item) : null,
              );
            }).toList(),
          ),
        ],
        if (enabled) ...[
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  maxLength: 150,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => onAdd(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: tt.text,
                      ),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle:
                        Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: tt.muted,
                            ),
                    counterText: '',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(TtRadius.md),
                      borderSide: BorderSide(color: tt.line2, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(TtRadius.md),
                      borderSide: BorderSide(color: tt.line2, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(TtRadius.md),
                      borderSide: BorderSide(
                        color: tt.primaryStrong,
                        width: 1.5,
                      ),
                    ),
                    fillColor: tt.panel,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.add),
                color: tt.primaryStrong,
                constraints: const BoxConstraints(
                  minWidth: 48,
                  minHeight: 48,
                ),
                onPressed: onAdd,
              ),
            ],
          ),
        ],
      ],
    );
  }
}
