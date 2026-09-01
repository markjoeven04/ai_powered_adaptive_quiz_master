import '../../core/models/user_profile_model.dart';
import '../../core/models/quiz_session_model.dart';
import '../../core/models/badge_model.dart';
import '../../core/services/storage_service.dart';

class UserRepository {
  final StorageService _storageService;

  UserRepository(this._storageService);

  String getStudentName() => _storageService.getStudentName();

  Future<void> setStudentName(String name) => _storageService.saveStudentName(name);

  UserProfile getUserProfile() => _storageService.getUserProfile();

  Future<void> updateUserProfile(UserProfile profile) => _storageService.saveUserProfile(profile);

  List<QuizSessionResult> getQuizHistory() => _storageService.getQuizHistory();

  Future<void> recordQuizSession(QuizSessionResult result) => _storageService.saveQuizSession(result);

  Future<void> deleteQuizSession(String id) => _storageService.deleteQuizSession(id);

  Future<void> clearAllQuizHistory() => _storageService.clearAllQuizHistory();

  List<BadgeModel> getBadges() {
    final profile = getUserProfile();
    final allBadges = BadgeModel.defaultBadges;
    return allBadges.map((b) {
      final isUnlocked = profile.unlockedBadgeIds.contains(b.id);
      return b.copyWith(isUnlocked: isUnlocked);
    }).toList();
  }
}
