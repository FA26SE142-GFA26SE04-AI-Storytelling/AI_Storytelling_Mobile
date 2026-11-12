import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_exception.dart';
import '../../../models/my_roadmap_dto.dart';
import '../data/kid_repository.dart';
import '../data/kid_session_controller.dart';

class KidHomeData {
  const KidHomeData({
    required this.nickname,
    required this.roadmap,
  });

  final String nickname;
  final MyRoadmapDto roadmap;
}

final kidHomeDataProvider = FutureProvider.autoDispose<KidHomeData>((ref) async {
  final state = ref.watch(kidSessionProvider);
  if (state is! KidActive) {
    throw const ApiException(
      statusCode: 401,
      message: 'Phiên của bé đã hết hạn.',
    );
  }

  final token = state.session.accessToken;
  final repo = ref.watch(kidRepositoryProvider);

  final profile = await repo.getSessionProfile(token);
  final roadmap = await repo.getMyRoadmap(token);

  return KidHomeData(
    nickname: profile.nickname,
    roadmap: roadmap,
  );
});
