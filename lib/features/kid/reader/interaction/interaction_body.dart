import '../../../../models/listening_dto.dart';
import '../../../../models/reading_interaction_dto.dart';

/// Danh sách loại tương tác dạng chọn 1 đáp án.
const Set<String> kChoiceTypes = {'Checkpoint', 'PicturePrediction'};

/// Kiểm tra xem loại tương tác có phải là sắp xếp thứ tự sự kiện hay không.
bool isEventOrdering(String type) => type == 'EventOrdering';

/// Xây dựng payload [ListeningAttemptRequestDto] dựa trên loại tương tác [ReadingInteractionDto.type].
///
/// - `Checkpoint` hoặc `PicturePrediction`: cần [optionId]. Nếu null trả về null.
/// - `FillBlank`: cần [answer] không rỗng sau khi trim. Nếu rỗng trả về null.
/// - `EventOrdering`: cần [orderedOptionIds] không rỗng. Nếu null hoặc rỗng trả về null.
/// - `RolePlay`: gửi request rỗng [ListeningAttemptRequestDto].
/// - Các loại khác: trả về null.
ListeningAttemptRequestDto? buildAttemptBody(
  ReadingInteractionDto q, {
  int? optionId,
  String? answer,
  List<int>? orderedOptionIds,
}) {
  final type = q.type;

  if (kChoiceTypes.contains(type)) {
    if (optionId == null) return null;
    return ListeningAttemptRequestDto(optionId: optionId);
  }

  if (type == 'FillBlank') {
    final trimmed = answer?.trim();
    if (trimmed == null || trimmed.isEmpty) return null;
    return ListeningAttemptRequestDto(answer: trimmed);
  }

  if (isEventOrdering(type)) {
    if (orderedOptionIds == null || orderedOptionIds.isEmpty) return null;
    return ListeningAttemptRequestDto(orderedOptionIds: orderedOptionIds);
  }

  if (type == 'RolePlay') {
    return const ListeningAttemptRequestDto();
  }

  return null;
}
