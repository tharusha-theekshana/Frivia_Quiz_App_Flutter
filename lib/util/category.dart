class Category{
  String name;
  int value;

  Category({required this.name, required this.value});

  factory Category.fromJson(Map<dynamic, dynamic> json) => Category(
    name: json["name"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "value": value,
  };
}