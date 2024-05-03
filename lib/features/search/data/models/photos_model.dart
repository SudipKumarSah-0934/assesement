
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genius_assesment/features/search/domain/entities/photos.dart';

part 'photos_model.freezed.dart';
part 'photos_model.g.dart';

@freezed
class PhotosModel extends Photos with _$PhotosModel {
  const factory PhotosModel({
  required int id,
  required String pageURL,
  required String type,
  required String tags,
  required String previewURL,
  required int previewWidth,
  required int previewHeight,
  required String webformatURL,
  required int webformatWidth,
  required int webformatHeight,
  required String largeImageURL,
  required int imageWidth,
  required int imageHeight,
  required int imageSize,
  required int views,
  required int downloads,
  required int collections,
  required int likes,
  required int comments,
  required int user_id,
  required String user,
  required String userImageURL,
  }) = _PhotosModel;

  factory PhotosModel.fromJson(Map<String, dynamic> json) =>
      _$PhotosModelFromJson(json);
      factory PhotosModel.fromEntity(Photos photo) => PhotosModel(
        id: photo.id,
        pageURL: photo.pageURL,
        type: photo.type,
        tags: photo.tags,
        previewURL: photo.previewURL,
        previewWidth: photo.previewWidth,
        previewHeight: photo.previewHeight,
        webformatURL: photo.webformatURL,
        webformatWidth: photo.webformatWidth,
        webformatHeight: photo.webformatHeight,
        largeImageURL: photo.largeImageURL,
        imageWidth: photo.imageWidth,
        imageHeight: photo.imageHeight,
        imageSize: photo.imageSize,
        views: photo.views,
        downloads: photo.downloads,
        collections: photo.collections,
        likes: photo.likes,
        comments: photo.comments,
        user_id: photo.user_id,
        user: photo.user,
        userImageURL: photo.userImageURL,
      );
}
