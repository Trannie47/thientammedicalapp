class NhanVien {
  final int maNV;
  final String tenNhanVien;
  final String ngaySinh;      // bạn đang lưu String (dd/MM/yyyy hay yyyy-MM-dd)
  final String ngayVaoLam;    // tương tự
  final String matKhau;
  final String sdt;
  final int phongBan;
  final bool isDelete;        // tinyint(1) → bool trong Dart

  const NhanVien({
    required this.maNV,
    required this.tenNhanVien,
    required this.ngaySinh,
    required this.ngayVaoLam,
    required this.matKhau,
    required this.sdt,
    required this.phongBan,
    this.isDelete = false, // mặc định chưa xóa
  });

  // Dùng khi lấy dữ liệu từ API (json)
  factory NhanVien.fromJson(Map<String, dynamic> json) {
    return NhanVien(
      maNV: json['maNV'] as int,
      tenNhanVien: json['tenNhanVien'] as String,
      ngaySinh: json['ngaySinh'] as String,
      ngayVaoLam: json['ngayVaoLam'] as String,
      matKhau: json['matKhau'] as String,
      sdt: json['SDT'] as String,
      phongBan: json['PhongBan'] as int,
      isDelete: (json['isDelete'] as int) == 1,
    );
  }

  // Dùng khi gửi dữ liệu lên server
  Map<String, dynamic> toJson() {
    return {
      'maNV': maNV,
      'tenNhanVien': tenNhanVien,
      'ngaySinh': ngaySinh,
      'ngayVaoLam': ngayVaoLam,
      'matKhau': matKhau,
      'SDT': sdt,
      'PhongBan': phongBan,
      'isDelete': isDelete ? 1 : 0,
    };
  }

  // Dùng khi muốn sửa 1-2 trường mà giữ nguyên các trường khác
  NhanVien copyWith({
    int? maNV,
    String? tenNhanVien,
    String? ngaySinh,
    String? ngayVaoLam,
    String? matKhau,
    String? sdt,
    int? phongBan,
    bool? isDelete,
  }) {
    return NhanVien(
      maNV: maNV ?? this.maNV,
      tenNhanVien: tenNhanVien ?? this.tenNhanVien,
      ngaySinh: ngaySinh ?? this.ngaySinh,
      ngayVaoLam: ngayVaoLam ?? this.ngayVaoLam,
      matKhau: matKhau ?? this.matKhau,
      sdt: sdt ?? this.sdt,
      phongBan: phongBan ?? this.phongBan,
      isDelete: isDelete ?? this.isDelete,
    );
  }

  @override
  String toString() {
    return 'NguoiDung(maNV: $maNV, tenNhanVien: $tenNhanVien, sdt: $sdt)';
  }
}