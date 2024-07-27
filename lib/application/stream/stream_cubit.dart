// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:arrow_client/core/extensions/dartz_x.dart';
import 'package:arrow_client/domain/failure/failure.dart';
import 'package:arrow_client/domain/prediction/prediction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:arrow_client/domain/prediction/i_predict_arrow_repo.dart';

part 'stream_cubit.freezed.dart';
part 'stream_state.dart';

@injectable
class StreamCubit extends Cubit<StreamState> {
  final IPredictArrowRepo _arrowRepo;
  StreamCubit(
    this._arrowRepo,
  ) : super(const StreamState.initial());

  void startPrediction() {
    _arrowRepo.predictionStream().listen((failureOrPrediction) {
      if (failureOrPrediction.isLeft()) {
        emit(StreamState.failed(failureOrPrediction.getLeft()));
      }
      if (failureOrPrediction.isRight()) {
        emit(StreamState.prediction(failureOrPrediction.getOrCrash()));
      }
    });
  }
}
