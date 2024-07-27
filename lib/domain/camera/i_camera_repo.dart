import 'dart:io';

import 'package:arrow_client/domain/failure/failure.dart';
import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';

abstract class ICameraRepo {
  Future<Either<Failure, CameraController>> initCamera();
  Stream<Either<Failure, File>> imageStream();
}
