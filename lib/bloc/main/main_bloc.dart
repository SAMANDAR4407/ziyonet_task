import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ziyonet_task/models/filtered_response.dart';

import '../../core/api_service.dart';
import '../../models/lang_response.dart';
import '../../models/type_response.dart';
import '../../models/level_response.dart';
import '../../models/category_response.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  ApiService api;
  int totalPage = 0;

  MainBloc({required this.api}) : super(const MainState()) {
    on<MainEvent>((event, emit) async {
      switch(event){
        case Filter():
          await _onFilter(event, emit);
        case LoadInfo():
          await _onLoadInfo(event, emit);
      }
    });
  }

  Future<void> _onFilter(Filter event, Emitter emit) async {
    final List<MaterialBook> list = [];
    if(state.status == EnumStatus.loading) return;
    emit(state.copyWith(status: EnumStatus.loading));
    final queries = {
      "category_id" : event.category_id,
      "search_by_name" : event.search_by_name,
      "search_by_desc" : event.search_by_desc,
      "type_id" : event.type_id,
      "level_id" : event.level_id,
      "language_id" : event.language_id,
      "page" : event.page,
    };
    if(queries['category_id'] == null) {
      queries.remove('category_id');
    }
    if(queries['page'] == null) {
      queries.remove('page');
    }
    if(queries['type_id'] == null) {
      queries.remove('type_id');
    }
    if(queries['level_id'] == null) {
      queries.remove('level_id');
    }
    if(queries['language_id'] == null) {
      queries.remove('language_id');
    }
    if(event.newFilter){
      try{
        final response = await api.filter(queries);
        list.clear();
        list.addAll(response.materials as List<MaterialBook>);
        emit(state.copyWith(materials: list, status: EnumStatus.success));
        totalPage = response.pagination!.lastPage!;
      }catch(e){
        emit(state.copyWith(status: EnumStatus.fail, message: e.toString()));
      }
    } else {
      try{
        final response = await api.filter(queries);
        list.addAll(state.materials);
        list.addAll(response.materials as List<MaterialBook>);
        emit(state.copyWith(materials: list, status: EnumStatus.success));
        totalPage = response.pagination!.lastPage!;
      }catch(e){
        emit(state.copyWith(status: EnumStatus.fail, message: e.toString()));
      }
    }
  }

  Future<void> _onLoadInfo(LoadInfo event, Emitter emit) async {
    try{
      emit(state.copyWith(
          languages: (await api.getAllLanguages()).data,
          levels: (await api.getAllLevels()).data,
          types: (await api.getAllTypes()).data,
          categories: (await api.getAllCategories()).data
      ));
    }catch(e){
      emit(state.copyWith(message: e.toString()));
    }
  }
}
