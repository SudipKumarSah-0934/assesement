import 'package:genius_assesment/features/favorites/presentation/cubit/favoritelist_cubit.dart';
import 'package:genius_assesment/features/search/presentation/bloc/filter_cubit/filter_cubit.dart';

import 'di.dart';

void registerCubits() {
  //Filter
  sl.registerFactory(() => FilterCubit());

  //Favoriteslist
  sl.registerFactory(() => FavoritelistCubit());
}
