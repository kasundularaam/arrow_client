part of 'camera_cubit.dart';

@freezed
class CameraState with _$CameraState {
  const factory CameraState.loading() = _Initial;
  const factory CameraState.loaded(CameraController controller) = _Loaded;
  const factory CameraState.failed(Failure failure) = _Failed;
}
