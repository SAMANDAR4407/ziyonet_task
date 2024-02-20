part of 'detail_bloc.dart';

@immutable
class DetailState {
  final EnumStatus status;
  final String message;
  final List<Book> books;
  final List<Datum> data;

  const DetailState({
    this.message = '',
    this.status = EnumStatus.initial,
    this.books = const [],
    this.data = const [],
  });

  DetailState copyWith({
    EnumStatus? status,
    String? message,
    List<Book>? books,
    List<Datum>? data,
  }) {
    return DetailState(
      status: status ?? this.status,
      message: message ?? this.message,
      books: books ?? this.books,
      data: data ?? this.data,
    );
  }
}
