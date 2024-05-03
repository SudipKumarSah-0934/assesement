
import 'package:genius_assesment/features/search/domain/entities/pagination_meta_data.dart';

class PaginationMetaDataModel extends PaginationMetaData {
  PaginationMetaDataModel({
    required int totalHits,
    required int total,
  }): super(
    totalHits: totalHits,
    total: total,
  );

  factory PaginationMetaDataModel.fromJson(Map<String, dynamic> json) => PaginationMetaDataModel(
    totalHits: json["totalHits"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "totalHits": totalHits,
    "total": total,
  };
}