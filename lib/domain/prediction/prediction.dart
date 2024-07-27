import 'package:freezed_annotation/freezed_annotation.dart';
part 'prediction.freezed.dart';
part 'prediction.g.dart';

@freezed
abstract class Prediction with _$Prediction {
  const factory Prediction({
    required String direction,
    required double confidence,
  }) = _Prediction;
  factory Prediction.fromJson(Map<String, Object?> json) =>
      _$PredictionFromJson(json);
}
