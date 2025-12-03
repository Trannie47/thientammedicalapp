class UserLogin {
  final String taiKhoan;
  final String matKhau;
  final bool rememberMe;

  const UserLogin({
    required this.taiKhoan,
    required this.matKhau,
    this.rememberMe = false,
  });

  // Lấy dữ liệu từ JSON (từ API hoặc local storage)
  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      taiKhoan: json['taiKhoan'] as String,
      matKhau: json['matKhau'] as String,
      rememberMe: (json['rememberMe'] as int?) == 1, // tinyint(1)
    );
  }

  // Convert ngược lại để lưu vào server hoặc SharedPreferences
  Map<String, dynamic> toJson() {
    return {
      'maNV': taiKhoan,
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
      taiKhoan: taiKhoang ?? this.taiKhoan,
      matKhau: matKhau ?? this.matKhau,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }

  @override
  String toString() {
    return 'UserLogin(taiKhoan: $taiKhoan, matKhau: $matKhau, rememberMe: $rememberMe)';
  }
}
