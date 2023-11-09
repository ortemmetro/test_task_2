import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_like_application/data/data_source/remote/dio/dio_client.dart';
import 'package:tinder_like_application/data/data_source/remote/dio/dio_constants.dart';
import 'package:tinder_like_application/data/data_source/users/users_data_source.dart';
import 'package:tinder_like_application/data/repositories/user_repository.dart';
import 'package:tinder_like_application/presentation/bloc/users_bloc/users_bloc.dart';
import 'package:tinder_like_application/presentation/pages/main_page/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UsersBloc(
            UserRepository(
              userDataSource: UserDataSource(
                DioClient(
                  Dio(
                    BaseOptions(
                      connectTimeout: DioConstants.connectionTimeout,
                      receiveTimeout: DioConstants.receiveTimeout,
                      responseType: ResponseType.json,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Tinder-Like application',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const MainPage(),
      ),
    );
  }
}
