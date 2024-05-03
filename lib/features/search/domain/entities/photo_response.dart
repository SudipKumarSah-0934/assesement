import 'package:genius_assesment/features/search/domain/entities/photos.dart';

import 'pagination_meta_data.dart';

class PhotoResponse {
  final List<Photos> photos;
  final PaginationMetaData paginationMetaData;

  PhotoResponse({required this.photos, required this.paginationMetaData});
}
