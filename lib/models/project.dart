class Project {
  Project({
    required this.address,
    required this.name,
    required this.description,
    required this.imgUrl,
    required this.github,
    required this.category,
    required this.mature,
  }) {
    team = {'0xa9F8F9C0bf3188cEDdb9684ae28655187552bAE9': 100};
    shareholders = {'0xa9F8F9C0bf3188cEDdb9684ae28655187552bAE9': 5};
    investors = {};
    split = 5.0;
  }

  String? address;
  late Map<String, double> team;
  late Map<String, double> shareholders;
  late Map<String, double> investors;
  late double split;
  String? name;
  String? description;
  late bool mature;
  String? imgUrl;
  String? github;
  String? category;
}
