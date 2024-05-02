import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class FileHelper {
  static Future<File?> saveFromFile(File srcFile) async {
    if (srcFile.existsSync() == false) {
      return null;
    }
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final srcName = path.basename(srcFile.path);
    final destName = path.join(appDir.path, srcName);
    debugPrint('save from ${srcFile.path} to $destName');
    final destFile = await srcFile.copy(destName);
    return destFile;
  }

  static Future<File?> saveFromPath(String filePath) async {
    final File file = File(filePath);
    return saveFromFile(file);
  }

  static Future<void> deleteFromPath(String filePath) async {
    final file = File(filePath);
    if (file.existsSync()) {
      await file.delete();
    }
  }
}
