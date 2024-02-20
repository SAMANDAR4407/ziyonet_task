part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class Start extends MainEvent {
  final int? page;

  Start({required this.page});
}

class Filter extends MainEvent {
  final int? category_id;
  final String? search_by_name;
  final String? search_by_desc;
  final int? type_id;
  final int? level_id;
  final int? language_id;
  final int? page;
  bool newFilter;

  Filter({
    required this.category_id,
    required this.search_by_name,
    required this.search_by_desc,
    required this.type_id,
    required this.level_id,
    required this.language_id,
    required this.page,
    required this.newFilter
  });
}
