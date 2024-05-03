part of 'photo_bloc.dart';

abstract class PhotoEvent extends Equatable {
  const PhotoEvent();
}

class GetPhotos extends PhotoEvent {
  final FilterPhotoParams params;
  const GetPhotos(this.params);

  @override
  List<Object> get props => [];
}

class GetMorePhotos extends PhotoEvent {
  const GetMorePhotos();
  @override
  List<Object> get props => [];
}
