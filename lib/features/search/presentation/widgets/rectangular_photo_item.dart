import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:genius_assesment/core/configs/app_dimensions.dart';
import 'package:genius_assesment/core/configs/app_typography.dart';
import 'package:genius_assesment/core/configs/byte_to_mb_ext.dart';
import 'package:genius_assesment/core/constant/assets.dart';
import 'package:genius_assesment/core/constant/colors.dart';
import 'package:genius_assesment/features/favorites/presentation/cubit/favoritelist_cubit.dart';
import 'package:genius_assesment/features/search/data/models/photos_model.dart';
import 'package:genius_assesment/features/search/domain/entities/photos.dart';
import 'package:genius_assesment/features/search/presentation/widgets/loading_shimmer.dart';

class RectangularPhotoItem extends StatefulWidget {
  final Photos? photo;
  bool isFromFavoritelist = false;

  RectangularPhotoItem({
    Key? key,
    this.photo,
    this.isFromFavoritelist = false,
  }) : super(key: key);

  @override
  State<RectangularPhotoItem> createState() => _RectangularPhotoItemState();
}

class _RectangularPhotoItemState extends State<RectangularPhotoItem> {
  bool addedToFavorite=false;
  @override
  Widget build(BuildContext context) {
    return widget.photo == null
        ? LoadingShimmer(isSquare: true)
        : buildBody(context);
  }

  Widget buildBody(BuildContext context) {
    bool isProductInFavoritelist = context
        .read<FavoritelistCubit>()
        .isInFavoritelist(widget.photo!.user_id);
    return GestureDetector(
      onTap: () {
        context
            .read<FavoritelistCubit>()
            .addToFavoritelist(PhotosModel.fromEntity(widget.photo!));
        setState(() {
          addedToFavorite=true;
        });

      },
      child: Stack(children: [
        Card(
          elevation: 3,
          margin: EdgeInsets.only(bottom: AppDimensions.normalize(10.8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft:
                        Radius.circular(10.r), // Adjust the radius as needed
                    topRight: Radius.circular(10.r),
                  ),
                  child: Hero(
                    tag: widget.photo!.id,
                    child: widget.photo!.largeImageURL.isNotEmpty
                        ? CachedNetworkImage(
                            width: double.infinity,
                            fit: BoxFit.cover,
                            height: AppDimensions.normalize(70),
                            imageUrl: widget.photo!.largeImageURL,
                            placeholder: (context, url) => placeholderShimmer(),
                            errorWidget: (context, url, error) =>
                                const Center(child: Icon(Icons.error)),
                          )
                        : SvgPicture.asset(
                            AppAssets.noImageIcon,
                            height: AppDimensions.normalize(70),
                          ),
                  ),
                ),
              ),
              Text(
                widget.photo!.user,
                style: AppText.h3b,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                widget.photo!.imageSize.toMegabytes(),
                style: AppText.h3?.copyWith(
                  color: AppColors.CommonCyan,
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child:
             Icon(
              isProductInFavoritelist || addedToFavorite ? Icons.favorite : Icons.favorite_border,
              color: isProductInFavoritelist ? Colors.red : null,


          ),
        ),
      ]),
    );
  }
}
