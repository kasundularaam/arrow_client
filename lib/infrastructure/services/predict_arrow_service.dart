import 'dart:io';

import 'package:arrow_client/core/extensions/dartz_x.dart';
import 'package:arrow_client/domain/failure/failure.dart';
import 'package:arrow_client/domain/prediction/prediction.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PredictArrowService {
  final Dio _dio;
  PredictArrowService(this._dio);

  Option<String> _ipAddress = const None();

  set ipAddress(String ipAddress) {
    _ipAddress = Some(ipAddress);
  }

  Future<Either<Failure, Prediction>> predictArrow(File image) async {
    if (_ipAddress.isNone()) {
      return const Left(Failure("IP address not set"));
    }
    final String ipAddress = _ipAddress.getOrCrash();
    final String url = "http://$ipAddress:5001/predict";

    try {
      final FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(image.path),
      });

      final Response response = await _dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
          receiveTimeout: const Duration(seconds: 15),
          sendTimeout: const Duration(seconds: 15),
        ),
      );

      final Prediction prediction = Prediction.fromJson(response.data);
      return Right(prediction);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return const Left(
            Failure("Connection timed out. Please check your network."));
      } else if (e.type == DioExceptionType.badResponse) {
        return Left(Failure("Server error: ${e.response?.statusCode}"));
      } else {
        return Left(Failure("Network error: ${e.message}"));
      }
    } catch (error) {
      return Left(Failure("Unexpected error occurred: $error"));
    }
  }
}
