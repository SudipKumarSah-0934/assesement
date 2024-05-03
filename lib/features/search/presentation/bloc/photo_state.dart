part of 'photo_bloc.dart';

abstract class PhotoState extends Equatable {
  final List<Photos> photos;
  final PaginationMetaData metaData;
  final FilterPhotoParams params;
  const PhotoState(
      {required this.photos, required this.metaData, required this.params});
}

class PhotoInitial extends PhotoState {
  const PhotoInitial({
    required super.photos,
    required super.metaData,
    required super.params,
  });
  @override
  List<Object> get props => [];
}

class PhotoEmpty extends PhotoState {
  const PhotoEmpty({
    required super.photos,
    required super.metaData,
    required super.params,
  });
  @override
  List<Object> get props => [];
}

class PhotoLoading extends PhotoState {
  const PhotoLoading({
    required super.photos,
    required super.metaData,
    required super.params,
  });
  @override
  List<Object> get props => [];
}

class PhotoLoaded extends PhotoState {
  const PhotoLoaded({
    required super.photos,
    required super.metaData,
    required super.params,
  });
  @override
  List<Object> get props => [photos];
}

class PhotoError extends PhotoState {
  final Failure failure;
  const PhotoError({
    required super.photos,
    required super.metaData,
    required super.params,
    required this.failure,
  });
  @override
  List<Object> get props => [];
}
