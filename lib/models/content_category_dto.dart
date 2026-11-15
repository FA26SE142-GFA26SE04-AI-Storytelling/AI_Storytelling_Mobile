import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_category_dto.freezed.dart';
part 'content_category_dto.g.dart';

@freezed
abstract class ContentCategoryDto with _$ContentCategoryDto {
  const factory ContentCategoryDto({
    required int id,
    required String code,
    required String displayName,
    required bool isActive,
    @Default([]) List<String> defaultBlockedAgeBands,
  }) = _ContentCategoryDto;

  factory ContentCategoryDto.fromJson(Map<String, dynamic> json) =>
      _$ContentCategoryDtoFromJson(json);
}
