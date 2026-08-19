import 'dart:io';
import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants/app_constants.dart';
import '../errors/exceptions.dart';

/// Dedicated service for Supabase Storage operations.
/// amTips uses Supabase ONLY for file storage (avatars, QR images, uploads),
/// while authentication is managed entirely through Firebase Authentication.
class SupabaseStorageService {
  final SupabaseClient _client;

  SupabaseStorageService({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  /// Uploads a user profile avatar into Supabase Storage.
  ///
  /// Stores the file under `avatars/<userId>/avatar_<timestamp>.<ext>`.
  /// Returns the public download URL of the uploaded image.
  Future<String> uploadProfileAvatar({
    required String userId,
    required File file,
  }) async {
    try {
      final ext = file.path.split('.').last.toLowerCase();
      final mimeType = _resolveMimeType(ext);
      final fileName = 'avatar_${DateTime.now().millisecondsSinceEpoch}.$ext';
      final storagePath = '$userId/$fileName';

      await _client.storage.from(AppConstants.avatarsBucket).upload(
            storagePath,
            file,
            fileOptions: FileOptions(
              upsert: true,
              contentType: mimeType,
            ),
          );

      return _client.storage
          .from(AppConstants.avatarsBucket)
          .getPublicUrl(storagePath);
    } on StorageException catch (e) {
      throw ServerException(
        message: 'Storage error (${e.statusCode}): ${e.message}',
        statusCode: int.tryParse(e.statusCode ?? ''),
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to upload profile avatar: $e',
        statusCode: null,
      );
    }
  }

  /// Uploads a QR code image as binary data to Supabase Storage.
  Future<String> uploadQrImage({
    required String userId,
    required Uint8List bytes,
  }) async {
    try {
      final storagePath = '$userId/qr_code.png';

      await _client.storage.from(AppConstants.qrBucket).uploadBinary(
            storagePath,
            bytes,
            fileOptions: const FileOptions(
              upsert: true,
              contentType: 'image/png',
            ),
          );

      return _client.storage
          .from(AppConstants.qrBucket)
          .getPublicUrl(storagePath);
    } on StorageException catch (e) {
      throw ServerException(
        message: 'Storage error (${e.statusCode}): ${e.message}',
        statusCode: int.tryParse(e.statusCode ?? ''),
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to upload QR image: $e',
        statusCode: null,
      );
    }
  }

  /// Generic file upload method for user files.
  Future<String> uploadFile({
    required String bucket,
    required String path,
    required File file,
    String? contentType,
  }) async {
    try {
      final ext = file.path.split('.').last.toLowerCase();
      final mime = contentType ?? _resolveMimeType(ext);

      await _client.storage.from(bucket).upload(
            path,
            file,
            fileOptions: FileOptions(
              upsert: true,
              contentType: mime,
            ),
          );

      return _client.storage.from(bucket).getPublicUrl(path);
    } on StorageException catch (e) {
      throw ServerException(
        message: 'Storage error (${e.statusCode}): ${e.message}',
        statusCode: int.tryParse(e.statusCode ?? ''),
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to upload file: $e',
        statusCode: null,
      );
    }
  }

  /// Uploads raw binary data to a specified bucket.
  Future<String> uploadBinary({
    required String bucket,
    required String path,
    required Uint8List bytes,
    String? contentType,
  }) async {
    try {
      await _client.storage.from(bucket).uploadBinary(
            path,
            bytes,
            fileOptions: FileOptions(
              upsert: true,
              contentType: contentType ?? 'application/octet-stream',
            ),
          );

      return _client.storage.from(bucket).getPublicUrl(path);
    } on StorageException catch (e) {
      throw ServerException(
        message: 'Storage error (${e.statusCode}): ${e.message}',
        statusCode: int.tryParse(e.statusCode ?? ''),
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to upload binary: $e',
        statusCode: null,
      );
    }
  }

  /// Deletes a file from Supabase Storage.
  Future<void> deleteFile({
    required String bucket,
    required String path,
  }) async {
    try {
      await _client.storage.from(bucket).remove([path]);
    } on StorageException catch (e) {
      throw ServerException(
        message: 'Storage error (${e.statusCode}): ${e.message}',
        statusCode: int.tryParse(e.statusCode ?? ''),
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to delete file: $e',
        statusCode: null,
      );
    }
  }

  /// Retrieves the public URL for a storage path.
  String getPublicUrl({
    required String bucket,
    required String path,
  }) {
    return _client.storage.from(bucket).getPublicUrl(path);
  }

  String _resolveMimeType(String ext) {
    switch (ext) {
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'webp':
        return 'image/webp';
      case 'gif':
        return 'image/gif';
      case 'pdf':
        return 'application/pdf';
      default:
        return 'application/octet-stream';
    }
  }
}
