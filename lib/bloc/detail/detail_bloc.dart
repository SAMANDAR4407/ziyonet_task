import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ziyonet_task/bloc/main/main_bloc.dart';

import '../../core/api_service.dart';
import '../../models/book_detail_response.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  ApiService api;

  DetailBloc({required this.api}) : super(const DetailState()) {
    on<DetailEvent>((event, emit) async {
      switch(event){
        case GetDetails():
        await onGetDetails(event, emit);
      }
    });
  }

  Future<void> onGetDetails(GetDetails event, Emitter emit) async {
    if(state.status == EnumStatus.loading) return;
    emit(state.copyWith(status: EnumStatus.loading));
    final queries = {
      "book_id" : event.book_id
    };
    final response = await api.getBookDetail(queries);
    try{
      emit(state.copyWith(status: EnumStatus.success, books: List.of([response.data])));
    }catch(e){
      emit(state.copyWith(status: EnumStatus.fail, message: e.toString()));
    }
  }
}
