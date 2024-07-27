// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:arrow_client/core/extensions/dartz_x.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:arrow_client/domain/failure/failure.dart';
import 'package:arrow_client/domain/prediction/i_predict_arrow_repo.dart';
import 'package:arrow_client/domain/prediction/prediction.dart';
import 'package:arrow_client/infrastructure/services/camera_service.dart';
import 'package:arrow_client/infrastructure/services/predict_arrow_service.dart';

@LazySingleton(as: IPredictArrowRepo)
class PredictArrowRepo implements IPredictArrowRepo {
  final PredictArrowService _predictArrowService;
  final CameraService _cameraService;
  PredictArrowRepo(this._predictArrowService, this._cameraService);

  @override
  Stream<Either<Failure, Prediction>> predictionStream() async* {
    final StreamController<Either<Failure, Prediction>> streamController =
        StreamController();

    _cameraService.imageStream().listen((failureOrImage) {
      if (failureOrImage.isLeft()) {
        streamController.add(Left(failureOrImage.getLeft()));
      }
      if (failureOrImage.isRight()) {
        final image = failureOrImage.getOrCrash();
        _predictArrowService.predictArrow(image).then((failureOrPrediction) {
          if (failureOrPrediction.isLeft()) {
            streamController.add(Left(failureOrPrediction.getLeft()));
          }
          if (failureOrPrediction.isRight()) {
            streamController.add(Right(failureOrPrediction.getOrCrash()));
          }
        });
      }
    });

    yield* streamController.stream;
  }
}
