
class CategoryResponse {
  final bool status;
  final List<Category> data;

  CategoryResponse({
    required this.status,
    required this.data,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => CategoryResponse(
    status: json["status"],
    data: List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
  );
}

class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
  );
}
