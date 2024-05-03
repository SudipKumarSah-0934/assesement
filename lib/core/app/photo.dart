// Feature: Photo

import 'package:genius_assesment/features/search/data/data_sources/local/photo_local_data_source.dart';
import 'package:genius_assesment/features/search/data/data_sources/remote/photo_remote_data_source.dart';
import 'package:genius_assesment/features/search/data/respositories/photo_repository_impl.dart';
import 'package:genius_assesment/features/search/domain/respositories/photo_repository.dart';
import 'package:genius_assesment/features/search/domain/usecases/get_photo_usecase.dart';
import 'package:genius_assesment/features/search/presentation/bloc/photo_bloc.dart';

import 'di.dart';

void registerPhotoFeature() {
  // Photo BLoC and Use Cases
  sl.registerFactory(() => PhotoBloc(sl()));
  sl.registerLazySingleton(() => GetPhotoUseCase(sl()));

  // Photo Repository and Data Sources
  sl.registerLazySingleton<PhotoRepository>(
    () => PhotoRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<PhotoRemoteDataSource>(
    () => PhotoRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<PhotoLocalDataSource>(
    () => PhotoLocalDataSourceImpl(sharedPreferences: sl()),
  );
}
