class Contributor {
  final String avatarUrl;
  final String name;
  final String login;
  final String bio;
  final String websiteUrl;
  final String location;

  Contributor({
    this.avatarUrl,
    this.name,
    this.login,
    this.bio,
    this.websiteUrl,
    this.location
  });


  factory Contributor.map(Map<String, dynamic> obj) {
    if (obj == null) {
      return Contributor();
    }
    return Contributor(
        avatarUrl: obj["avatarUrl"],
        name: obj["name"],
        login: obj["login"],
        bio: obj["bio"],
        websiteUrl: obj["websiteUrl"],
        location: obj["location"]
    );
  }


  static Contributor fromMap(Map<String, dynamic> obj) => Contributor.map(obj);
  static List<Contributor> fromList(List<dynamic> obj) {
    if (obj == null) {
      return [];
    }
    return obj
        .cast<Map<String, dynamic>>()
        .map(Contributor.fromMap)
        .toList();
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map["avatarUrl"] = avatarUrl;
    map["name"] = name;
    map["login"] = location;
    map["bio"] = bio;
    map["websiteUrl"] = websiteUrl;
    map["location"] = location;
    return map;
  }
}
