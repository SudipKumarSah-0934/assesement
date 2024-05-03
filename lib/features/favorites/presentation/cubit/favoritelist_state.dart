part of 'favoritelist_cubit.dart';

abstract class FavoritelistState extends Equatable {
  const FavoritelistState();

  @override
  List<Object> get props => [];
}

class FavoritelistInitialState extends FavoritelistState {}

class FavoritelistLoadedState extends FavoritelistState {
  final List<PhotosModel> favoritelist;

  const FavoritelistLoadedState(this.favoritelist);

  @override
  List<Object> get props => [favoritelist];
}
