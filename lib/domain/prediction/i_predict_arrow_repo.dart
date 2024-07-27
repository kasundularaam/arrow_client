import 'package:arrow_client/domain/failure/failure.dart';
import 'package:arrow_client/domain/prediction/prediction.dart';
import 'package:dartz/dartz.dart';

abstract class IPredictArrowRepo {
  Stream<Either<Failure, Prediction>> predictionStream();
}
