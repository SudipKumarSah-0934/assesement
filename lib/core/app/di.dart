import 'package:genius_assesment/core/app/common.dart';
import 'package:genius_assesment/core/app/cubits.dart';
import 'package:genius_assesment/core/app/photo.dart';

import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

// Main Initialization
Future<void> init() async {
  // Register features
  registerPhotoFeature();

  // Register Cubits
  registerCubits();

  // Register common dependencies
  registerCommonDependencies();
}
