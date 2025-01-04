// image_load_cubit.dart
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/core/common/cubit/image_load/image_load_state.dart';

class ImageLoadCubit extends Cubit<ImageLoadState> {
  ImageLoadCubit() : super(ImageLoadInitial());
  Timer? _timer;

  void loadImage(String url, {Duration timeout = const Duration(seconds: 5)}) {
    emit(ImageLoading());
    _timer = Timer(timeout, () {
      if (state is ImageLoading) {
        emit(ImageTimeout());
      }
    });
  }

  void imageLoaded() {
    _timer?.cancel();
    emit(ImageLoaded());
  }

  void imageError() {
    _timer?.cancel();
    emit(ImageError());
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}