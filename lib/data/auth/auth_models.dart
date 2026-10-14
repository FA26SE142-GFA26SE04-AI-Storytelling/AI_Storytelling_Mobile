import '../json.dart';

export '../json.dart' show Json;

class UserProfile {
  const UserProfile({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.role,
    required this.status,
    this.phoneNumber,
    this.avatarUrl,
  });

  factory UserProfile.fromJson(Json json) => UserProfile(
    id: asInt(json['id']),
    username: json['username'] as String? ?? '',
    email: json['email'] as String? ?? '',
    fullName: json['fullName'] as String? ?? '',
    role: json['role'] as String? ?? '',
    status: json['status'] as String? ?? '',
    phoneNumber: json['phoneNumber'] as String?,
    avatarUrl: json['avatarUrl'] as String?,
  );

  final int id;
  final String username;
  final String email;
  final String fullName;
  final String role;
  final String status;
  final String? phoneNumber;
  final String? avatarUrl;

  /// Tên gọi trong lời chào: chữ cuối của họ tên ("Nguyễn Thu Hà" → "Hà").
  String get givenName {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    return parts.last.isNotEmpty ? parts.last : (username.isNotEmpty ? username : 'bạn');
  }

  String get initial {
    final name = fullName.trim().isNotEmpty ? fullName.trim() : username.trim();
    return name.isEmpty ? '?' : String.fromCharCode(name.runes.first).toUpperCase();
  }

  Json toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'fullName': fullName,
    'role': role,
    'status': status,
    'phoneNumber': phoneNumber,
    'avatarUrl': avatarUrl,
  };

  @override
  bool operator ==(Object other) => other is UserProfile && other.id == id && other.email == email && other.fullName == fullName && other.status == status;

  @override
  int get hashCode => Object.hash(id, email, fullName, status);
}

class AuthSession {
  const AuthSession({required this.accessToken, required this.refreshToken, required this.user, this.tokenType = 'Bearer', this.expiresInSeconds = 0});

  factory AuthSession.fromJson(Json json) => AuthSession(
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
    tokenType: json['tokenType'] as String? ?? 'Bearer',
    expiresInSeconds: json['expiresInSeconds'] == null ? 0 : asInt(json['expiresInSeconds']),
    user: UserProfile.fromJson(asJson(json['user'])),
  );

  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresInSeconds;
  final UserProfile user;
}
