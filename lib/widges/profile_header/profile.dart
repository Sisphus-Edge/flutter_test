class Profile {
  late String firstName;
  late String lastName;
  late String location;
  late int numberOfFollowers;
  late int numberFollowing;
  late int totalLikes;

  String get fullName => "$firstName $lastName";

  String get numberOfFollowersString => _abbreviatedCount(numberOfFollowers);

  String get numberFollowingString => _abbreviatedCount(numberFollowing);

  String get totalLikesString => _abbreviatedCount(totalLikes);

  String _abbreviatedCount(int num) {
    if (num < 1000) return "$num";
    if (num >= 1000 && num < 1000000) {
      String s = (num / 1000).toStringAsFixed(1);
      if (s.endsWith(".0")) {
        int idx = s.indexOf(".0");
        s = s.substring(0, idx);
      }
      return "${s}K";
    } else if (num >= 1000000 && num < 1000000000) {
      String s = (num / 1000000).toStringAsFixed(1);
      if (s.endsWith(".0")) {
        int idx = s.indexOf(".0");
        s = s.substring(0, idx);
      }
      return "${s}M";
    }
    return "";
  }
}


Profile getProfile() {
  return Profile()
    ..firstName = "Emma"
    ..lastName = "Watson"
    ..location = "New York"
    ..numberOfFollowers = 5700000
    ..numberFollowing = 924
    ..totalLikes = 1700;
}
