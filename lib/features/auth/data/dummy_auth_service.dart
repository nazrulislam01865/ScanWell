class DummyAuthService {
  DummyAuthService._();

  static final DummyAuthService instance = DummyAuthService._();

  static const verificationCode = '123456';

  String displayName = 'Aminul';
  String email = 'aminul@gmail.com';

  String? _pendingName;
  String? _pendingEmail;

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    if (password.trim().length < 6) return false;

    this.email = email.trim();
    displayName = _nameFromEmail(email);
    return true;
  }

  Future<void> requestLoginOtp(String email) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    _pendingEmail = email.trim();
    _pendingName = _nameFromEmail(email);
  }

  Future<void> createAccount({
    required String name,
    required String email,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    _pendingName = name.trim().isEmpty ? _nameFromEmail(email) : name.trim();
    _pendingEmail = email.trim();
  }

  Future<bool> verify(String code) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    if (code != verificationCode) return false;

    if (_pendingEmail != null) email = _pendingEmail!;
    if (_pendingName != null) displayName = _pendingName!;
    _pendingEmail = null;
    _pendingName = null;
    return true;
  }

  String _nameFromEmail(String value) {
    final localPart = value.trim().split('@').first;
    if (localPart.isEmpty) return 'Aminul';
    return '${localPart[0].toUpperCase()}${localPart.substring(1)}';
  }
}
