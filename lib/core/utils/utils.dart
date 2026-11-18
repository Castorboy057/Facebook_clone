import 'dart:io';

import 'package:flutter/material.dart'; // <--- Necesario para BuildContext y showDatePicker
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  File? imageFile;
  final pciker = ImagePicker();
  final file = await pciker.pickImage(
    source: ImageSource.gallery,
    maxWidth: 700,
    maxHeight: 700,
  );

  if (file != null) {
    imageFile = File(file.path);
  }

  return imageFile;
}

// <--- Agrega esta función aquí abajito:
Future<DateTime?> pickSimpleDate({
  required BuildContext context,
  DateTime? date,
}) async {
  final initialDate = date ?? DateTime.now();
  final pickedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );
  return pickedDate ?? date;
}
