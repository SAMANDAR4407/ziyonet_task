
class LevelResponse {
  final bool status;
  final List<Level> data;

  LevelResponse({
    required this.status,
    required this.data,
  });

  factory LevelResponse.fromJson(Map<String, dynamic> json) => LevelResponse(
    status: json["status"],
    data: List<Level>.from(json["data"].map((x) => Level.fromJson(x))),
  );

}

class Level {
  final int id;
  final String name;

  Level({
    required this.id,
    required this.name,
  });

  factory Level.fromJson(Map<String, dynamic> json) => Level(
    id: json["id"],
    name: json["name"],
  );

}
