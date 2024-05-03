import 'package:genius_assesment/features/search/domain/entities/category/category.dart';

class FilterPhotoParams {
  final String? keyword;
  final List<Category> categories;

  final int? limit;
  final int? pageSize;

  const FilterPhotoParams({
    this.keyword = '',
    this.categories = const [],
    this.limit = 0,
    this.pageSize = 10,
  });

  FilterPhotoParams copyWith({
    int? skip,
    String? keyword,
    List<Category>? categories,
    int? limit,
    int? pageSize,
  }) =>
      FilterPhotoParams(
        keyword: keyword ?? this.keyword,
        categories: categories ?? this.categories,
        limit: skip ?? this.limit,
        pageSize: pageSize ?? this.pageSize,
      );
}
