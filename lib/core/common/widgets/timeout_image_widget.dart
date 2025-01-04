import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/core/common/cubit/image_load/image_load_cubit.dart';
import 'package:news_app_clean_architecture/core/common/cubit/image_load/image_load_state.dart';

// timeout_image_widget.dart
class TimeoutImageWidget extends StatelessWidget {
  final String imageUrl;
  final Duration timeout;

  const TimeoutImageWidget({
    required this.imageUrl,
    this.timeout = const Duration(seconds: 5),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ImageLoadCubit()..loadImage(imageUrl, timeout: timeout),
      child: BlocBuilder<ImageLoadCubit, ImageLoadState>(
        builder: (context, state) {
          if (state is ImageTimeout) {
            return _buildErrorWidget();
          }

          return CachedNetworkImage(
            imageUrl: imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) {
              context.read<ImageLoadCubit>().imageError();
              return _buildErrorWidget();
            },
            errorListener: (error) {
              if (error is TimeoutException) {
                // Handle timeout specifically
                debugPrint('Image load timed out: $error');
              }
            },
            httpHeaders: const {
              'Connection': 'Keep-Alive',
              'Keep-Alive': 'timeout=5, max=1000' // 5 second timeout
            },
            imageBuilder: (context, imageProvider) {
              context.read<ImageLoadCubit>().imageLoaded();
              return Image(image: imageProvider, fit: BoxFit.cover);
            },
          );
        },
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_not_supported_outlined,
                size: 48, color: Colors.grey[400]),
            const SizedBox(height: 8),
            Text('No image available',
                style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
