import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image/image.dart' as img;
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

class ImageClassifier {
  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model.tflite',
      labels: 'assets/labels.txt',
    );
  }

  void dispose() {
    Tflite.close();
  }

  Future<String?> classifyImage(File image) async {
    // Classify using the custom model
    final customModelLabel = await _classifyImageWithCustomModel(image);

    // If custom model returns a label, return it
    if (customModelLabel != null) {
      return customModelLabel;
    }

    // If custom model does not return a label, try Google ML Kit
    final googleMLKitLabel = await _classifyImageWithGoogleMLKit(image);
    return googleMLKitLabel;
  }

  Future<String?> _classifyImageWithCustomModel(File image) async {
    final imageBytes = await image.readAsBytes();
    final input = _preprocessImage(imageBytes);

    final output = await Tflite.runModelOnBinary(
      binary: input,
      numResults: 1,
      threshold: 0.99
    );

    if (output != null && output.isNotEmpty) {
      final labels = _getLabelsFromOutput(output);
      return labels[0]['label'];
    }
    return null;
  }

  Uint8List _preprocessImage(Uint8List imageBytes) {
    img.Image image = img.decodeImage(imageBytes)!;
    img.Image resizedImage = img.copyResize(image, width: 224, height: 224);

    // Normalize the image
    List<double> normalizedImage = [];
    for (int y = 0; y < resizedImage.height; y++) {
      for (int x = 0; x < resizedImage.width; x++) {
        final pixel = resizedImage.getPixel(x, y);
        normalizedImage.add((img.getRed(pixel) / 127.5) - 1);
        normalizedImage.add((img.getGreen(pixel) / 127.5) - 1);
        normalizedImage.add((img.getBlue(pixel) / 127.5) - 1);
      }
    }

    return Float32List.fromList(normalizedImage).buffer.asUint8List();
  }

  List<Map<String, dynamic>> _getLabelsFromOutput(List<dynamic> output) {
    return output.map((e) => {
      'label': e['label'],
      'confidence': e['confidence'],
    }).toList();
  }

  Future<String?> _classifyImageWithGoogleMLKit(File image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final imageLabeler = ImageLabeler(options: ImageLabelerOptions(confidenceThreshold: 0.5));

    final labels = await imageLabeler.processImage(inputImage);

    if (labels.isNotEmpty) {
      var topLabel = labels.first;
      if ((topLabel.label == 'Vehicle' || topLabel.label == 'Musical instrument') && labels.length >= 2) {
        topLabel = labels[1];
      }
      imageLabeler.close();
      return topLabel.label;
    }

    imageLabeler.close();
    return null;
  }
}
