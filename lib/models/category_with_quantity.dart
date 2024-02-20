
class CategoryWithQuantity {
  final bool status;
  final List<Datum> data;

  CategoryWithQuantity({
    required this.status,
    required this.data,
  });

  factory CategoryWithQuantity.fromJson(Map<String, dynamic> json) => CategoryWithQuantity(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

}

class Datum {
  final int? id;
  final String? name;
  final String? icon;
  final String? source;
  final int? total;
  final List<Children>? children;

  Datum({
    required this.id,
    required this.name,
    required this.icon,
    required this.source,
    required this.total,
    required this.children,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    icon: json["icon"] ?? '',
    source: json["source"] ?? '',
    total: json["total"] ?? 0,
    children: List<Children>.from(json["childrens"].map((x) => Children.fromJson(x))),
  );
}

class Children {
  final int? id;
  final String? name;
  final int? total;
  final List<Child>? children;

  Children({
    required this.id,
    required this.name,
    required this.total,
    required this.children,
  });

  factory Children.fromJson(Map<String, dynamic> json) => Children(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    total: json["total"] ?? 0,
    children: List<Child>.from(json["childrens"].map((x) => Child.fromJson(x))),
  );
}

class Child {
  final int? id;
  final String? name;
  final int? total;

  Child({
    required this.id,
    required this.name,
    required this.total,
  });

  factory Child.fromJson(Map<String, dynamic> json) => Child(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    total: json["total"] ?? 0,
  );
}

