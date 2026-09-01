// Example Environment Configuration Template
// Copy this file to `env_config.dart` and add your secret keys.
// `env_config.dart` is automatically ignored by .gitignore to protect your keys.

class EnvConfig {
  static const String geminiApiKey = String.fromEnvironment(
    'GEMINI_API_KEY',
    defaultValue: '',
  );

  static const String geminiBackupApiKey = String.fromEnvironment(
    'GEMINI_BACKUP_KEY',
    defaultValue: '',
  );
}
