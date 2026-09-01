/// Production-Grade Educational Visual Asset Resolution Service.
///
/// Features:
/// - Lightweight ID-based asset indexing (Zero string bloat)
/// - Multi-keyword synonym clustering
/// - Multi-CDN resilient failover pipeline (FlagCDN, Unsplash, Flagpedia)
/// - High-level NLP phrase and prompt token matcher
class ImageService {
  static const String _unsplashBase = 'https://images.unsplash.com/photo-';
  static const String _unsplashParams = '?auto=format&fit=crop&w=800&q=80';

  /// Compact concept-to-asset registry
  /// Format: Keys are comma-separated keyword synonyms -> Values are concise Asset IDs
  static final Map<String, List<String>> _conceptRegistry = {
    // 🇵🇭 PHILIPPINE HISTORY, CULTURE & GEOGRAPHY
    'philippine flag,flag,watawat,bandila': ['flag:ph', 'flagpedia:ph', 'flag_sm:ph'],
    'hero,national hero,jose rizal,rizal,dr jose rizal': ['1461360370896-922624d12aa1', 'flag:ph', '1544716278-ca5e3f4abd8c'],
    'andres bonifacio,bonifacio,katipunan,kkk,revolution': ['1544716278-ca5e3f4abd8c', 'flag:ph', '1461360370896-922624d12aa1'],
    'lapu lapu,lapulapu,mactan,battle of mactan': ['flag:ph', '1461360370896-922624d12aa1', '1507525428034-b723cf961d3e'],
    'emilio aguinaldo,aguinaldo,antonio luna,luna': ['flag:ph', '1461360370896-922624d12aa1', '1544716278-ca5e3f4abd8c'],
    'melchora aquino,tandang sora,gabriela silang': ['1544716278-ca5e3f4abd8c', 'flag:ph', '1461360370896-922624d12aa1'],
    'apolinario mabini,mabini,quezon,manuel quezon': ['1461360370896-922624d12aa1', 'flag:ph', '1544716278-ca5e3f4abd8c'],
    'philippine eagle,eagle,haribon,agila': ['1611689342806-0863700ce1e4', '1444464666168-49d633b86797', '1516715094483-75da7dee9758'],
    'carabao,kalabaw,tamaraw': ['1570042225831-d98fa7577f1e', '1546445317-29f4545e9d53', '1474511320723-9a56873867b5'],
    'tarsier,monkey': ['1543466835-00a7907e9de1', '1518531933037-91b2f5f229cc', '1474511320723-9a56873867b5'],
    'whale shark,butanding': ['1522069169874-c58ec4b76be5', '1507525428034-b723cf961d3e', '1470071459604-3b5ec3a7fe05'],
    'mango,mangga': ['1553279768-865429fa0078', '1560806887-1e4cd0b6cbd6', '1570913149827-d2ac84ab3f9a'],
    'sampaguita,jasmine,narra,nara,pearl': ['1490750967868-88aa4486c946', '1518531933037-91b2f5f229cc', '1501004318641-b39e6451bec6'],
    'arnis,tinikling,carinosa,barong,barot saya': ['1498837167922-ddd27525d352', 'flag:ph', '1503676260728-1c00da094a0b'],
    'bahay kubo,nipa hut,banca,vinta,kalesa,jeepney,tricycle': ['1518531933037-91b2f5f229cc', '1501004318641-b39e6451bec6', 'flag:ph'],
    'manila,cavite,intramuros,rizal park,luneta,fort santiago,malacanang,vigan,corregidor': ['flag:ph', '1544716278-ca5e3f4abd8c', '1461360370896-922624d12aa1'],
    'banaue,rice terraces,chocolate hills,bohol,mount apo,baguio': ['1470071459604-3b5ec3a7fe05', '1518531933037-91b2f5f229cc', 'flag:ph'],
    'mayon,mayon volcano,taal,taal volcano': ['1464822759023-fed622ff2c3b', '1470071459604-3b5ec3a7fe05', 'flag:ph'],
    'boracay,palawan,underground river,puerto princesa,siargao,batanes,cebu,davao': ['1507525428034-b723cf961d3e', 'flag:ph', '1522069169874-c58ec4b76be5'],
    'luzon,visayas,mindanao,pacific ocean,south china sea,west philippine sea': ['flag:ph', '1507525428034-b723cf961d3e', '1448375240586-882707db888b'],
    'president,independence,june 12,edsa,treaty of paris,spanish,galleon,barter,datus,datu,barangay': ['flag:ph', '1544716278-ca5e3f4abd8c', '1461360370896-922624d12aa1'],
    'farmer,fisherman': ['1570042225831-d98fa7577f1e', '1501004318641-b39e6451bec6', '1470071459604-3b5ec3a7fe05'],
    'firefighter,police': ['1582139329536-e7284fece509', '1579783900882-c0d3dad7b119', '1505751172876-fa1923c5c528'],
    'teacher,professor': ['1580582932707-520aed937b7b', '1497633762265-9d179a990aa6', '1503676260728-1c00da094a0b'],
    'doctor,nurse,hospital': ['1505751172876-fa1923c5c528', '1584515979956-d9f6e5d09982', '1530026405186-ed1f139313f8'],

    // 🔬 SCIENCE, ANATOMY & NATURE
    'brain,mind,nervous system,neurons': ['1559757175-5700dde675bc', '1530026405186-ed1f139313f8', '1505751172876-fa1923c5c528'],
    'heart,pulse,blood,cardio': ['1530026405186-ed1f139313f8', '1628348068343-c6a848d2b6dd', '1505751172876-fa1923c5c528'],
    'lungs,breathing,respiratory': ['1584515979956-d9f6e5d09982', '1505751172876-fa1923c5c528', '1530026405186-ed1f139313f8'],
    'stomach,digestion,digestive system,liver,kidney,intestine': ['1505751172876-fa1923c5c528', '1530026405186-ed1f139313f8', '1584515979956-d9f6e5d09982'],
    'skeleton,bone,bones,skull,spine': ['1530497610245-94d3c16cda28', '1505751172876-fa1923c5c528', '1584515979956-d9f6e5d09982'],
    'muscle,muscles,muscular': ['1530026405186-ed1f139313f8', '1461896836934-ffe607ba8211', '1505751172876-fa1923c5c528'],
    'eye,eyes,sight,vision': ['1516715094483-75da7dee9758', '1574701148212-8518049c7b2c', '1543466835-00a7907e9de1'],
    'ear,ears,hearing,sound': ['1511671782779-c97d3d27a1d4', '1470225620780-dba8ba36b745', '1516715094483-75da7dee9758'],
    'nose,smell,tongue,taste,skin,touch,senses,sense organ': ['1505751172876-fa1923c5c528', '1490750967868-88aa4486c946', '1516715094483-75da7dee9758'],
    'cell,cells,plant cell,animal cell,microscope,bacteria,virus,dna': ['1576086213369-97a306d36557', '1532187863486-abf9dbad1b69', '1530497610245-94d3c16cda28'],
    'plant,plants,leaf,leaves,root,roots,stem,seed,seeds,photosynthesis,chlorophyll': ['1518531933037-91b2f5f229cc', '1501004318641-b39e6451bec6', '1490750967868-88aa4486c946'],
    'flower,flowers,tree,trees,forest': ['1490750967868-88aa4486c946', '1448375240586-882707db888b', '1518531933037-91b2f5f229cc'],
    'living thing,animal,animals,mammal,mammals,habitat,ecosystem,food chain': ['1543466835-00a7907e9de1', '1474511320723-9a56873867b5', '1587300003388-59208cc962cb'],
    'reptile,amphibian,frog,snake': ['1518531933037-91b2f5f229cc', '1474511320723-9a56873867b5', '1543466835-00a7907e9de1'],
    'bird,birds,fish,ocean,sea': ['1611689342806-0863700ce1e4', '1522069169874-c58ec4b76be5', '1507525428034-b723cf961d3e'],
    'insect,butterfly,caterpillar,metamorphosis,bee,spider': ['1558980394-0a06c4631733', '1490750967868-88aa4486c946', '1518531933037-91b2f5f229cc'],
    'dog,puppy,cat,kitten,pet': ['1543466835-00a7907e9de1', '1587300003388-59208cc962cb', '1514888286974-6c03e2ca1dba'],
    'sun,sunlight,daytime,solar': ['1617155093730-a8bf47be792d', '1534088568595-a066f410bcda', '1506703719100-a0f3a48c0f86'],
    'moon,stars,solar system,planet,planets,earth,mars,jupiter,saturn,space,astronaut,gravity,orbit,telescope': ['1614728894747-a83421e2b9c9', '1451187580459-43490279c0fa', '1506703719100-a0f3a48c0f86'],
    'rain,rainy,cloud,water cycle,weather,umbrella,ice,storm': ['1515694346937-94d85e41e6f0', '1534088568595-a066f410bcda', '1617155093730-a8bf47be792d'],
    'volcano,magma,lava,eruption': ['1464822759023-fed622ff2c3b', '1470071459604-3b5ec3a7fe05', '1506703719100-a0f3a48c0f86'],
    'magnet,magnetism,pulley,machine,electricity,circuit,energy,force': ['1581092160607-ee22621dd758', '1532187863486-abf9dbad1b69', '1635070041078-e363dbe005cb'],

    // 📐 MATHEMATICS & GEOMETRY
    'math,mathematics,number,numbers,digit,zero,addition,add,plus,subtraction,minus,multiplication,multiply,division,divide,equals,equation': ['1596495578065-6e0763fa1178', '1509228468518-180dd4864904', '1635070041078-e363dbe005cb'],
    'fraction,fractions,numerator,denominator,decimal,percent,percentage,ratio,algebra,variable': ['1509228468518-180dd4864904', '1596495578065-6e0763fa1178', '1635070041078-e363dbe005cb'],
    'shape,shapes,triangle,circle,square,rectangle,geometry,angle,perimeter,area,polygon,cube,sphere': ['1509228468518-180dd4864904', '1596495578065-6e0763fa1178', '1635070041078-e363dbe005cb'],
    'apple,apples,fruit count': ['1560806887-1e4cd0b6cbd6', '1570913149827-d2ac84ab3f9a', '1579613832125-5d34a13ffe2a'],
    'calendar,day,week,month,year,date': ['1506784983877-45594efa4cbe', '1508057198894-247b23fe5ade', '1509228468518-180dd4864904'],
    'clock,time,hour,minute,watch': ['1508057198894-247b23fe5ade', '1506784983877-45594efa4cbe', '1509228468518-180dd4864904'],
    'money,peso,coins,centavo,bank': ['1596495578065-6e0763fa1178', '1509228468518-180dd4864904', 'flag:ph'],

    // 📖 ENGLISH, READING & LANGUAGE ARTS
    'book,books,reading,read,story,stories,library,novel,fairytale': ['1497633762265-9d179a990aa6', '1512820790803-83ca734da794', '1455390582262-044cdead277a'],
    'school,classroom,student,students,desk,pencil,alphabet,letter,spelling,vocabulary,dictionary': ['1580582932707-520aed937b7b', '1497633762265-9d179a990aa6', '1503676260728-1c00da094a0b'],
    'grammar,noun,verb,adjective,adverb,pronoun,sentence,paragraph': ['1455390582262-044cdead277a', '1497633762265-9d179a990aa6', '1512820790803-83ca734da794'],
    'running,run,jump,action,sports': ['1461896836934-ffe607ba8211', '1474511320723-9a56873867b5', '1543466835-00a7907e9de1'],
    'happy,smile,emotion,joy': ['1498837167922-ddd27525d352', '1543466835-00a7907e9de1', '1503676260728-1c00da094a0b'],
    'poetry,poem,writing,author,essay': ['1455390582262-044cdead277a', '1497633762265-9d179a990aa6', '1512820790803-83ca734da794'],
  };

