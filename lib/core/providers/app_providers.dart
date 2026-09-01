import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/subject_enum.dart';
import '../models/difficulty_enum.dart';
import '../models/user_profile_model.dart';
import '../models/quiz_session_model.dart';
import '../models/badge_model.dart';
import '../services/storage_service.dart';
import '../services/gemini_ai_service.dart';
import '../../data/repositories/quiz_repository.dart';
import '../../data/repositories/user_repository.dart';

// Storage Service Provider (Overridden in main)
final storageServiceProvider = Provider<StorageService>((ref) {
  throw UnimplementedError('storageServiceProvider must be initialized');
});

// Gemini AI Service Provider
final geminiAIServiceProvider = Provider<GeminiAIService>((ref) {
  final storage = ref.watch(storageServiceProvider);
  return GeminiAIService(storage);
});

// Quiz Repository Provider
final quizRepositoryProvider = Provider<QuizRepository>((ref) {
  final aiService = ref.watch(geminiAIServiceProvider);
  return QuizRepository(aiService);
});

// User Repository Provider
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final storage = ref.watch(storageServiceProvider);
  return UserRepository(storage);
});

// Session Selection State Providers
final studentNameProvider = StateProvider<String>((ref) {
  final userRepo = ref.watch(userRepositoryProvider);
  return userRepo.getStudentName();
});

final selectedSubjectProvider = StateProvider<Subject?>((ref) => null);

final selectedGradeProvider = StateProvider<int?>((ref) => null);

final selectedDifficultyProvider = StateProvider<QuizDifficulty>((ref) => QuizDifficulty.medium);

// User Profile State Notifier Provider
class UserProfileNotifier extends StateNotifier<UserProfile> {
  final UserRepository _userRepository;

  UserProfileNotifier(this._userRepository)
      : super(_userRepository.getUserProfile());

  Future<void> updateName(String name) async {
    await _userRepository.setStudentName(name);
    state = _userRepository.getUserProfile();
  }

  void refresh() {
    state = _userRepository.getUserProfile();
  }
}

final userProfileProvider = StateNotifierProvider<UserProfileNotifier, UserProfile>((ref) {
  final repo = ref.watch(userRepositoryProvider);
  return UserProfileNotifier(repo);
});

// Quiz History State Notifier Provider
class QuizHistoryNotifier extends StateNotifier<List<QuizSessionResult>> {
  final UserRepository _userRepository;

  QuizHistoryNotifier(this._userRepository)
      : super(_userRepository.getQuizHistory());

  void refresh() {
    state = _userRepository.getQuizHistory();
  }

  Future<void> addResult(QuizSessionResult result) async {
    await _userRepository.recordQuizSession(result);
    refresh();
  }

  Future<void> deleteResult(String id) async {
    await _userRepository.deleteQuizSession(id);
    refresh();
  }

  Future<void> clearAll() async {
    await _userRepository.clearAllQuizHistory();
    refresh();
  }
}

final quizHistoryProvider = StateNotifierProvider<QuizHistoryNotifier, List<QuizSessionResult>>((ref) {
  final repo = ref.watch(userRepositoryProvider);
  return QuizHistoryNotifier(repo);
});

// Badges Provider
final badgesProvider = Provider<List<BadgeModel>>((ref) {
  // Watch userProfile to automatically recompute badges when state changes
  ref.watch(userProfileProvider);
  final repo = ref.watch(userRepositoryProvider);
  return repo.getBadges();
});
