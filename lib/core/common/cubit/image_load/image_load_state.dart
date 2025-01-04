// image_load_state.dart
abstract class ImageLoadState {
  const ImageLoadState();
}

class ImageLoadInitial extends ImageLoadState {}
class ImageLoading extends ImageLoadState {}
class ImageLoaded extends ImageLoadState {}
class ImageError extends ImageLoadState {}
class ImageTimeout extends ImageLoadState {}