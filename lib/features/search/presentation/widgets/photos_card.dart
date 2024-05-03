import 'package:flutter/material.dart';
import 'package:genius_assesment/features/search/domain/entities/photos.dart';

const photosImageKey = Key('photos-image');

const photosNameKey = Key('photos-name');

class PhotosCard extends StatelessWidget {
  const PhotosCard({
    super.key,
    required this.photos,
  });

  final Photos photos;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            photos.largeImageURL,
            key: photosImageKey,
            fit: BoxFit.fitWidth,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              photos.user,
              key: photosNameKey,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
