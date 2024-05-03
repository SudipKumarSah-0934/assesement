import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:genius_assesment/core/configs/app_dimensions.dart';
import 'package:genius_assesment/core/configs/app_typography.dart';
import 'package:genius_assesment/core/configs/byte_to_mb_ext.dart';
import 'package:genius_assesment/core/constant/assets.dart';
import 'package:genius_assesment/core/constant/colors.dart';
import 'package:genius_assesment/features/search/data/models/photos_model.dart';
import 'package:genius_assesment/features/search/presentation/widgets/loading_shimmer.dart';

class  FavoritelistWidget extends StatelessWidget {
  final PhotosModel favorite;
  final bool isFromFavoritelist;
  final Function(PhotosModel favorite) removeFromFavoriteList;

  const  FavoritelistWidget(
      {super.key,
      required this.favorite,
      required this.isFromFavoritelist,
      required this.removeFromFavoriteList});

  @override
  Widget build(BuildContext context) {
    return favorite == null
        ? LoadingShimmer(isSquare: true)
        : buildBody(context);
  }

  Widget buildBody(BuildContext context) {
    return Stack(children: [
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
                  topLeft: Radius.circular(10.r), // Adjust the radius as needed
                  topRight: Radius.circular(10.r),
                ),
                child: Hero(
                  tag: favorite.id,
                  child: favorite.largeImageURL.isNotEmpty
                      ? CachedNetworkImage(
                          width: double.infinity,
                          fit: BoxFit.cover,
                          height: AppDimensions.normalize(70),
                          imageUrl: favorite.largeImageURL,
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
              favorite.user,
              style: AppText.h3b,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              favorite.imageSize.toMegabytes(),
              style: AppText.h3?.copyWith(
                color: AppColors.CommonCyan,
              ),
            )
          ],
        ),
      ),
      Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          onPressed: () {
            _showRemoveConfirmationDialog(context);
          },
        ),
      ),
    ]);
  }

  void _showRemoveConfirmationDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Remove from Favoritelist",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                "Are you sure you want to remove this item from your Favoritelist?",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      removeFromFavoriteList(favorite);
                      Navigator.of(context).pop();
                    },
                    child: Text("Remove"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
