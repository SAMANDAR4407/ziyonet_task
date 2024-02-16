
class LangResponse {
  final bool status;
  final List<Lang> data;

  LangResponse({
    required this.status,
    required this.data,
  });

  factory LangResponse.fromJson(Map<String, dynamic> json) => LangResponse(
    status: json["status"],
    data: List<Lang>.from(json["data"].map((x) => Lang.fromJson(x))),
  );

}

class Lang {
  final int id;
  final String name;

  Lang({
    required this.id,
    required this.name,
  });

  factory Lang.fromJson(Map<String, dynamic> json) => Lang(
    id: json["id"],
    name: json["name"],
  );

}
