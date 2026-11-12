/// Model thông tin người dùng
class UserProfile {
  final int id;
  final String username;
  final String email;
  final String fullName;
  final String role;
  final String status;
  final String? avatarUrl;

  const UserProfile({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.role,
    required this.status,
    this.avatarUrl,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: (json['id'] as num).toInt(),
      username: (json['username'] as String?) ?? '',
      email: (json['email'] as String?) ?? '',
      fullName: (json['fullName'] as String?) ?? '',
      role: (json['role'] as String?) ?? '',
      status: (json['status'] as String?) ?? '',
      avatarUrl: json['avatarUrl'] as String?,
    );
  }
}

/// Model phiên đăng nhập chứa token và thông tin người dùng
class AuthSession {
  final String accessToken;
  final String refreshToken;
  final UserProfile user;

  const AuthSession({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory AuthSession.fromJson(Map<String, dynamic> json) {
    return AuthSession(
      accessToken: (json['accessToken'] as String?) ?? '',
      refreshToken: (json['refreshToken'] as String?) ?? '',
      user: UserProfile.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}
