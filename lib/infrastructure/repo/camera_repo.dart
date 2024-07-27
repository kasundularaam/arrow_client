// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';

import 'package:arrow_client/domain/camera/i_camera_repo.dart';
import 'package:arrow_client/domain/failure/failure.dart';
import 'package:arrow_client/infrastructure/services/camera_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ICameraRepo)
class CameraRepo implements ICameraRepo {
  final CameraService _cameraService;
  CameraRepo(this._cameraService);
  @override
  Stream<Either<Failure, File>> imageStream() => _cameraService.imageStream();

  @override
  Future<Either<Failure, CameraController>> initCamera() =>
      _cameraService.initCamera();
}
