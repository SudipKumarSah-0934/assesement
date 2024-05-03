import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genius_assesment/core/configs/app_dimensions.dart';
import 'package:shimmer/shimmer.dart';



Widget LoadingShimmer({required bool isSquare}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.sp),
    child: Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey.shade300,
      child: Card(
        color: Colors.grey.shade100,
        elevation: 4,
        margin: const EdgeInsets.only(right: 16),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          height: AppDimensions.normalize(70),
          width: isSquare ? AppDimensions.normalize(70) : double.infinity,
        ),
      ),
    ),
  );
}
Widget placeholderShimmer(){
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.white,
    child: Container(),
  );
}
