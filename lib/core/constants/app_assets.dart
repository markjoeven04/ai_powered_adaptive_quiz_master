class AppAssets {
  static const String logoSpark = 'assets/images/logo_spark.png';
  static const String mascotRobot = 'assets/images/mascot_poses/pose_2.png';
  static const String mascotCelebration = 'assets/images/mascot_celebration.png';
  static const String levelIllustration = 'assets/images/level_mockup.png';
  static const String difficultyIllustration = 'assets/images/difficulty_mockup.png';
  static const String quizIllustration = 'assets/images/quiz_mockup.png';

  static String getMascotPose(int index) {
    final poseNumber = (index % 30) + 1;
    return 'assets/images/mascot_poses/pose_$poseNumber.png';
  }
}
