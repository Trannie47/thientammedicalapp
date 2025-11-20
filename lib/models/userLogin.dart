class UserLogin {
  final String taiKhoang;
  final String matKhau;
  final bool rememberMe;

  const UserLogin({
    required this.taiKhoang,
    required this.matKhau,
    this.rememberMe = false,
  });

  // Lấy dữ liệu từ JSON (từ API hoặc local storage)
  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      taiKhoang: json['taiKhoang'] as String,
      matKhau: json['matKhau'] as String,
      rememberMe: (json['rememberMe'] as int?) == 1, // tinyint(1)
    );
  }

  // Convert ngược lại để lưu vào server hoặc SharedPreferences
  Map<String, dynamic> toJson() {
    return {
      'maNV': taiKhoang,
      'tenNhanVien': matKhau,
      'rememberMe': rememberMe ? 1 : 0,
    };
  }

  // CopyWith để update 1 vài trường
  UserLogin copyWith({
    String? taiKhoang,
    String? matKhau,
    bool? rememberMe,
  }) {
    return UserLogin(
      taiKhoang: taiKhoang ?? this.taiKhoang,
      matKhau: matKhau ?? this.matKhau,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }

  @override
  String toString() {
    return 'UserLogin(taiKhoang: $taiKhoang, matKhau: $matKhau, rememberMe: $rememberMe)';
  }
}
