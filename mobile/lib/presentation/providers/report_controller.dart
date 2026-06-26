import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/waste_repository.dart';
import '../../data/providers/api_providers.dart';

class ReportController extends StateNotifier<AsyncValue<void>> {
  final IWasteRepository _repository;
  final Ref _ref;

  ReportController(this._repository, this._ref)
    : super(const AsyncValue.data(null));

  Future<bool> runPipelineAndSubmit({
    required File imageFile,
    required double latitude,
    required double longitude,
  }) async {
    state = const AsyncValue.loading();

    try {
      final currentUserId = _ref
          .read(supabaseClientProvider)
          .auth
          .currentUser
          ?.id;
      if (currentUserId == null)
        throw Exception("User session not authenticated");

      // Phase 1: Fire off classification to FastAPI
      final aiResult = await _repository.classifyImage(imageFile);
      final String detectedType = aiResult['waste_type'];
      final double confidence = aiResult['confidence'];

      // Phase 2: Upload photo binary into storage bucket
      final String publicPhotoUrl = await _repository.uploadPhoto(
        imageFile,
        currentUserId,
      );

      // Phase 3: Push payload metadata + spatial geometry record into Postgres
      await _repository.submitReport(
        userId: currentUserId,
        photoUrl: publicPhotoUrl,
        wasteType: detectedType,
        confidenceScore: confidence,
        latitude: latitude,
        longitude: longitude,
      );

      state = const AsyncValue.data(null);
      return true;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return false;
    }
  }
}

final reportControllerProvider =
    StateNotifierProvider<ReportController, AsyncValue<void>>((ref) {
      final repo = ref.watch(wasteRepositoryProvider);
      return ReportController(repo, ref);
    });
