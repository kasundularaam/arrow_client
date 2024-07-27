// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:arrow_client/core/extensions/dartz_x.dart';
import 'package:arrow_client/domain/failure/failure.dart';

@lazySingleton
class CameraService {
  Option<CameraController> _cameraControllerOption = const None();

  Future<Either<Failure, CameraController>> initCamera() async {
    try {
      final List<CameraDescription> cameras = await availableCameras();
      final CameraController cameraController = CameraController(
        cameras.first,
        ResolutionPreset.medium,
      );
      await cameraController.initialize();
      _cameraControllerOption = Some(cameraController);
      return Right(cameraController);
    } catch (error) {
      return const Left(Failure("Failed to initialize camera"));
    }
  }

  Stream<Either<Failure, File>> imageStream() async* {
    final StreamController<Either<Failure, File>> streamController =
        StreamController();
    if (_cameraControllerOption.isNone()) {
      streamController.add(const Left(Failure("Camera controller not set")));
    }
    final CameraController cameraController =
        _cameraControllerOption.getOrCrash();

    int frameCount = 0;

    cameraController.startImageStream((_) async {
      frameCount++;
      if (frameCount % 5 != 0) {
        return;
      }
      cameraController.takePicture().then((XFile file) async {
        final image = File(file.path);
        streamController.add(Right(image));
      });
    });

    yield* streamController.stream;
  }
}
