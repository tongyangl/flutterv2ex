class NodesItemData {
  String avatar_large;
  String name;
  String title;
  String avatar_normal;
  String avatar_mini;
  String url;
  int stars;
  int topics;

  NodesItemData.formJson(Map<String, dynamic> jsonMap)
      : avatar_large = jsonMap['avatar_large'],
        name = jsonMap['name'],
        title = jsonMap['title'],
        avatar_normal = jsonMap['avatar_normal'],
        avatar_mini = jsonMap['avatar_mini'],
        url = jsonMap['url'],
        stars = jsonMap['stars'],
        topics = jsonMap['topics'];
}