  /// Expands short IDs into production CDN URLs
  static String _resolveUrl(String token) {
    if (token == 'flag:ph') return 'https://flagcdn.com/w640/ph.png';
    if (token == 'flagpedia:ph') return 'https://flagpedia.net/data/flags/w580/ph.png';
    if (token == 'flag_sm:ph') return 'https://flagcdn.com/h240/ph.png';
    if (token.startsWith('http')) return token;
    return '$_unsplashBase$token$_unsplashParams';
  }

  /// High-Level Matchmaking: Scans prompt context, explicit keywords, and subject
  static List<String> getEducationalImageUrls(
    String? keyword,
    String subject, {
    String? questionPrompt,
  }) {
    final searchContext = '${keyword ?? ''} ${questionPrompt ?? ''} $subject'
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), ' ');

    // 1. Scan clustered synonyms
    for (final entry in _conceptRegistry.entries) {
      final synonyms = entry.key.split(',');
      for (final syn in synonyms) {
        final cleanSyn = syn.trim();
        if (cleanSyn.isEmpty) continue;
        final pattern = RegExp('\\b${RegExp.escape(cleanSyn)}\\b');
        if (pattern.hasMatch(searchContext)) {
          return entry.value.map(_resolveUrl).toList();
        }
      }
    }

    // 2. Fallback by Subject Category
    final cleanSubject = subject.toLowerCase();
    if (cleanSubject.contains('science')) {
      return _conceptRegistry['plant,plants,leaf,leaves,root,roots,stem,seed,seeds,photosynthesis,chlorophyll']!
          .map(_resolveUrl)
          .toList();
    } else if (cleanSubject.contains('math')) {
      return _conceptRegistry['math,mathematics,number,numbers,digit,zero,addition,add,plus,subtraction,minus,multiplication,multiply,division,divide,equals,equation']!
          .map(_resolveUrl)
          .toList();
    } else if (cleanSubject.contains('history') || cleanSubject.contains('philippine')) {
      return _conceptRegistry['philippine flag,flag,watawat,bandila']!
          .map(_resolveUrl)
          .toList();
    }
    return _conceptRegistry['book,books,reading,read,story,stories,library,novel,fairytale']!
        .map(_resolveUrl)
        .toList();
  }

  /// Convenience single-URL resolver
  static String getEducationalImageUrl(String? keyword, String subject, {String? questionPrompt}) {
    final list = getEducationalImageUrls(keyword, subject, questionPrompt: questionPrompt);
    return list.isNotEmpty ? list.first : 'https://flagcdn.com/w640/ph.png';
  }
}
