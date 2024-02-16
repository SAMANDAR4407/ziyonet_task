part of 'detail_bloc.dart';

@immutable
class DetailState {
  final EnumStatus status;
  final String message;
  final List<Book> books;

  const DetailState({this.message = '', this.status = EnumStatus.initial, this.books = const[]});

  DetailState copyWith({
    EnumStatus? status,
    String? message,
    List<Book>? books
  }){
    return DetailState(
      status: status ?? this.status,
      message: message ?? this.message,
      books: books ?? this.books
    );
  }
}
