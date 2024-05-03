import 'dart:convert';

import 'package:genius_assesment/core/error/exceptions.dart';
import 'package:genius_assesment/features/search/data/models/photo_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PhotoLocalDataSource {
  Future<PhotoResponseModel> getLastPhotos();
  Future<void> savePhotos(PhotoResponseModel photosToCache);
}

const cachedPhotos = 'CACHED_PRODUCTS';

class PhotoLocalDataSourceImpl implements PhotoLocalDataSource {
  final SharedPreferences sharedPreferences;
  PhotoLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<PhotoResponseModel> getLastPhotos() {
    final jsonString = sharedPreferences.getString(cachedPhotos);
    if (jsonString != null) {
      return Future.value(photoResponseModelFromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> savePhotos(PhotoResponseModel photosToCache) {
    return sharedPreferences.setString(
      cachedPhotos,
      json.encode(photoResponseModelToJson(photosToCache)),
    );
  }
}
