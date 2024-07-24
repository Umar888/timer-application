import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home_bloc.dart';

class ScreenshotTab extends StatelessWidget {
  const ScreenshotTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.screenshots.isEmpty) {
          return const Center(
            child: Text('No Screenshots captured yet',
              style: TextStyle(color: Colors.white),),
          );
        } else {
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: state.screenshots.length,
            itemBuilder: (context, index) {
              final screenshot = state.screenshots[index];
              return GestureDetector(
                onTap: () => _showImageDialog(context, screenshot),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.memory(
                    screenshot,
                    fit: BoxFit.cover, // Adjust the fit as needed
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
  void _showImageDialog(BuildContext context, Uint8List image) {
    showDialog(
      context: context,

      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),

          child: Stack(

            children: [
              Image.memory(image,fit: BoxFit.fill,), // Display the image
              Positioned(
                top: 5,
                right: 5,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}