
class TypeResponse {
  final bool status;
  final List<Type> data;

  TypeResponse({
    required this.status,
    required this.data,
  });

  factory TypeResponse.fromJson(Map<String, dynamic> json) => TypeResponse(
    status: json["status"],
    data: List<Type>.from(json["data"].map((x) => Type.fromJson(x))),
  );

}

class Type {
  final int id;
  final String name;

  Type({
    required this.id,
    required this.name,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    id: json["id"],
    name: json["name"],
  );

}
