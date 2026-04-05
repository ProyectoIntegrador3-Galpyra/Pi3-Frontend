import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../errors/exceptions.dart';

/// Service for camera and image capture functionality
class CameraService {
  final ImagePicker _imagePicker = ImagePicker();

  /// Request camera permission
  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  /// Check if camera permission is granted
  Future<bool> hasCameraPermission() async {
    return await Permission.camera.isGranted;
  }

  /// Capture image from camera
  Future<File?> captureImage({
    ImageSource source = ImageSource.camera,
    int imageQuality = 85,
    double? maxWidth,
    double? maxHeight,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
  }) async {
    final hasPermission = await requestCameraPermission();
    
    if (!hasPermission) {
      throw const PermissionException(
        message: 'Se requiere permiso de cámara para capturar fotos',
      );
    }

    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        imageQuality: imageQuality,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        preferredCameraDevice: preferredCameraDevice,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      throw AppException(
        message: 'Error al capturar la imagen',
        originalException: e,
      );
    }
  }

  /// Pick image from gallery
  Future<File?> pickFromGallery({
    int imageQuality = 85,
    double? maxWidth,
    double? maxHeight,
  }) async {
    final status = await Permission.photos.request();
    
    if (!status.isGranted && !status.isLimited) {
      throw const PermissionException(
        message: 'Se requiere permiso de galería para seleccionar fotos',
      );
    }

    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: imageQuality,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      throw AppException(
        message: 'Error al seleccionar la imagen',
        originalException: e,
      );
    }
  }

  /// Pick multiple images from gallery
  Future<List<File>> pickMultipleFromGallery({
    int imageQuality = 85,
    double? maxWidth,
    double? maxHeight,
    int? limit,
  }) async {
    final status = await Permission.photos.request();
    
    if (!status.isGranted && !status.isLimited) {
      throw const PermissionException(
        message: 'Se requiere permiso de galería para seleccionar fotos',
      );
    }

    try {
      final List<XFile> pickedFiles = await _imagePicker.pickMultiImage(
        imageQuality: imageQuality,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        limit: limit,
      );

      return pickedFiles.map((xFile) => File(xFile.path)).toList();
    } catch (e) {
      throw AppException(
        message: 'Error al seleccionar las imágenes',
        originalException: e,
      );
    }
  }

  /// Show image source picker dialog
  Future<ImageSource?> showImageSourcePicker(BuildContext context) async {
    return showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Cámara'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galería'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}
