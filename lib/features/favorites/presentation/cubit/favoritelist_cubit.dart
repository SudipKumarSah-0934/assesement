import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genius_assesment/features/search/data/models/photos_model.dart';
import 'package:get_storage/get_storage.dart';

part 'favoritelist_state.dart';

class FavoritelistCubit extends Cubit<FavoritelistState> {
  FavoritelistCubit() : super(FavoritelistInitialState());
  Future<void> loadFavoritelist() async {
    final box = GetStorage();
    final List<dynamic>? favoritelistData = box.read<List<dynamic>>('favoritelist');

    if (favoritelistData == null) {
      emit(const FavoritelistLoadedState([]));
      return;
    }

    final List<PhotosModel> favoritelist = favoritelistData
        .map((jsonMap) => PhotosModel.fromJson(jsonMap))
        .toList();

    // Check if the loaded favoritelist is different from the current one
    if (!listEquals<PhotosModel>(favoritelist, favoritelist)) {
      emit(FavoritelistLoadedState(favoritelist));
    }
  }


  Future<void> addToFavoritelist(PhotosModel product) async {
    final box = GetStorage();
    final List<dynamic>? favoritelistData =
    box.read<List<dynamic>>('favoritelist');

    final List<Map<String, dynamic>> updatedFavoritelist =
    List<Map<String, dynamic>>.from(favoritelistData ?? []);

    // Check if the user_id already exists in the list
    if (isInFavoritelist(product.user_id)) {
      return; // Exit the method if user_id already exists
    }

    updatedFavoritelist.add(product.toJson());

    box.write('favoritelist', updatedFavoritelist);

    if (state is FavoritelistLoadedState) {
      final List<PhotosModel> currentFavoritelist =
          (state as FavoritelistLoadedState).favoritelist;
      emit(FavoritelistLoadedState([...currentFavoritelist, product]));
    }
  }


  Future<void> removeFromFavoritelist(PhotosModel product) async {
    final box = GetStorage();
    final List<dynamic>? favoritelistData =
        box.read<List<dynamic>>('favoritelist');

    final List<Map<String, dynamic>> updatedFavoritelist =
        List<Map<String, dynamic>>.from(favoritelistData ?? []);

    updatedFavoritelist.removeWhere((item) => item['_id'] == product.id);

    box.write('favoritelist', updatedFavoritelist);

    if (state is FavoritelistLoadedState) {
      final List<PhotosModel> currentFavoritelist =
          (state as FavoritelistLoadedState).favoritelist;
      final List<PhotosModel> updatedFavoritelist =
          currentFavoritelist.where((item) => item.id != product.id).toList();
      print('ok ok${updatedFavoritelist.map((e) => e.user)}');
      emit(FavoritelistLoadedState(updatedFavoritelist));
    }
  }

  Future<void> clearFavoritelist() async {
    final box = GetStorage();
    await box.remove('favoritelist');
    emit(const FavoritelistLoadedState([]));
  }
  bool isInFavoritelist(int userID) {
    final box = GetStorage();
    final List<dynamic>? favoritelistData = box.read<List<dynamic>>('favoritelist');

    if (favoritelistData == null) {
      return false;
    }

    final List<Map<String, dynamic>> mapFavoritelistData =
    favoritelistData.whereType<Map<String, dynamic>>().toList();

    final List<String> stringFavoritelistIds =
    mapFavoritelistData.map((map) => map['user_id'].toString()).toList();

    final String stringUserID = userID.toString();


    return stringFavoritelistIds.contains(stringUserID);
  }

}
