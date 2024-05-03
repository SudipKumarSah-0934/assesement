import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genius_assesment/features/favorites/presentation/cubit/favoritelist_cubit.dart';
import 'package:genius_assesment/features/search/presentation/bloc/filter_cubit/filter_cubit.dart';
import 'package:genius_assesment/features/search/data/models/filter_params_model.dart';
import 'package:genius_assesment/features/search/presentation/bloc/photo_bloc.dart';

import './di.dart' as di;
import '../router/app_router.dart';
import '../constant/colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<FavoritelistCubit>()..loadFavoritelist(),
        ),
        BlocProvider(
          create: (context) =>
              di.sl<PhotoBloc>()..add(const GetPhotos(FilterPhotoParams())),
        ),
        BlocProvider(
          create: (context) => di.sl<FilterCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Genius App",
        onGenerateRoute: AppRouter.onGenerateRoute,
        theme: ThemeData.light().copyWith(
          canvasColor: AppColors.CommonCyan,
          appBarTheme: AppBarTheme(
              color: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              toolbarHeight: 56,
              centerTitle: true,
              iconTheme:
                  const IconThemeData(color: AppColors.CommonCyan, size: 30)),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.CommonCyan,
              minimumSize: const Size(170, 50),
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          )),
          iconTheme: const IconThemeData(color: AppColors.CommonCyan, size: 30),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: AppColors.CommonCyan,
          ),
        ),
        initialRoute: AppRouter.search,
      ),
    );
  }
}
