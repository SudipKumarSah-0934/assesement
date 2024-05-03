import 'package:dartz/dartz.dart';
import 'package:genius_assesment/core/error/exceptions.dart';
import 'package:genius_assesment/core/error/failures.dart';
import 'package:genius_assesment/core/networkchecker/network_info.dart';
import 'package:genius_assesment/features/search/data/data_sources/local/photo_local_data_source.dart';
import 'package:genius_assesment/features/search/data/data_sources/remote/photo_remote_data_source.dart';
import 'package:genius_assesment/features/search/domain/respositories/photo_repository.dart';
import 'package:genius_assesment/features/search/data/models/filter_params_model.dart';
import 'package:genius_assesment/features/search/domain/entities/photo_response.dart';

typedef _ConcreteOrPhotoChooser = Future<PhotoResponse> Function();

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final PhotoLocalDataSource localDataSource;

  PhotoRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PhotoResponse>> getPhotos(
      FilterPhotoParams params) async {
    return await _getPhoto(() {
      return remoteDataSource.getPhotos(params);
    });
  }

  Future<Either<Failure, PhotoResponse>> _getPhoto(
    _ConcreteOrPhotoChooser getConcreteOrPhotos,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePhotos = await getConcreteOrPhotos();
        return Right(remotePhotos);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPhotos = await localDataSource.getLastPhotos();
        return Right(localPhotos);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
