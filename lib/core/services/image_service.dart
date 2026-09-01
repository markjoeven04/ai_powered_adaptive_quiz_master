class ImageService {
  /// Comprehensive, curated catalog of verified educational images for K-12 curricula
  static final Map<String, List<String>> _curatedImages = {
    // ==========================================
    // 🧬 HUMAN BODY & BIOLOGY
    // ==========================================
    'brain': [
      'https://images.unsplash.com/photo-1559757175-5700dde675bc?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1559757148-5c350d0d3c56?auto=format&fit=crop&w=800&q=80',
    ],
    'nervous': [
      'https://images.unsplash.com/photo-1559757175-5700dde675bc?auto=format&fit=crop&w=800&q=80',
    ],
    'heart': [
      'https://images.unsplash.com/photo-1530026405186-ed1f139313f8?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1628348068343-c6a848d2b6dd?auto=format&fit=crop&w=800&q=80',
    ],
    'cardio': [
      'https://images.unsplash.com/photo-1530026405186-ed1f139313f8?auto=format&fit=crop&w=800&q=80',
    ],
    'circulatory': [
      'https://images.unsplash.com/photo-1530026405186-ed1f139313f8?auto=format&fit=crop&w=800&q=80',
    ],
    'blood': [
      'https://images.unsplash.com/photo-1615461066841-6116e61058f4?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1582719471384-894fbb16e074?auto=format&fit=crop&w=800&q=80',
    ],
    'lungs': [
      'https://images.unsplash.com/photo-1584515979956-d9f6e5d09982?auto=format&fit=crop&w=800&q=80',
    ],
    'respiratory': [
      'https://images.unsplash.com/photo-1584515979956-d9f6e5d09982?auto=format&fit=crop&w=800&q=80',
    ],
    'skeleton': [
      'https://images.unsplash.com/photo-1530497610245-94d3c16cda28?auto=format&fit=crop&w=800&q=80',
    ],
    'bone': [
      'https://images.unsplash.com/photo-1530497610245-94d3c16cda28?auto=format&fit=crop&w=800&q=80',
    ],
    'cell': [
      'https://images.unsplash.com/photo-1576086213369-97a306d36557?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?auto=format&fit=crop&w=800&q=80',
    ],
    'dna': [
      'https://images.unsplash.com/photo-1530497610245-94d3c16cda28?auto=format&fit=crop&w=800&q=80',
    ],
    'genetics': [
      'https://images.unsplash.com/photo-1530497610245-94d3c16cda28?auto=format&fit=crop&w=800&q=80',
    ],
    'microscope': [
      'https://images.unsplash.com/photo-1576086213369-97a306d36557?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1581093458791-9f3c3900df4b?auto=format&fit=crop&w=800&q=80',
    ],
    'health': [
      'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&w=800&q=80',
    ],
    'nutrition': [
      'https://images.unsplash.com/photo-1498837167922-ddd27525d352?auto=format&fit=crop&w=800&q=80',
    ],
    'food': [
      'https://images.unsplash.com/photo-1498837167922-ddd27525d352?auto=format&fit=crop&w=800&q=80',
    ],

    // ==========================================
    // 🌿 BOTANY, ZOOLOGY & ECOLOGY
    // ==========================================
    'plant': [
      'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?auto=format&fit=crop&w=800&q=80',
    ],
    'photosynthesis': [
      'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1448375240586-882707db888b?auto=format&fit=crop&w=800&q=80',
    ],
    'flower': [
      'https://images.unsplash.com/photo-1490750967868-88aa4486c946?auto=format&fit=crop&w=800&q=80',
    ],
    'tree': [
      'https://images.unsplash.com/photo-1448375240586-882707db888b?auto=format&fit=crop&w=800&q=80',
    ],
    'forest': [
      'https://images.unsplash.com/photo-1448375240586-882707db888b?auto=format&fit=crop&w=800&q=80',
    ],
    'animal': [
      'https://images.unsplash.com/photo-1474511320723-9a56873867b5?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1437622368342-7a3d73a34c8f?auto=format&fit=crop&w=800&q=80',
    ],
    'bird': [
      'https://images.unsplash.com/photo-1444464666168-49d633b86797?auto=format&fit=crop&w=800&q=80',
    ],
    'eagle': [
      'https://images.unsplash.com/photo-1611689342806-0863700ce1e4?auto=format&fit=crop&w=800&q=80',
    ],
    'butterfly': [
      'https://images.unsplash.com/photo-1558980394-0a06c4631733?auto=format&fit=crop&w=800&q=80',
    ],
    'insect': [
      'https://images.unsplash.com/photo-1558980394-0a06c4631733?auto=format&fit=crop&w=800&q=80',
    ],
    'ocean': [
      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1544551763-46a013bb70d5?auto=format&fit=crop&w=800&q=80',
    ],
    'marine': [
      'https://images.unsplash.com/photo-1544551763-46a013bb70d5?auto=format&fit=crop&w=800&q=80',
    ],
    'fish': [
      'https://images.unsplash.com/photo-1522069169874-c58ec4b76be5?auto=format&fit=crop&w=800&q=80',
    ],
    'ecosystem': [
      'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?auto=format&fit=crop&w=800&q=80',
    ],
    'food chain': [
      'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?auto=format&fit=crop&w=800&q=80',
    ],

    // ==========================================
    // 🪐 EARTH & SPACE SCIENCES
    // ==========================================
    'solar system': [
      'https://images.unsplash.com/photo-1614728894747-a83421e2b9c9?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&w=800&q=80',
    ],
    'planet': [
      'https://images.unsplash.com/photo-1614728894747-a83421e2b9c9?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1614728423169-3f65fd722b7e?auto=format&fit=crop&w=800&q=80',
    ],
    'sun': [
      'https://images.unsplash.com/photo-1532978379173-523e16f371f2?auto=format&fit=crop&w=800&q=80',
    ],
    'moon': [
      'https://images.unsplash.com/photo-1522030299830-16b8d3d049fe?auto=format&fit=crop&w=800&q=80',
    ],
    'space': [
      'https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1506703719100-a0f3a48c0f86?auto=format&fit=crop&w=800&q=80',
    ],
    'stars': [
      'https://images.unsplash.com/photo-1506703719100-a0f3a48c0f86?auto=format&fit=crop&w=800&q=80',
    ],
    'telescope': [
      'https://images.unsplash.com/photo-1506703719100-a0f3a48c0f86?auto=format&fit=crop&w=800&q=80',
    ],
    'volcano': [
      'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
    ],
    'earthquake': [
      'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=800&q=80',
    ],
    'rocks': [
      'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=800&q=80',
    ],
    'weather': [
      'https://images.unsplash.com/photo-1534088568595-a066f410bcda?auto=format&fit=crop&w=800&q=80',
    ],
    'rain': [
      'https://images.unsplash.com/photo-1515694346937-94d85e41e6f0?auto=format&fit=crop&w=800&q=80',
    ],
    'water cycle': [
      'https://images.unsplash.com/photo-1515694346937-94d85e41e6f0?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=800&q=80',
    ],

    // ==========================================
    // ⚡ PHYSICS & CHEMISTRY
    // ==========================================
    'chemistry': [
      'https://images.unsplash.com/photo-1532094349884-543bc11b234d?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1507668077129-56e32842fceb?auto=format&fit=crop&w=800&q=80',
    ],
    'laboratory': [
      'https://images.unsplash.com/photo-1532094349884-543bc11b234d?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1581093458791-9f3c3900df4b?auto=format&fit=crop&w=800&q=80',
    ],
    'atom': [
      'https://images.unsplash.com/photo-1507413245164-6160d8298b31?auto=format&fit=crop&w=800&q=80',
    ],
    'electricity': [
      'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1509228468518-180dd4864904?auto=format&fit=crop&w=800&q=80',
    ],
    'circuits': [
      'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=800&q=80',
    ],
    'light': [
      'https://images.unsplash.com/photo-1507668077129-56e32842fceb?auto=format&fit=crop&w=800&q=80',
    ],
    'magnet': [
      'https://images.unsplash.com/photo-1636466497217-26a8cbeaf0aa?auto=format&fit=crop&w=800&q=80',
    ],
    'gravity': [
      'https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&w=800&q=80',
    ],
    'force': [
      'https://images.unsplash.com/photo-1636466497217-26a8cbeaf0aa?auto=format&fit=crop&w=800&q=80',
    ],
    'energy': [
      'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=800&q=80',
    ],
    'motion': [
      'https://images.unsplash.com/photo-1636466497217-26a8cbeaf0aa?auto=format&fit=crop&w=800&q=80',
    ],

    // ==========================================
    // 📐 MATHEMATICS
    // ==========================================
    'math': [
      'https://images.unsplash.com/photo-1509228468518-180dd4864904?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1635070041078-e363dbe005cb?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1596495578065-6e0763fa1178?auto=format&fit=crop&w=800&q=80',
    ],
    'numbers': [
      'https://images.unsplash.com/photo-1596495578065-6e0763fa1178?auto=format&fit=crop&w=800&q=80',
    ],
    'fraction': [
      'https://images.unsplash.com/photo-1509228468518-180dd4864904?auto=format&fit=crop&w=800&q=80',
    ],
    'geometry': [
      'https://images.unsplash.com/photo-1509228468518-180dd4864904?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1596495578065-6e0763fa1178?auto=format&fit=crop&w=800&q=80',
    ],
    'shapes': [
      'https://images.unsplash.com/photo-1509228468518-180dd4864904?auto=format&fit=crop&w=800&q=80',
    ],
    'triangle': [
      'https://images.unsplash.com/photo-1509228468518-180dd4864904?auto=format&fit=crop&w=800&q=80',
    ],
    'algebra': [
      'https://images.unsplash.com/photo-1635070041078-e363dbe005cb?auto=format&fit=crop&w=800&q=80',
    ],
    'equation': [
      'https://images.unsplash.com/photo-1635070041078-e363dbe005cb?auto=format&fit=crop&w=800&q=80',
    ],
    'graph': [
      'https://images.unsplash.com/photo-1551288049-bebda4e38f71?auto=format&fit=crop&w=800&q=80',
    ],
    'statistics': [
      'https://images.unsplash.com/photo-1551288049-bebda4e38f71?auto=format&fit=crop&w=800&q=80',
    ],
    'measurement': [
      'https://images.unsplash.com/photo-1588600878108-578307a3cc9d?auto=format&fit=crop&w=800&q=80',
    ],
    'ruler': [
      'https://images.unsplash.com/photo-1588600878108-578307a3cc9d?auto=format&fit=crop&w=800&q=80',
    ],
    'clock': [
      'https://images.unsplash.com/photo-1508057198894-247b23fe5ade?auto=format&fit=crop&w=800&q=80',
    ],
    'time': [
      'https://images.unsplash.com/photo-1508057198894-247b23fe5ade?auto=format&fit=crop&w=800&q=80',
    ],
    'money': [
      'https://images.unsplash.com/photo-1559526324-4b87b5e36e44?auto=format&fit=crop&w=800&q=80',
    ],

    // ==========================================
    // 🇵🇭 PHILIPPINE HISTORY & CULTURE
    // ==========================================
    'philippines': [
      'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1461360370896-922624d12aa1?auto=format&fit=crop&w=800&q=80',
    ],
    'history': [
      'https://images.unsplash.com/photo-1461360370896-922624d12aa1?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=800&q=80',
    ],
    'rizal': [
      'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1461360370896-922624d12aa1?auto=format&fit=crop&w=800&q=80',
    ],
    'hero': [
      'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?auto=format&fit=crop&w=800&q=80',
    ],
    'revolution': [
      'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1461360370896-922624d12aa1?auto=format&fit=crop&w=800&q=80',
    ],
    'katipunan': [
      'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=800&q=80',
    ],
    'flag': [
      'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?auto=format&fit=crop&w=800&q=80',
    ],
    'intramuros': [
      'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?auto=format&fit=crop&w=800&q=80',
    ],
    'manila': [
      'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?auto=format&fit=crop&w=800&q=80',
    ],
    'rice terraces': [
      'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=800&q=80',
    ],
    'banaue': [
      'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=800&q=80',
    ],
    'mayon': [
      'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=800&q=80',
    ],
    'jeepney': [
      'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?auto=format&fit=crop&w=800&q=80',
    ],

    // ==========================================
    // 📖 ENGLISH & LANGUAGE ARTS
    // ==========================================
    'reading': [
      'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?auto=format&fit=crop&w=800&q=80',
    ],
    'book': [
      'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=800&q=80',
    ],
    'literature': [
      'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=800&q=80',
    ],
    'grammar': [
      'https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?auto=format&fit=crop&w=800&q=80',
    ],
    'noun': [
      'https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?auto=format&fit=crop&w=800&q=80',
    ],
    'verb': [
      'https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?auto=format&fit=crop&w=800&q=80',
    ],
    'writing': [
      'https://images.unsplash.com/photo-1455390582262-044cdead277a?auto=format&fit=crop&w=800&q=80',
    ],
    'poetry': [
      'https://images.unsplash.com/photo-1455390582262-044cdead277a?auto=format&fit=crop&w=800&q=80',
    ],
    'story': [
      'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=800&q=80',
    ],
    'vocabulary': [
      'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=800&q=80',
    ],
    'alphabet': [
      'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=800&q=80',
    ],
  };

  /// Returns a prioritized list of educational photo URLs with smart semantic analysis of prompt
  static List<String> getEducationalImageUrls(
    String? keyword,
    String subject, {
    String? questionPrompt,
  }) {
    final results = <String>[];

    // 1. Direct Keyword Match
    if (keyword != null && keyword.isNotEmpty) {
      final key = keyword.toLowerCase().trim();

      if (_curatedImages.containsKey(key)) {
        results.addAll(_curatedImages[key]!);
      }

      if (results.isEmpty) {
        for (final entry in _curatedImages.entries) {
          if (key.contains(entry.key) || entry.key.contains(key)) {
            results.addAll(entry.value);
            break;
          }
        }
      }
    }

    // 2. Semantic Extraction from Question Prompt Text
    if (results.isEmpty && questionPrompt != null && questionPrompt.isNotEmpty) {
      final cleanPrompt = questionPrompt.toLowerCase();

      for (final entry in _curatedImages.entries) {
        // Look for exact word matches in prompt
        final pattern = RegExp('\\b${RegExp.escape(entry.key)}\\b');
        if (pattern.hasMatch(cleanPrompt)) {
          results.addAll(entry.value);
          break;
        }
      }
    }

    // 3. Smart Subject Sub-Category Fallback
    final subjectFallbacks = _getSubjectFallbacks(subject, questionPrompt);
    for (final url in subjectFallbacks) {
      if (!results.contains(url)) {
        results.add(url);
      }
    }

    return results;
  }

  static List<String> _getSubjectFallbacks(String subject, String? prompt) {
    final cleanSubject = subject.toLowerCase();
    final cleanPrompt = (prompt ?? '').toLowerCase();

    if (cleanSubject.contains('science')) {
      if (cleanPrompt.contains('plant') || cleanPrompt.contains('leaf') || cleanPrompt.contains('tree') || cleanPrompt.contains('photo')) {
        return _curatedImages['plant']!;
      }
      if (cleanPrompt.contains('animal') || cleanPrompt.contains('bird') || cleanPrompt.contains('fish') || cleanPrompt.contains('dog')) {
        return _curatedImages['animal']!;
      }
      if (cleanPrompt.contains('heart') || cleanPrompt.contains('brain') || cleanPrompt.contains('body') || cleanPrompt.contains('organ')) {
        return _curatedImages['heart']!;
      }
      if (cleanPrompt.contains('volcano') || cleanPrompt.contains('rock') || cleanPrompt.contains('earth')) {
        return _curatedImages['volcano']!;
      }
      if (cleanPrompt.contains('electric') || cleanPrompt.contains('magnet') || cleanPrompt.contains('light') || cleanPrompt.contains('force')) {
        return _curatedImages['electricity']!;
      }
      return _curatedImages['solar system']!;
    }

    if (cleanSubject.contains('math')) {
      if (cleanPrompt.contains('shape') || cleanPrompt.contains('triangle') || cleanPrompt.contains('angle') || cleanPrompt.contains('circle')) {
        return _curatedImages['geometry']!;
      }
      if (cleanPrompt.contains('x') || cleanPrompt.contains('equation') || cleanPrompt.contains('algebra')) {
        return _curatedImages['algebra']!;
      }
      if (cleanPrompt.contains('graph') || cleanPrompt.contains('chart') || cleanPrompt.contains('percent')) {
        return _curatedImages['graph']!;
      }
      return _curatedImages['math']!;
    }

    if (cleanSubject.contains('history') || cleanSubject.contains('philippine')) {
      if (cleanPrompt.contains('rizal') || cleanPrompt.contains('hero') || cleanPrompt.contains('monument')) {
        return _curatedImages['rizal']!;
      }
      if (cleanPrompt.contains('revolution') || cleanPrompt.contains('katipunan') || cleanPrompt.contains('bonifacio') || cleanPrompt.contains('war')) {
        return _curatedImages['revolution']!;
      }
      return _curatedImages['philippines']!;
    }

    // Default English & Language Arts
    if (cleanPrompt.contains('grammar') || cleanPrompt.contains('verb') || cleanPrompt.contains('noun') || cleanPrompt.contains('word')) {
      return _curatedImages['grammar']!;
    }
    return _curatedImages['reading']!;
  }

  /// Convenience method returning primary image URL
  static String getEducationalImageUrl(String? keyword, String subject, {String? questionPrompt}) {
    final list = getEducationalImageUrls(keyword, subject, questionPrompt: questionPrompt);
    return list.isNotEmpty
        ? list.first
        : 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&w=800&q=80';
  }
}
