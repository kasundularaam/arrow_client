import 'package:arrow_client/application/camera/camera_cubit.dart';
import 'package:arrow_client/application/stream/stream_cubit.dart';
import 'package:arrow_client/injection.dart';
import 'package:auto_route/annotations.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class StreamPage extends StatelessWidget {
  const StreamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CameraCubit>()..initCamera(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Arrow Prediction"),
        ),
        body: BlocBuilder<CameraCubit, CameraState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (controller) => CameraView(controller: controller),
              orElse: () => const Center(child: Text("Unknown State")),
            );
          },
        ),
      ),
    );
  }
}

class CameraView extends StatelessWidget {
  final CameraController controller;

  const CameraView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<StreamCubit>()..startPrediction(),
      child: Column(
        children: [
          CameraPreview(controller),
          Expanded(
            child: BlocBuilder<StreamCubit, StreamState>(
              builder: (context, state) {
                return state.maybeWhen(
                    prediction: (prediction) => Center(
                          child: Column(
                            children: [
                              Text("Prediction: ${prediction.direction}"),
                              Text("Confidence: ${prediction.confidence}"),
                            ],
                          ),
                        ),
                    failed: (failure) => Center(child: Text(failure.message)),
                    orElse: () =>
                        const Center(child: Text("Waiting for prediction...")));
              },
            ),
          )
        ],
      ),
    );
  }
}
