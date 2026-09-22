import 'package:digitira/core/networking/dio_factory.dart';
import 'package:digitira/feature/auth/cubit/login_cubit.dart';
import 'package:digitira/feature/auth/cubit/register_cubit.dart';
import 'package:digitira/feature/auth/data/repo/repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> setUpGetIt()async{
    getIt.registerLazySingleton<Dio>(()=> DioFactory.getDio());
    getIt.registerLazySingleton<LoginRepo>(()=> LoginRepo(getIt()));
    getIt.registerLazySingleton<RegisterRepo>(()=> RegisterRepo(getIt()));

    getIt.registerFactory<LoginCubit>(()=> LoginCubit(getIt()));
    getIt.registerFactory<RegisterCubit>(()=> RegisterCubit(getIt()));
}