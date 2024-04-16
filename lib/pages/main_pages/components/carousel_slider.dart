import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../services/local_variables.dart';

class CustomCarouselSlider extends StatefulWidget {
  final List<String> bannerImages;
  final List<String> imageTitles;
  final List<String> imageSubtitles;

  CustomCarouselSlider({
    List<String>? bannerImages,
    List<String>? imageTitles,
    List<String>? imageSubtitles,
  })  : bannerImages = bannerImages ??
            [
              LocalVariables.photoURL ?? '',
              LocalVariables.photoURL ?? '',
              LocalVariables.photoURL ?? '',
              LocalVariables.photoURL ?? '',
              LocalVariables.photoURL ?? '',
            ],
        imageTitles = imageTitles ??
            [
              'Title 1',
              'Title 2',
              'Title 3',
              'Title 4',
              'Title 5',
            ],
        imageSubtitles = imageSubtitles ??
            [
              'Subtitle 1',
              'Subtitle 2',
              'Subtitle 3',
              'Subtitle 4',
              'Subtitle 5',
            ];

  @override
  _CustomCarouselSliderState createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  // ignore: unused_field
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Adjusted height to accommodate image and title
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          onPageChanged: (index, reason) {
            setState(() {
              _currentImageIndex = index;
            });
          },
          viewportFraction: 0.33,
        ),
        items: widget.bannerImages.asMap().entries.map((entry) {
          int index = entry.key;
          String imagePath = entry.value;
          String title = widget.imageTitles[index];
          String? subtitle = widget.imageSubtitles[index];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    imagePath,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF353434),
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF353434),
                    fontSize: 12,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
