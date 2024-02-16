part of 'detail_bloc.dart';

@immutable
abstract class DetailEvent {}

class GetDetails extends DetailEvent{
  final int book_id;

  GetDetails(this.book_id);
}
