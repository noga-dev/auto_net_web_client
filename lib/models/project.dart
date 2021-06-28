class Project {
  Project({
    required this.address,
    required this.name,
    required this.description,
    required this.imgUrl,
    required this.github,
    required this.category,
    required this.mature,
    this.investors = const {},
    this.shareholders = const {},
    this.team = const {},
    this.split = 5.0,
  });
  String? address;
  Map<String, double> team;
  Map<String, double> shareholders;
  Map<String, double> investors;
  bool mature;
  double split;
  String? name;
  String? description;
  String? imgUrl;
  String? github;
  String? category;
}
