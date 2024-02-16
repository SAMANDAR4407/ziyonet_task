
class FilteredResponse {
  final bool? status;
  final List<MaterialBook>? materials;
  final Pagination? pagination;

  FilteredResponse({
    required this.status,
    required this.materials,
    required this.pagination,
  });

  factory FilteredResponse.fromJson(Map<String, dynamic> json) => FilteredResponse(
    status: json["status"] ?? false,
    materials: List<MaterialBook>.from(json["data"].map((x) => MaterialBook.fromJson(x))),
    pagination: Pagination.fromJson(json["pagination"]),
  );

}

class MaterialBook {
  final int? id;
  final String? title;
  final String? type;
  final String? level;
  final String? author;
  final String? publishedAt;
  final String? udk;
  final String? file;
  final String? cover;
  final Grades? grades;
  final int? rating;
  final String? createdAt;

  MaterialBook({
    required this.id,
    required this.title,
    required this.type,
    required this.level,
    required this.author,
    required this.publishedAt,
    required this.udk,
    required this.file,
    required this.cover,
    required this.grades,
    required this.rating,
    required this.createdAt,
  });

  factory MaterialBook.fromJson(Map<String, dynamic> json) => MaterialBook(
    id: json["id"] ?? 0,
    title: json["title"] ?? '',
    type: json["type"] ?? '',
    level: json["level"] ?? '',
    author: json["author"] ?? '',
    publishedAt: json["published_at"] ?? '',
    udk: json["udk"] ?? '',
    file: json["file"] ?? '',
    cover: json["cover"] ?? '',
    grades: Grades.fromJson(json["grades"]),
    rating: json["rating"] ?? 0,
    createdAt: json["created_at"] ?? '',
  );

}

class Grades {
  final bool? like;
  final bool? dislike;

  Grades({
    required this.like,
    required this.dislike,
  });

  factory Grades.fromJson(Map<String, dynamic> json) => Grades(
    like: json["like"] ?? false,
    dislike: json["dislike"] ?? false,
  );

}

class Pagination {
  final int? perPage;
  final int? page;
  final int? lastPage;
  final int? total;

  Pagination({
    required this.perPage,
    required this.page,
    required this.lastPage,
    required this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    perPage: json["perPage"] ?? 0,
    page: json["page"] ?? 0,
    lastPage: json["lastPage"] ?? 0,
    total: json["total"] ?? 0,
  );

}
