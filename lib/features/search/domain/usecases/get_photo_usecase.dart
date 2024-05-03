import 'package:dartz/dartz.dart';
import 'package:genius_assesment/core/error/failures.dart';
import 'package:genius_assesment/core/usecases/usecase.dart';
import 'package:genius_assesment/features/search/data/models/filter_params_model.dart';
import 'package:genius_assesment/features/search/domain/entities/photo_response.dart';
import '../respositories/photo_repository.dart';

class GetPhotoUseCase implements UseCase<PhotoResponse, FilterPhotoParams> {
  final PhotoRepository repository;
  GetPhotoUseCase(this.repository);

  @override
  Future<Either<Failure, PhotoResponse>> call(FilterPhotoParams params) async {
    return repository.getPhotos(params);
  }
}
