// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../models/filtered_response.dart';

import '../../core/api_service.dart';
import '../../models/lang_response.dart';
import '../../models/type_response.dart';
import '../../models/level_response.dart';
import '../../models/category_response.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final ApiService _api;
  int totalPage = 0;
  bool newFilter = false;

  MainBloc({required ApiService api})
      : _api = api,
        super(const MainState()) {
    on<MainEvent>((event, emit) async {
      switch (event) {
        case Filter():
          await _onFilter(event, emit);
        case Start():
          await _onStart(event, emit);
      }
    });
  }

  Future<void> _onFilter(Filter event, Emitter emit) async {
    newFilter = true;
    final List<MaterialBook> list = [];
    if (state.status == EnumStatus.loading) return;
    emit(state.copyWith(status: EnumStatus.loading));
    final queries = {
      "category_id": event.category_id,
      "search_by_name": event.search_by_name,
      "search_by_desc": event.search_by_desc,
      "type_id": event.type_id,
      "level_id": event.level_id,
      "language_id": event.language_id,
      "page": event.page,
    };
    if (queries['category_id'] == null) {
      queries.remove('category_id');
    }
    if (queries['page'] == null) {
      queries.remove('page');
    }
    if (queries['type_id'] == null) {
      queries.remove('type_id');
    }
    if (queries['level_id'] == null) {
      queries.remove('level_id');
    }
    if (queries['language_id'] == null) {
      queries.remove('language_id');
    }
    if (event.newFilter) {
      try {
        final response = await _api.filter(queries);
        list.clear();
        list.addAll(response.materials as List<MaterialBook>);
        emit(state.copyWith(materials: list, status: EnumStatus.success));
        totalPage = response.pagination!.lastPage!;
      } catch (e) {
        emit(state.copyWith(status: EnumStatus.fail, message: e.toString()));
      }
    } else {
      try {
        final response = await _api.filter(queries);
        list.addAll(state.materials);
        list.addAll(response.materials as List<MaterialBook>);
        emit(state.copyWith(materials: list, status: EnumStatus.success));
        totalPage = response.pagination!.lastPage!;
      } catch (e) {
        emit(state.copyWith(status: EnumStatus.fail, message: e.toString()));
      }
    }
  }

  Future<void> _onStart(Start event, Emitter emit) async {
    final List<MaterialBook> list = [];
    if (state.status == EnumStatus.loading) return;
    emit(state.copyWith(status: EnumStatus.loading));
    final queries = {
      "category_id": null,
      "search_by_name": null,
      "search_by_desc": null,
      "type_id": null,
      "level_id": null,
      "language_id": null,
      "page": event.page,
    };
    if (queries['category_id'] == null) {
      queries.remove('category_id');
    }
    if (queries['page'] == null) {
      queries.remove('page');
    }
    if (queries['type_id'] == null) {
      queries.remove('type_id');
    }
    if (queries['level_id'] == null) {
      queries.remove('level_id');
    }
    if (queries['language_id'] == null) {
      queries.remove('language_id');
    }
    try {
      final response = await _api.filter(queries);
      list.addAll(state.materials);
      list.addAll(response.materials as List<MaterialBook>);
      emit(
        state.copyWith(
          status: EnumStatus.success,
          materials: list,
          languages: (await _api.getAllLanguages()).data,
          levels: (await _api.getAllLevels()).data,
          types: (await _api.getAllTypes()).data,
          categories: (await _api.getAllCategories()).data,
        ),
      );
      totalPage = response.pagination!.lastPage!;
    } catch (e) {
      emit(state.copyWith(status: EnumStatus.fail, message: e.toString()));
    }
  }
}
