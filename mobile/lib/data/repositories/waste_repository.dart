import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../providers/api_providers.dart';

abstract class IWasteRepository {
  Future<Map<String, dynamic>> classifyImage(File imageFile);
  Future<String> uploadPhoto(File imageFile, String userId);
  Future<void> submitReport({
    required String userId,
    required String photoUrl,
    required String wasteType,
    required double confidenceScore,
    required double latitude,
    required double longitude,
  });
}

class WasteRepository implements IWasteRepository {
  final SupabaseClient _supabase;
  final http.Client _httpClient;

  WasteRepository(this._supabase, this._httpClient);

  // 1. Pipe image bytes directly to your FastAPI Python service
  @override
  Future<Map<String, dynamic>> classifyImage(File imageFile) async {
    final uri = Uri.parse('${ApiConstants.aiServiceBaseUrl}/classify');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('AI Classification service failed: ${response.body}');
    }
  }

  // 2. Upload the file to the public 'waste_photos' bucket we set up earlier
  @override
  Future<String> uploadPhoto(File imageFile, String userId) async {
    final String fileName =
        '${userId}_${DateTime.now().millisecondsSinceEpoch}.jpg';

    await _supabase.storage
        .from('waste_photos')
        .upload(
          fileName,
          imageFile,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );

    // Construct and return the public URL endpoint
    return _supabase.storage.from('waste_photos').getPublicUrl(fileName);
  }

  // 3. Save payload to the database using the PostGIS spatial Point format
  @override
  Future<void> submitReport({
    required String userId,
    required String photoUrl,
    required String wasteType,
    required double confidenceScore,
    required double latitude,
    required double longitude,
  }) async {
    // PostGIS maps geography geometry using a WKT standard string: POINT(longitude latitude)
    // CRITICAL: Lon comes first in standard GIS coordinates
    final String spatialLocationWkt = 'POINT($longitude $latitude)';

    await _supabase.from('waste_reports').insert({
      'user_id': userId,
      'photo_url': photoUrl,
      'waste_type': wasteType,
      'confidence_score': confidenceScore,
      'location': spatialLocationWkt,
      'status': 'reported',
    });
  }
}

// Expose the fully initialized repository interface to Riverpod controllers
final wasteRepositoryProvider = Provider<IWasteRepository>((ref) {
  final supabase = ref.watch(supabaseClientProvider);
  final client = ref.watch(httpClientProvider);
  return WasteRepository(supabase, client);
});
