class UserProfile {
  final String name;
  final String studentClass;
  final String email;
  final String bio;
  final String avatar;

  UserProfile({
    required this.name,
    required this.studentClass,
    required this.email,
    required this.bio,
    this.avatar = 'default',
  });

  factory UserProfile.defaultProfile() {
    return UserProfile(
      name: 'Raka Pratama',
      studentClass: 'X TJKT 1',
      email: 'raka.pratama@smk.belajar.id',
      bio: 'Siswa Keahlian Teknologi Jaringan Komputer & Telekomunikasi.',
      avatar: 'avatar1',
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'studentClass': studentClass,
        'email': email,
        'bio': bio,
        'avatar': avatar,
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] ?? 'Raka Pratama',
      studentClass: json['studentClass'] ?? 'X TJKT 1',
      email: json['email'] ?? 'raka.pratama@smk.belajar.id',
      bio: json['bio'] ?? 'Siswa TJKT',
      avatar: json['avatar'] ?? 'avatar1',
    );
  }

  UserProfile copyWith({
    String? name,
    String? studentClass,
    String? email,
    String? bio,
    String? avatar,
  }) {
    return UserProfile(
      name: name ?? this.name,
      studentClass: studentClass ?? this.studentClass,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      avatar: avatar ?? this.avatar,
    );
  }
}
