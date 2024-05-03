import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:genius_assesment/features/search/data/models/filter_params_model.dart';

import '../../../domain/entities/category/category.dart';

class FilterCubit extends Cubit<FilterPhotoParams> {
  final TextEditingController photosSearchController = TextEditingController();
  FilterCubit() : super(const FilterPhotoParams());
}
