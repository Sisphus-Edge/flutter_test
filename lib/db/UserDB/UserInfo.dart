class UserInfo {
  final int id;
  final String email;
  final String name;
  final String avatar;
  final String address;

  UserInfo({
    required this.id,
    required this.email,
    required this.name,
    required this.avatar,
    required this.address,
  });

  @override
  String toString() {
    return 'UserInfo(id: $id, email: $email, name: $name, avatar: $avatar, address: $address)';
  }
}
