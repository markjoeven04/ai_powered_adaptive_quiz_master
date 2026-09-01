class ImageService {
  /// Comprehensive, curated catalog of verified educational images for K-12 curricula
  static final Map<String, List<String>> _curatedImages = {
    // ==========================================
    // 🇵🇭 PHILIPPINE HISTORY, SYMBOLS & CULTURE
    // ==========================================
    'philippine flag': [
      'https://images.unsplash.com/photo-1580137189272-c9379f8864fd?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?auto=format&fit=crop&w=800&q=80',
    ],
    'flag': [
      'https://images.unsplash.com/photo-1580137189272-c9379f8864fd?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?auto=format&fit=crop&w=800&q=80',
    ],
    'philippine eagle': [
      'https://images.unsplash.com/photo-1611689342806-0863700ce1e4?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1444464666168-49d633b86797?auto=format&fit=crop&w=800&q=80',
    ],
    'carabao': [
      'https://images.unsplash.com/photo-1570042225831-d98fa7577f1e?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1546445317-29f4545e9d53?auto=format&fit=crop&w=800&q=80',
    ],
    'jose rizal': [
      'https://images.unsplash.com/photo-1461360370896-922624d12aa1?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?auto=format&fit=crop&w=800&q=80',
    ],
    'rizal': [
      'https://images.unsplash.com/photo-1461360370896-922624d12aa1?auto=format&fit=crop&w=800&q=80',
    ],
    'hero': [
      'https://images.unsplash.com/photo-1461360370896-922624d12aa1?auto=format&fit=crop&w=800&q=80',
    ],
    'lapu lapu': [
      'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?auto=format&fit=crop&w=800&q=80',
    ],
    'katipunan': [
      'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=800&q=80',
    ],
    'revolution': [
      'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=800&q=80',
    ],
    'philippines': [
      'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=800&q=80',
    ],
    'manila': [
      'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?auto=format&fit=crop&w=800&q=80',
    ],
    'cavite': [
      'https://images.unsplash.com/photo-1580137189272-c9379f8864fd?auto=format&fit=crop&w=800&q=80',
    ],
    'history': [
      'https://images.unsplash.com/photo-1461360370896-922624d12aa1?auto=format&fit=crop&w=800&q=80',
    ],
    'firefighter': [
      'https://images.unsplash.com/photo-1582139329536-e7284fece509?auto=format&fit=crop&w=800&q=80',
    ],
    'teacher': [
      'https://images.unsplash.com/photo-1580582932707-520aed937b7b?auto=format&fit=crop&w=800&q=80',
    ],
    'doctor': [
      'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&w=800&q=80',
    ],
    'president': [
      'https://images.unsplash.com/photo-1461360370896-922624d12aa1?auto=format&fit=crop&w=800&q=80',
    ],

    // ==========================================
    // 🧬 HUMAN SENSES & BODY ORGANS
    // ==========================================
    'eye': [
      'https://images.unsplash.com/photo-1516715094483-75da7dee9758?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1574701148212-8518049c7b2c?auto=format&fit=crop&w=800&q=80',
    ],
    'eyes': [
      'https://images.unsplash.com/photo-1516715094483-75da7dee9758?auto=format&fit=crop&w=800&q=80',
    ],
    'hearing': [
      'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=800&q=80',
    ],
    'ear': [
      'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=800&q=80',
    ],
    'heart': [
      'https://images.unsplash.com/photo-1530026405186-ed1f139313f8?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1628348068343-c6a848d2b6dd?auto=format&fit=crop&w=800&q=80',
    ],
    'brain': [
      'https://images.unsplash.com/photo-1559757175-5700dde675bc?auto=format&fit=crop&w=800&q=80',
    ],
    'lungs': [
      'https://images.unsplash.com/photo-1584515979956-d9f6e5d09982?auto=format&fit=crop&w=800&q=80',
    ],
    'stomach': [
      'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&w=800&q=80',
    ],
    'digestion': [
      'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&w=800&q=80',
    ],
    'cell': [
      'https://images.unsplash.com/photo-1576086213369-97a306d36557?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?auto=format&fit=crop&w=800&q=80',
    ],
    'dna': [
      'https://images.unsplash.com/photo-1530497610245-94d3c16cda28?auto=format&fit=crop&w=800&q=80',
    ],

    // ==========================================
    // 🌿 BOTANY, ZOOLOGY & NATURE
    // ==========================================
    'plant': [
      'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?auto=format&fit=crop&w=800&q=80',
    ],
    'leaf': [
      'https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?auto=format&fit=crop&w=800&q=80',
    ],
    'flower': [
      'https://images.unsplash.com/photo-1490750967868-88aa4486c946?auto=format&fit=crop&w=800&q=80',
    ],
    'dog': [
      'https://images.unsplash.com/photo-1543466835-00a7907e9de1?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1587300003388-59208cc962cb?auto=format&fit=crop&w=800&q=80',
    ],
    'puppy': [
      'https://images.unsplash.com/photo-1543466835-00a7907e9de1?auto=format&fit=crop&w=800&q=80',
    ],
    'animal': [
      'https://images.unsplash.com/photo-1474511320723-9a56873867b5?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1543466835-00a7907e9de1?auto=format&fit=crop&w=800&q=80',
    ],
    'mammal': [
      'https://images.unsplash.com/photo-1474511320723-9a56873867b5?auto=format&fit=crop&w=800&q=80',
    ],
    'bird': [
      'https://images.unsplash.com/photo-1444464666168-49d633b86797?auto=format&fit=crop&w=800&q=80',
    ],
    'butterfly': [
      'https://images.unsplash.com/photo-1558980394-0a06c4631733?auto=format&fit=crop&w=800&q=80',
    ],
    'fish': [
      'https://images.unsplash.com/photo-1522069169874-c58ec4b76be5?auto=format&fit=crop&w=800&q=80',
    ],
    'ocean': [
      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=800&q=80',
    ],
    'water': [
      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=800&q=80',
    ],

    // ==========================================
    // ☀️ EARTH & WEATHER
    // ==========================================
    'sun': [
      'https://images.unsplash.com/photo-1617155093730-a8bf47be792d?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1534088568595-a066f410bcda?auto=format&fit=crop&w=800&q=80',
    ],
    'rain': [
      'https://images.unsplash.com/photo-1515694346937-94d85e41e6f0?auto=format&fit=crop&w=800&q=80',
    ],
    'weather': [
      'https://images.unsplash.com/photo-1534088568595-a066f410bcda?auto=format&fit=crop&w=800&q=80',
    ],
    'ice': [
      'https://images.unsplash.com/photo-1491555103944-7c647fd857e6?auto=format&fit=crop&w=800&q=80',
    ],
    'volcano': [
      'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=800&q=80',
    ],
    'water cycle': [
      'https://images.unsplash.com/photo-1534088568595-a066f410bcda?auto=format&fit=crop&w=800&q=80',
    ],
    'geology': [
      'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=800&q=80',
    ],

    // ==========================================
    // 🪐 SPACE & PHYSICS
    // ==========================================
    'solar system': [
      'https://images.unsplash.com/photo-1614728894747-a83421e2b9c9?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&w=800&q=80',
    ],
    'jupiter': [
      'https://images.unsplash.com/photo-1614728894747-a83421e2b9c9?auto=format&fit=crop&w=800&q=80',
    ],
    'space': [
      'https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&w=800&q=80',
    ],
    'gravity': [
      'https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&w=800&q=80',
    ],
    'pulley': [
      'https://images.unsplash.com/photo-1581092160607-ee22621dd758?auto=format&fit=crop&w=800&q=80',
    ],
    'magnet': [
      'https://images.unsplash.com/photo-1581092160607-ee22621dd758?auto=format&fit=crop&w=800&q=80',
    ],
    'chemistry': [
      'https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?auto=format&fit=crop&w=800&q=80',
    ],

    // ==========================================
    // 📐 MATHEMATICS
    // ==========================================
    'math': [
      'https://images.unsplash.com/photo-1509228468518-180dd4864904?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1596495578065-6e0763fa1178?auto=format&fit=crop&w=800&q=80',
    ],
    'numbers': [
      'https://images.unsplash.com/photo-1596495578065-6e0763fa1178?auto=format&fit=crop&w=800&q=80',
    ],
    'apple': [
      'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?auto=format&fit=crop&w=800&q=80',
    ],
    'triangle': [
      'https://images.unsplash.com/photo-1509228468518-180dd4864904?auto=format&fit=crop&w=800&q=80',
    ],
    'circle': [
      'https://images.unsplash.com/photo-1509228468518-180dd4864904?auto=format&fit=crop&w=800&q=80',
    ],
    'calendar': [
      'https://images.unsplash.com/photo-1506784983877-45594efa4cbe?auto=format&fit=crop&w=800&q=80',
    ],
    'fraction': [
      'https://images.unsplash.com/photo-1509228468518-180dd4864904?auto=format&fit=crop&w=800&q=80',
    ],
    'geometry': [
      'https://images.unsplash.com/photo-1509228468518-180dd4864904?auto=format&fit=crop&w=800&q=80',
    ],
    'multiplication': [
      'https://images.unsplash.com/photo-1509228468518-180dd4864904?auto=format&fit=crop&w=800&q=80',
    ],
    'division': [
      'https://images.unsplash.com/photo-1509228468518-180dd4864904?auto=format&fit=crop&w=800&q=80',
    ],
    'algebra': [
      'https://images.unsplash.com/photo-1635070041078-e363dbe005cb?auto=format&fit=crop&w=800&q=80',
    ],
    'angle': [
      'https://images.unsplash.com/photo-1509228468518-180dd4864904?auto=format&fit=crop&w=800&q=80',
    ],

    // ==========================================
    // 📖 ENGLISH & READING
    // ==========================================
    'reading': [
      'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=800&q=80',
      'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=800&q=80',
    ],
    'book': [
      'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=800&q=80',
    ],
    'school': [
      'https://images.unsplash.com/photo-1580582932707-520aed937b7b?auto=format&fit=crop&w=800&q=80',
    ],
    'running': [
      'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&w=800&q=80',
    ],
    'grammar': [
      'https://images.unsplash.com/photo-1455390582262-044cdead277a?auto=format&fit=crop&w=800&q=80',
    ],
    'happy': [
      'https://images.unsplash.com/photo-1498837167922-ddd27525d352?auto=format&fit=crop&w=800&q=80',
    ],
    'student': [
      'https://images.unsplash.com/photo-1580582932707-520aed937b7b?auto=format&fit=crop&w=800&q=80',
    ],
    'poetry': [
      'https://images.unsplash.com/photo-1455390582262-044cdead277a?auto=format&fit=crop&w=800&q=80',
    ],
    'writing': [
      'https://images.unsplash.com/photo-1455390582262-044cdead277a?auto=format&fit=crop&w=800&q=80',
    ],
  };

  /// Returns a curated, educational list of image URLs matching the subject and question context
  static List<String> getEducationalImageUrls(
    String? keyword,
    String subject, {
    String? questionPrompt,
  }) {
    final results = <String>[];
    final cleanSubject = subject.toLowerCase().trim();
    final cleanPrompt = (questionPrompt ?? '').toLowerCase().trim();

    // 1. Contextual Subject-Specific Priority Overrides
    if (cleanSubject.contains('history') || cleanSubject.contains('philippine')) {
      if (cleanPrompt.contains('flag') || cleanPrompt.contains('sun in the philippine flag') || cleanPrompt.contains('rays')) {
        return List.from(_curatedImages['philippine flag']!);
      }
      if (cleanPrompt.contains('eagle') || cleanPrompt.contains('haribon') || cleanPrompt.contains('national bird')) {
        return List.from(_curatedImages['philippine eagle']!);
      }
      if (cleanPrompt.contains('carabao') || cleanPrompt.contains('kalabaw') || cleanPrompt.contains('national animal')) {
        return List.from(_curatedImages['carabao']!);
      }
      if (cleanPrompt.contains('rizal') || cleanPrompt.contains('national hero') || cleanPrompt.contains('noli')) {
        return List.from(_curatedImages['jose rizal']!);
      }
      if (cleanPrompt.contains('lapu') || cleanPrompt.contains('mactan') || cleanPrompt.contains('magellan')) {
        return List.from(_curatedImages['lapu lapu']!);
      }
      if (cleanPrompt.contains('katipunan') || cleanPrompt.contains('bonifacio') || cleanPrompt.contains('kkk')) {
        return List.from(_curatedImages['katipunan']!);
      }
      if (cleanPrompt.contains('firefighter') || cleanPrompt.contains('fire')) {
        return List.from(_curatedImages['firefighter']!);
      }
      if (cleanPrompt.contains('teacher') || cleanPrompt.contains('school')) {
        return List.from(_curatedImages['teacher']!);
      }
    }

    // 2. Direct Keyword Match
    if (keyword != null && keyword.isNotEmpty) {
      final key = keyword.toLowerCase().trim();

      if (_curatedImages.containsKey(key)) {
        results.addAll(_curatedImages[key]!);
      } else {
        for (final entry in _curatedImages.entries) {
          if (key.contains(entry.key) || entry.key.contains(key)) {
            results.addAll(entry.value);
            break;
          }
        }
      }
    }

    // 3. Semantic Extraction from Question Prompt Text
    if (results.isEmpty && cleanPrompt.isNotEmpty) {
      for (final entry in _curatedImages.entries) {
        final pattern = RegExp('\\b${RegExp.escape(entry.key)}\\b');
        if (pattern.hasMatch(cleanPrompt)) {
          results.addAll(entry.value);
          break;
        }
      }
    }

    // 4. Smart Subject Sub-Category Fallback
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
      if (cleanPrompt.contains('plant') || cleanPrompt.contains('leaf') || cleanPrompt.contains('tree') || cleanPrompt.contains('flower') || cleanPrompt.contains('root')) {
        return _curatedImages['plant']!;
      }
      if (cleanPrompt.contains('dog') || cleanPrompt.contains('puppy') || cleanPrompt.contains('animal') || cleanPrompt.contains('bird') || cleanPrompt.contains('fish')) {
        return _curatedImages['animal']!;
      }
      if (cleanPrompt.contains('eye') || cleanPrompt.contains('ear') || cleanPrompt.contains('hear') || cleanPrompt.contains('see')) {
        return _curatedImages['eye']!;
      }
      if (cleanPrompt.contains('heart') || cleanPrompt.contains('brain') || cleanPrompt.contains('stomach') || cleanPrompt.contains('lungs')) {
        return _curatedImages['heart']!;
      }
      if (cleanPrompt.contains('sun') || cleanPrompt.contains('light') || cleanPrompt.contains('day')) {
        return _curatedImages['sun']!;
      }
      if (cleanPrompt.contains('rain') || cleanPrompt.contains('weather') || cleanPrompt.contains('umbrella')) {
        return _curatedImages['rain']!;
      }
      if (cleanPrompt.contains('volcano') || cleanPrompt.contains('rock') || cleanPrompt.contains('earth')) {
        return _curatedImages['volcano']!;
      }
      return _curatedImages['plant']!;
    }

    if (cleanSubject.contains('math')) {
      if (cleanPrompt.contains('triangle')) return _curatedImages['triangle']!;
      if (cleanPrompt.contains('circle') || cleanPrompt.contains('round')) return _curatedImages['circle']!;
      if (cleanPrompt.contains('apple') || cleanPrompt.contains('fruit')) return _curatedImages['apple']!;
      if (cleanPrompt.contains('day') || cleanPrompt.contains('week') || cleanPrompt.contains('calendar')) return _curatedImages['calendar']!;
      if (cleanPrompt.contains('algebra') || cleanPrompt.contains('equation')) return _curatedImages['algebra']!;
      return _curatedImages['math']!;
    }

    if (cleanSubject.contains('history') || cleanSubject.contains('philippine')) {
      return _curatedImages['philippine flag']!;
    }

    // Default English
    if (cleanPrompt.contains('run') || cleanPrompt.contains('verb')) return _curatedImages['running']!;
    if (cleanPrompt.contains('school') || cleanPrompt.contains('noun')) return _curatedImages['school']!;
    return _curatedImages['reading']!;
  }

  /// Convenience method returning primary image URL
  static String getEducationalImageUrl(String? keyword, String subject, {String? questionPrompt}) {
    final list = getEducationalImageUrls(keyword, subject, questionPrompt: questionPrompt);
    return list.isNotEmpty
        ? list.first
        : 'https://images.unsplash.com/photo-1580137189272-c9379f8864fd?auto=format&fit=crop&w=800&q=80';
  }
}
