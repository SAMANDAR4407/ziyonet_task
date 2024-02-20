
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:ziyonet_task/models/book_detail_response.dart';
import 'package:ziyonet_task/models/category_response.dart';
import 'package:ziyonet_task/models/category_with_quantity.dart';
import 'package:ziyonet_task/models/lang_response.dart';
import 'package:ziyonet_task/models/level_response.dart';

import '../models/filtered_response.dart';
import '../models/type_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://api.ziyonet.uz/api/mobile/ru')
abstract class ApiService{
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/library')
  Future<FilteredResponse> filter(@Queries() Map<String, dynamic> queries);
  
  @GET('/library/details')
  Future<BookDetailResponse> getBookDetail(@Queries() Map<String, dynamic> queries);

  @GET('/library/categories')
  Future<CategoryResponse> getAllCategories();

  @GET('/library/types')
  Future<TypeResponse> getAllTypes();

  @GET('/library/levels')
  Future<LevelResponse> getAllLevels();

  @GET('/library/languages')
  Future<LangResponse> getAllLanguages();

  @GET('/library/categories-with-quantity')
  Future<CategoryWithQuantity> getCategoriesWithQuantity();
}