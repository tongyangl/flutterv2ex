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
      : avatar_large = "https:"+jsonMap['avatar_large'],
        name = jsonMap['name'],
        title = jsonMap['title'],
        avatar_normal = "https:"+jsonMap['avatar_normal'],
        avatar_mini = "https:"+jsonMap['avatar_mini'],
        url = jsonMap['url'],
        stars = jsonMap['stars'],
        topics = jsonMap['topics'];
}
