/// Authenticated user entity.
class AuthUser {
  const AuthUser({
    required this.id,
    required this.fullName,
    required this.email,
    this.mobile,
  });

  final String id;
  final String fullName;
  final String email;
  final String? mobile;
}
