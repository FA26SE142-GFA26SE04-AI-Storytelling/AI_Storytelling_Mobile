// ignore_for_file: experimental_member_use // just_audio coi API này là thử nghiệm
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/theme/tt_colors.dart';
import '../../../../core/theme/tt_radius.dart';
import '../../../../core/widgets/tt_network_image.dart';
import '../../data/kid_session_controller.dart';

final _childManualStoryAssetPattern =
    RegExp(r'^/api/v1/child/manual-stories/\d+/assets/\d+$');
final _parentStoryAssetPattern =
    RegExp(r'^/api/v1/parent/stories/\d+/packages/\d+/assets/\d+$');

/// Kiểm tra URL media có phải endpoint nội bộ yêu cầu Bearer token hay không.
bool isAuthedMediaUrl(String? url) {
  if (url == null || url.trim().isEmpty) {
    return false;
  }
  final uri = Uri.tryParse(url);
  if (uri == null) {
    return false;
  }
  final path = uri.path;
  if (path.isEmpty) {
    return false;
  }
  return _childManualStoryAssetPattern.hasMatch(path) ||
      _parentStoryAssetPattern.hasMatch(path);
}

/// Tải dữ liệu byte của media với Bearer token từ phiên đọc của bé.
final authedBytesProvider =
    FutureProvider.family<Uint8List, String>((ref, url) async {
  final sessionState = ref.watch(kidSessionProvider);
  if (sessionState is! KidActive) {
    throw const ApiException(
      statusCode: 401,
      message: 'Phiên của bé đã hết hạn.',
    );
  }

  final token = sessionState.session.accessToken;
  final dio = ref.watch(dioProvider);

  try {
    final response = await dio.get<List<int>>(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        headers: {'Authorization': 'Bearer $token'},
        extra: {'child': true},
      ),
    );
    return Uint8List.fromList(response.data ?? const []);
  } on DioException catch (e) {
    throw ApiException.fromDioException(e);
  }
});

/// Nguồn phát âm thanh dạng stream từ byte trong bộ nhớ cho just_audio.
class AuthedBytesAudioSource extends StreamAudioSource {
  AuthedBytesAudioSource(this.bytes, {super.tag});

  /// Dữ liệu byte âm thanh.
  final Uint8List bytes;

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    final s = start ?? 0;
    final e = end ?? bytes.length;
    final part = bytes.sublist(s, e);
    return StreamAudioResponse(
      sourceLength: bytes.length,
      contentLength: part.length,
      offset: s,
      stream: Stream.value(part),
      contentType: 'audio/mpeg',
    );
  }
}

/// Widget hiển thị ảnh: tự phân biệt ảnh công khai và ảnh nội bộ cần Bearer token.
class AuthedAwareImage extends ConsumerWidget {
  const AuthedAwareImage({
    super.key,
    this.url,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.radius = const BorderRadius.all(Radius.circular(TtRadius.lg)),
  });

  /// Đường dẫn hình ảnh.
  final String? url;

  /// Cách co dãn ảnh.
  final BoxFit fit;

  /// Chiều rộng khung ảnh.
  final double? width;

  /// Chiều cao khung ảnh.
  final double? height;

  /// Bán kính bo góc khung ảnh.
  final BorderRadiusGeometry radius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!isAuthedMediaUrl(url)) {
      return TtNetworkImage(
        url: url,
        fit: fit,
        width: width,
        height: height,
        radius: radius,
      );
    }

    final asyncBytes = ref.watch(authedBytesProvider(url!));

    return asyncBytes.when(
      data: (bytes) => ClipRRect(
        borderRadius: radius,
        child: Image.memory(
          bytes,
          fit: fit,
          width: width,
          height: height,
        ),
      ),
      loading: () => SizedBox(
        width: width,
        height: height,
        child: Container(
          decoration: BoxDecoration(
            color: context.tt.panel,
            borderRadius: radius,
          ),
        ),
      ),
      error: (_, _) => TtNetworkImage(
        url: null,
        fit: fit,
        width: width,
        height: height,
        radius: radius,
      ),
    );
  }
}
