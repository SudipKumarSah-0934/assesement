import 'dart:convert';

import 'package:genius_assesment/features/search/data/models/photos_model.dart';
import 'package:genius_assesment/features/search/domain/entities/photos.dart';
import 'package:genius_assesment/features/search/data/models/pagination_data_model.dart';
import 'package:genius_assesment/features/search/domain/entities/pagination_meta_data.dart';
import 'package:genius_assesment/features/search/domain/entities/photo_response.dart';

PhotoResponseModel photoResponseModelFromJson(String str) =>
    PhotoResponseModel.fromJson(json.decode(str));

String photoResponseModelToJson(PhotoResponseModel data) =>
    json.encode(data.toJson());

class PhotoResponseModel extends PhotoResponse {
  PhotoResponseModel({
    required PaginationMetaData meta,
    required List<Photos> data,
  }) : super(photos: data, paginationMetaData: meta);

  factory PhotoResponseModel.fromJson(Map<String, dynamic> json) =>
      PhotoResponseModel(
        meta: PaginationMetaDataModel.fromJson(json),
        data: List<PhotosModel>.from(
            json["hits"].map((x) => PhotosModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": (paginationMetaData as PaginationMetaDataModel).toJson(),
        "data": List<dynamic>.from(
            (photos as List<PhotosModel>).map((x) => x.toJson())),
      };
}
