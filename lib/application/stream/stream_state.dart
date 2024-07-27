part of 'stream_cubit.dart';

@freezed
abstract class StreamState with _$StreamState {
  const factory StreamState.initial() = _Initial;
  const factory StreamState.prediction(Prediction prediction) = _Prediction;
  const factory StreamState.failed(Failure failure) = _Failed;
}
