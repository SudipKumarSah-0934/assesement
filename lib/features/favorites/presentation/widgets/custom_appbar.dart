import 'package:flutter/material.dart';
import 'package:genius_assesment/core/configs/app_dimensions.dart';
import 'package:genius_assesment/core/configs/app_typography.dart';
import 'package:genius_assesment/core/constant/colors.dart';

PreferredSizeWidget customAppBar(
  String title,
  BuildContext context, {
  bool automaticallyImplyLeading = false,
}) {
  return PreferredSize(
    preferredSize: Size(double.infinity, AppDimensions.normalize(30)),
    child: Padding(
      padding: EdgeInsets.only(top: AppDimensions.normalize(10)),
      child: AppBar(
        automaticallyImplyLeading: automaticallyImplyLeading,
        title: Text(
          title,
          style: AppText.b1b?.copyWith(color: AppColors.GreyText),
        ),
      ),
    ),
  );
}
