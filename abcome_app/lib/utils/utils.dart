import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class Utils {
  // <------------------------- Utils for Images ------------------------->
  static Image imageFromBase64String(String base64String,
      {double? width, double? height, BoxFit? fit}) {
    try {
      return Image.memory(
        base64Decode(base64String),
        width: width,
        height: height,
        fit: fit,
      );
    } catch (e) {
      return Image.asset(
        base64String,
        width: width,
        height: height,
        fit: fit,
      );
    }
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  static Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load(path);

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    //await file.writeAsBytes(byteData.buffer
        //.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  // <-------------------- Utils for Date and Time Pickers -------------------->
  static String toDateTime(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);
    final time = DateFormat.Hm().format(dateTime);

    return '$date $time';
  }

  static String toDate(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);

    return date;
  }

  static String toTime(DateTime dateTime) {
    final time = DateFormat.Hm().format(dateTime);

    return time;
  }
}
