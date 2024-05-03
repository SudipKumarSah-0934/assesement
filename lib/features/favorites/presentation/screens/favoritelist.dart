import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_assesment/core/configs/app_typography.dart';
import 'package:genius_assesment/core/constant/colors.dart';
import 'package:genius_assesment/features/favorites/presentation/cubit/favoritelist_cubit.dart';
import 'package:genius_assesment/features/favorites/presentation/widgets/custom_appbar.dart';
import 'package:genius_assesment/features/favorites/presentation/widgets/favorite_list_widget.dart';

class FavoriteListScreen extends StatefulWidget {
  const FavoriteListScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteListScreen> createState() => _FavoriteListScreenState();
}

class _FavoriteListScreenState extends State<FavoriteListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritelistCubit>().loadFavoritelist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          customAppBar('WISHLIST', context, automaticallyImplyLeading: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<FavoritelistCubit>().clearFavoritelist();
        },
        child: const Icon(Icons.delete_forever_outlined),
      ),
      body: BlocListener<FavoritelistCubit, FavoritelistState>(
        listener: (context, state) {
          if (state is FavoritelistInitialState) {
            // Handle error state
            // You can show an error message here
          }
        },
        child: BlocBuilder<FavoritelistCubit, FavoritelistState>(
          builder: (context, state) {
            if (state is FavoritelistLoadedState) {
              if (state.favoritelist.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "NO FAVORITES",
                        style:
                            AppText.h3b?.copyWith(color: AppColors.CommonCyan),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "There Is No Saved Products.\n Please Add New Products!",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
              } else {
                return GridView.builder(
                  padding: EdgeInsets.all(10.sp),
                  itemCount: state.favoritelist.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.55,
                    crossAxisSpacing: 6,
                  ),
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final product = state.favoritelist[index];
                    return FavoritelistWidget(
                      favorite: product,
                      isFromFavoritelist: true,
                      removeFromFavoriteList: (photo) {
                        context
                            .read<FavoritelistCubit>()
                            .removeFromFavoritelist(product);
                      },
                    );
                  },
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.CommonCyan,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
