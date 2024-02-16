import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ziyonet_task/bloc/detail/detail_bloc.dart';
import 'package:ziyonet_task/core/api_service.dart';
import 'package:ziyonet_task/pages/main_page.dart';

import 'bloc/main/main_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    dio.interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true)
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainBloc(api: ApiService(dio, baseUrl: 'https://api.ziyonet.uz/api/mobile/ru'))),
        BlocProvider(create: (context) => DetailBloc(api: ApiService(dio, baseUrl: 'https://api.ziyonet.uz/api/mobile/ru'))),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ZiyoNET task',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MainPage(),
      ),
    );
  }
}
