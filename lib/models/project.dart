class Project {
  Project({
    this.address = '',
    this.name = '',
    this.description = '',
    this.imgUrl = '',
    this.github = '',
    this.category = '',
  }) {
    team = {'0xa9F8F9C0bf3188cEDdb9684ae28655187552bAE9': 100};
    shareholders = {'0xa9F8F9C0bf3188cEDdb9684ae28655187552bAE9': 5};
    investors = {};
    split = 5.0;
  }

  late String address;
  late Map<String, double> team;
  late Map<String, double> shareholders;
  late Map<String, double> investors;
  late double split;
  late String name;
  late String description;
  late String imgUrl;
  late String github;
  late String category;
}
