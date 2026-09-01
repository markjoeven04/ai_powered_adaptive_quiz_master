import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quiz_session_model.dart';
import '../models/user_profile_model.dart';

class StorageService {
  static const String _keyStudentName = 'brightspark_student_name';
  static const String _keyUserProfile = 'brightspark_user_profile';
  static const String _keyQuizHistory = 'brightspark_quiz_history';
  static const String _keyCustomApiKey = 'brightspark_custom_api_key';
  static const String _keyCustomBackupApiKey = 'brightspark_custom_backup_api_key';

  final SharedPreferences _prefs;

  StorageService(this._prefs);

  static Future<StorageService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }

  // Student Name
  String getStudentName() {
    return _prefs.getString(_keyStudentName) ?? '';
  }

  Future<void> saveStudentName(String name) async {
    await _prefs.setString(_keyStudentName, name.trim());
    final currentProfile = getUserProfile();
    await saveUserProfile(currentProfile.copyWith(name: name.trim()));
  }

  // User Profile
  UserProfile getUserProfile() {
    final raw = _prefs.getString(_keyUserProfile);
    if (raw == null || raw.isEmpty) {
      final name = getStudentName();
      return UserProfile(name: name, lastActiveDate: DateTime.now());
    }
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return UserProfile.fromJson(json);
    } catch (_) {
      return UserProfile(name: getStudentName(), lastActiveDate: DateTime.now());
    }
  }

  Future<void> saveUserProfile(UserProfile profile) async {
    await _prefs.setString(_keyUserProfile, jsonEncode(profile.toJson()));
  }

  // Quiz History
  List<QuizSessionResult> getQuizHistory() {
    final rawList = _prefs.getStringList(_keyQuizHistory) ?? [];
    return rawList.map((str) {
      try {
        return QuizSessionResult.fromJson(jsonDecode(str) as Map<String, dynamic>);
      } catch (_) {
        return null;
      }
    }).whereType<QuizSessionResult>().toList().reversed.toList();
  }

  Future<void> saveQuizSession(QuizSessionResult result) async {
    final rawList = _prefs.getStringList(_keyQuizHistory) ?? [];
    rawList.add(jsonEncode(result.toJson()));
    await _prefs.setStringList(_keyQuizHistory, rawList);

    // Update Profile Stats & Streak
    final profile = getUserProfile();
    final now = DateTime.now();
    int newStreak = profile.streakDays;

    final diffDays = now.difference(profile.lastActiveDate).inDays;
    if (diffDays == 1) {
      newStreak += 1;
    } else if (diffDays > 1) {
      newStreak = 1;
    }

    final updatedBadges = List<String>.from(profile.unlockedBadgeIds);
    if (!updatedBadges.contains('first_quiz')) {
      updatedBadges.add('first_quiz');
    }
    if (result.score >= 18 && !updatedBadges.contains('perfect_20')) {
      updatedBadges.add('perfect_20');
    }
    if (result.subject.id == 'science' && result.score >= 14 && !updatedBadges.contains('science_star')) {
      updatedBadges.add('science_star');
    }
    if (result.subject.id == 'math' && result.score >= 14 && !updatedBadges.contains('math_wizard')) {
      updatedBadges.add('math_wizard');
    }
    if (result.subject.id == 'philippine_history' && result.score >= 14 && !updatedBadges.contains('history_buff')) {
      updatedBadges.add('history_buff');
    }
    if (result.subject.id == 'english' && result.score >= 14 && !updatedBadges.contains('english_ace')) {
      updatedBadges.add('english_ace');
    }
    if (newStreak >= 3 && !updatedBadges.contains('streak_3')) {
      updatedBadges.add('streak_3');
    }

    final updatedProfile = profile.copyWith(
      totalQuizzes: profile.totalQuizzes + 1,
      totalScore: profile.totalScore + result.score,
      streakDays: newStreak,
      lastActiveDate: now,
      unlockedBadgeIds: updatedBadges,
    );

    await saveUserProfile(updatedProfile);
  }

  Future<void> deleteQuizSession(String id) async {
    final rawList = _prefs.getStringList(_keyQuizHistory) ?? [];
    final updatedList = <String>[];
    for (final str in rawList) {
      try {
        final decoded = jsonDecode(str) as Map<String, dynamic>;
        if (decoded['id'] != id) {
          updatedList.add(str);
        }
      } catch (_) {
        // Skip malformed
      }
    }
    await _prefs.setStringList(_keyQuizHistory, updatedList);

    // Recalculate Profile Stats from remaining history
    final remaining = getQuizHistory();
    int newTotalQuizzes = remaining.length;
    int newTotalScore = 0;
    for (final q in remaining) {
      newTotalScore += q.score;
    }

    final profile = getUserProfile();
    final updatedProfile = profile.copyWith(
      totalQuizzes: newTotalQuizzes,
      totalScore: newTotalScore,
    );
    await saveUserProfile(updatedProfile);
  }

  Future<void> clearAllQuizHistory() async {
    await _prefs.remove(_keyQuizHistory);
    final profile = getUserProfile();
    final updatedProfile = profile.copyWith(
      totalQuizzes: 0,
      totalScore: 0,
    );
    await saveUserProfile(updatedProfile);
  }

  // Custom API Keys
  String? getCustomApiKey() => _prefs.getString(_keyCustomApiKey);
  Future<void> saveCustomApiKey(String key) => _prefs.setString(_keyCustomApiKey, key.trim());

  String? getCustomBackupApiKey() => _prefs.getString(_keyCustomBackupApiKey);
  Future<void> saveCustomBackupApiKey(String key) => _prefs.setString(_keyCustomBackupApiKey, key.trim());
}
