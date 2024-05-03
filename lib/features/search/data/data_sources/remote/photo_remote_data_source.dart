import 'package:genius_assesment/core/constant/api.dart';
import 'package:genius_assesment/core/error/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:genius_assesment/features/search/data/models/filter_params_model.dart';
import 'package:genius_assesment/features/search/data/models/photo_response_model.dart';

abstract class PhotoRemoteDataSource {
  Future<PhotoResponseModel> getPhotos(FilterPhotoParams params);
}

class PhotoRemoteDataSourceImpl implements PhotoRemoteDataSource {
  const PhotoRemoteDataSourceImpl({
    required this.client,
  });
  final http.Client client;

  @override
  Future<PhotoResponseModel> getPhotos(params) => _getPhotoFromUrl(
      '$baseUrl?key=$defaultApiKey&category=${params.keyword}&page=${params.pageSize}&per_page=20)}');

  Future<PhotoResponseModel> _getPhotoFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return photoResponseModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
