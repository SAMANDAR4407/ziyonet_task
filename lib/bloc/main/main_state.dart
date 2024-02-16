part of 'main_bloc.dart';

@immutable
class MainState {
  final List<MaterialBook> materials;
  final List<Lang> languages;
  final List<Type> types;
  final List<Level> levels;
  final List<Category> categories;
  final EnumStatus status;
  final String message;

  const MainState({
    this.materials = const [],
    this.languages = const [],
    this.levels = const [],
    this.types = const [],
    this.categories = const [],
    this.status = EnumStatus.initial,
    this.message = '',
  });

  MainState copyWith({
    List<MaterialBook>? materials,
    List<Lang>? languages,
    List<Type>? types,
    List<Level>? levels,
    List<Category>? categories,
    EnumStatus? status,
    String? message,
  }) =>
      MainState(
        materials: materials ?? this.materials,
        languages: languages ?? this.languages,
        levels: levels ?? this.levels,
        types: types ?? this.types,
        categories: categories ?? this.categories,
        status: status ?? this.status,
        message: message ?? this.message,
      );
}

enum EnumStatus { initial, loading, success, fail }
