import 'package:dartz/dartz.dart';
import 'package:genius_assesment/core/error/failures.dart';
import 'package:genius_assesment/features/search/data/models/filter_params_model.dart';
import '../entities/photo_response.dart';

abstract class PhotoRepository {
  Future<Either<Failure, PhotoResponse>> getPhotos(FilterPhotoParams params);

/*  // Database methods
  Future < List < Photo >> getBookmarks();

  Future < void > saveExercise(Photo exercise);

  Future < void > removeExercise(Photo exercise);*/
}
