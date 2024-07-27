import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

@lazySingleton
class ImageService {
  Future<File> convertCameraImageToJpgFile(CameraImage cameraImage) async {
    // Convert CameraImage to JPG bytes
    Uint8List jpgBytes = await _convertCameraImageToJpg(cameraImage);

    // Get temporary directory
    final Directory tempDir = await getTemporaryDirectory();

    // Create a unique filename
    final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final String filePath = '${tempDir.path}/$fileName';

    // Write bytes to file
    File imgFile = File(filePath);
    await imgFile.writeAsBytes(jpgBytes);

    return imgFile;
  }

  Future<Uint8List> _convertCameraImageToJpg(CameraImage cameraImage) async {
    // Convert CameraImage to Image
    img.Image image;
    if (cameraImage.format.group == ImageFormatGroup.yuv420) {
      image = _convertYUV420ToImage(cameraImage);
    } else if (cameraImage.format.group == ImageFormatGroup.bgra8888) {
      image = img.Image.fromBytes(
        width: cameraImage.width,
        height: cameraImage.height,
        bytes: cameraImage.planes[0].bytes.buffer,
        format: img.Format.uint8,
      );
    } else {
      throw Exception('Image format not supported');
    }

    // Encode to JPG
    List<int> jpgBytes = img.encodeJpg(image);
    return Uint8List.fromList(jpgBytes);
  }

  img.Image _convertYUV420ToImage(CameraImage cameraImage) {
    final int width = cameraImage.width;
    final int height = cameraImage.height;
    final img.Image image = img.Image(width: width, height: height);

    Plane yPlane = cameraImage.planes[0];
    Plane uPlane = cameraImage.planes[1];
    Plane vPlane = cameraImage.planes[2];

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final int uvIndex = (y ~/ 2) * (width ~/ 2) + (x ~/ 2);
        final int index = y * width + x;

        final int yValue = yPlane.bytes[index];
        final int uValue = uPlane.bytes[uvIndex];
        final int vValue = vPlane.bytes[uvIndex];

        int r = (yValue + vValue * 1436 ~/ 1024 - 179).clamp(0, 255);
        int g = (yValue - uValue * 46 ~/ 1024 - vValue * 93 ~/ 1024 + 44)
            .clamp(0, 255);
        int b = (yValue + uValue * 1814 ~/ 1024 - 227).clamp(0, 255);

        image.setPixelRgba(x, y, r, g, b, 255);
      }
    }

    return image;
  }
}
