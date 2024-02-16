
import 'filtered_response.dart';

class BookDetailResponse {
  final bool status;
  final Book data;

  BookDetailResponse({
    required this.status,
    required this.data,
  });

  factory BookDetailResponse.fromJson(Map<String, dynamic> json) => BookDetailResponse(
        status: json["status"],
        data: Book.fromJson(json["data"]),
      );
}

class Book {
  final int? id;
  final String? title;
  final String? description;
  final List<Category>? category;
  final String? level;
  final String? type;
  final String? publicationType;
  final String? publicationCharacter;
  final String? author;
  final String? issuedAt;
  final String? publishedAt;
  final String? acceptancedAt;
  final int? acceptancedNumber;
  final String? publishment;
  final String? pages;
  final String? udk;
  final String? file;
  final String? cover;
  final Grades? grades;
  final int? rating;
  final int? loaded;
  final String? createdAt;

  Book({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.level,
    required this.type,
    required this.publicationType,
    required this.publicationCharacter,
    required this.author,
    required this.issuedAt,
    required this.publishedAt,
    required this.acceptancedAt,
    required this.acceptancedNumber,
    required this.publishment,
    required this.pages,
    required this.udk,
    required this.file,
    required this.cover,
    required this.grades,
    required this.rating,
    required this.loaded,
    required this.createdAt,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"] ?? 0,
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
        level: json["level"] ?? '',
        type: json["type"] ?? '',
        publicationType: json["publication_type"] ?? '',
        publicationCharacter: json["publication_character"],
        author: json["author"] ?? '',
        issuedAt: json["issued_at"] ?? '',
        publishedAt: json["published_at"] ?? '',
        acceptancedAt: json["acceptanced_at"] ?? '',
        acceptancedNumber: json["acceptanced_number"] ?? 0,
        publishment: json["publishment"] ?? '',
        pages: json["pages"] ?? '',
        udk: json["udk"] ?? '',
        file: json["file"] ?? '',
        cover: json["cover"] ?? '',
        grades: Grades.fromJson(json["grades"]),
        rating: json["rating"] ?? 0,
        loaded: json["loaded"] ?? 0,
        createdAt: json["created_at"] ?? '',
      );
}

class Category {
  final int? id;
  final String? name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
      );

}
