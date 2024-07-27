// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:arrow_client/core/extensions/dartz_x.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:arrow_client/domain/camera/i_camera_repo.dart';
import 'package:arrow_client/domain/failure/failure.dart';

part 'camera_cubit.freezed.dart';
part 'camera_state.dart';

@injectable
class CameraCubit extends Cubit<CameraState> {
  final ICameraRepo _cameraRepo;
  CameraCubit(
    this._cameraRepo,
  ) : super(const CameraState.loading());

  Future<void> initCamera() async {
    final failureOrCameraController = await _cameraRepo.initCamera();
    if (failureOrCameraController.isLeft()) {
      emit(CameraState.failed(failureOrCameraController.getLeft()));
      return;
    }
    emit(CameraState.loaded(failureOrCameraController.getOrCrash()));
  }
}
