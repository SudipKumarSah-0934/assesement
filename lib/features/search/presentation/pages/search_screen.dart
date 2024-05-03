import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_assesment/core/configs/app.dart';
import 'package:genius_assesment/core/configs/app_dimensions.dart';
import 'package:genius_assesment/core/configs/app_typography.dart';
import 'package:genius_assesment/core/constant/colors.dart';
import 'package:genius_assesment/core/error/failures.dart';
import 'package:genius_assesment/core/router/app_router.dart';
import 'package:genius_assesment/features/favorites/presentation/cubit/favoritelist_cubit.dart';
import 'package:genius_assesment/features/search/presentation/bloc/filter_cubit/filter_cubit.dart';
import 'package:genius_assesment/features/search/data/models/filter_params_model.dart';
import 'package:genius_assesment/features/search/presentation/bloc/photo_bloc.dart';
import '../widgets/rectangular_photo_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ScrollController scrollController = ScrollController();
  String value = '';

  void _scrollListener() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    double scrollPercentage = 0.7;
    if (currentScroll > (maxScroll * scrollPercentage)) {
      if (context.read<PhotoBloc>().state is PhotoLoaded) {
        context.read<PhotoBloc>().add(const GetMorePhotos());
      }
    }
  }

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppDimensions.normalize(20)),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppDimensions.normalize(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "SEARCH",
                  style: AppText.h1?.copyWith(color: AppColors.GreyText),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRouter.favoriteslist);
                    },
                    child: const Icon(Icons.favorite_rounded)),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.normalize(5)),
        child: Column(
          children: [
            10.verticalSpace,
            Row(
              children: [
                Container(
                  height: AppDimensions.normalize(20),
                  width: AppDimensions.normalize(95),
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Center(
                    child: TextField(
                      controller:
                          context.read<FilterCubit>().photosSearchController,
                      onChanged: (val) => setState(() {}),
                      onSubmitted: (val) {
                        setState(() {
                          value = val;
                        });
                        context
                            .read<PhotoBloc>()
                            .add(GetPhotos(FilterPhotoParams(keyword: val)));
                      },
                      cursorColor: AppColors.CommonCyan,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search Here",
                          hintStyle: AppText.b1
                              ?.copyWith(fontWeight: FontWeight.w300)),
                    ),
                  ),
                ),
                10.horizontalSpace,
                Flexible(
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          value = context
                              .read<FilterCubit>()
                              .photosSearchController
                              .text
                              .toString()
                              .trim();
                        });
                        context
                            .read<PhotoBloc>()
                            .add(GetPhotos(FilterPhotoParams(keyword: value)));
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStatePropertyAll(
                          Size(
                            AppDimensions.normalize(42),
                            AppDimensions.normalize(20),
                          ),
                        ),
                      ),
                      child: Text(
                        "Search",
                        style: AppText.h3b?.copyWith(color: Colors.white),
                      )),
                ),
              ],
            ),
            15.verticalSpace,
            context.read<FilterCubit>().photosSearchController.text.isEmpty
                ? SizedBox.shrink()
                : Row(
                    children: [
                      Text(
                        "Search Results for ",
                        style: AppText.h3,
                      ),
                      Text(
                        "' $value '",
                        style: AppText.h3b,
                      ),
                    ],
                  ),
            20.verticalSpace,
            context.read<FilterCubit>().photosSearchController.text.isEmpty
                ? const SizedBox.shrink()
                : Expanded(
                    child: BlocBuilder<PhotoBloc, PhotoState>(
                      builder: (context, state) {
                        //Result Empty and No Error
                        if (state is PhotoLoaded && state.photos.isEmpty) {
                          return Center(
                            child: Container(
                              height: AppDimensions.normalize(50),
                              width: AppDimensions.normalize(120),
                              decoration: const BoxDecoration(
                                  color: AppColors.LightGrey),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.sp),
                                  child: Column(
                                    children: [
                                      Text(
                                        "NO RESULT FOUND",
                                        style: AppText.h3b?.copyWith(
                                            color: AppColors.CommonCyan),
                                      ),
                                      10.verticalSpace,
                                      const Text("There is no such photo"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        //Error and no preloaded data
                        if (state is PhotoError && state.photos.isEmpty) {
                          if (state.failure is NetworkFailure) {
                            return const Center(
                              child: Text("Network Error"),
                            );
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (state.failure is ServerFailure)
                                const Text("Photos not found!"),
                              if (state.failure is CacheFailure)
                                const Text("Photos not found!"),
                              IconButton(
                                  onPressed: () {
                                    context.read<PhotoBloc>().add(GetPhotos(
                                        FilterPhotoParams(
                                            keyword: context
                                                .read<FilterCubit>()
                                                .photosSearchController
                                                .text)));
                                  },
                                  icon: const Icon(Icons.refresh)),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                              )
                            ],
                          );
                        }
                        return GridView.builder(
                          itemCount: state.photos.length +
                              ((state is PhotoLoading) ? 10 : 0),
                          controller: scrollController,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.55,
                            crossAxisSpacing: 6,
                          ),
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            if (state.photos.length > index) {
                              return RectangularPhotoItem(
                                photo: state.photos[index],
                              );
                            }
                            return RectangularPhotoItem();
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
