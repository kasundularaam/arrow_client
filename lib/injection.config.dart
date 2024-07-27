// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:arrow_client/application/address/address_cubit.dart' as _i174;
import 'package:arrow_client/application/camera/camera_cubit.dart' as _i940;
import 'package:arrow_client/application/stream/stream_cubit.dart' as _i947;
import 'package:arrow_client/domain/address/i_address_repo.dart' as _i328;
import 'package:arrow_client/domain/camera/i_camera_repo.dart' as _i567;
import 'package:arrow_client/domain/prediction/i_predict_arrow_repo.dart'
    as _i832;
import 'package:arrow_client/infrastructure/repo/address_repo.dart' as _i497;
import 'package:arrow_client/infrastructure/repo/camera_repo.dart' as _i706;
import 'package:arrow_client/infrastructure/repo/predict_arrow_repo.dart'
    as _i497;
import 'package:arrow_client/infrastructure/services/camera_service.dart'
    as _i340;
import 'package:arrow_client/infrastructure/services/core/injectable_modules.dart'
    as _i108;
import 'package:arrow_client/infrastructure/services/image_service.dart'
    as _i474;
import 'package:arrow_client/infrastructure/services/predict_arrow_service.dart'
    as _i42;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectableModules = _$InjectableModules();
    gh.lazySingleton<_i340.CameraService>(() => _i340.CameraService());
    gh.lazySingleton<_i361.Dio>(() => injectableModules.dio);
    gh.lazySingleton<_i474.ImageService>(() => _i474.ImageService());
    gh.lazySingleton<_i42.PredictArrowService>(
        () => _i42.PredictArrowService(gh<_i361.Dio>()));
    gh.lazySingleton<_i567.ICameraRepo>(
        () => _i706.CameraRepo(gh<_i340.CameraService>()));
    gh.lazySingleton<_i832.IPredictArrowRepo>(() => _i497.PredictArrowRepo(
          gh<_i42.PredictArrowService>(),
          gh<_i340.CameraService>(),
        ));
    gh.factory<_i940.CameraCubit>(
        () => _i940.CameraCubit(gh<_i567.ICameraRepo>()));
    gh.lazySingleton<_i328.IAddressRepo>(
        () => _i497.AddressRepo(gh<_i42.PredictArrowService>()));
    gh.factory<_i174.AddressCubit>(
        () => _i174.AddressCubit(gh<_i328.IAddressRepo>()));
    gh.factory<_i947.StreamCubit>(
        () => _i947.StreamCubit(gh<_i832.IPredictArrowRepo>()));
    return this;
  }
}

class _$InjectableModules extends _i108.InjectableModules {}
