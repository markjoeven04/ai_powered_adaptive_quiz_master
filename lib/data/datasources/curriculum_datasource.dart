import '../../core/models/question_model.dart';
import '../../core/models/subject_enum.dart';
import '../../core/models/difficulty_enum.dart';

class CurriculumDataSource {
  /// Returns curated questions matching the requested grade, subject, and difficulty
  static List<QuizQuestion> getQuestions({
    required Subject subject,
    required int grade,
    required QuizDifficulty difficulty,
    int count = 20,
  }) {
    final pool = _getCurriculumPool(subject: subject, grade: grade, difficulty: difficulty);
    if (pool.length <= count) {
      return List.from(pool);
    }
    return pool.sublist(0, count);
  }

  static List<QuizQuestion> _getCurriculumPool({
    required Subject subject,
    required int grade,
    required QuizDifficulty difficulty,
  }) {
    switch (subject) {
      case Subject.science:
        if (grade <= 3) return _primaryScienceQuestions(grade, difficulty);
        if (grade <= 6) return _intermediateScienceQuestions(grade, difficulty);
        return _secondaryScienceQuestions(grade, difficulty);
      case Subject.math:
        if (grade <= 3) return _primaryMathQuestions(grade, difficulty);
        if (grade <= 6) return _intermediateMathQuestions(grade, difficulty);
        return _secondaryMathQuestions(grade, difficulty);
      case Subject.philippineHistory:
        if (grade <= 3) return _primaryHistoryQuestions(grade, difficulty);
        if (grade <= 6) return _intermediateHistoryQuestions(grade, difficulty);
        return _secondaryHistoryQuestions(grade, difficulty);
      case Subject.english:
        if (grade <= 3) return _primaryEnglishQuestions(grade, difficulty);
        if (grade <= 6) return _intermediateEnglishQuestions(grade, difficulty);
        return _secondaryEnglishQuestions(grade, difficulty);
    }
  }

  // ==========================================
  // --- PRIMARY SCIENCE (GRADES 1 - 3) ---
  // ==========================================
  static List<QuizQuestion> _primaryScienceQuestions(int grade, QuizDifficulty difficulty) {
    return [
      QuizQuestion(
        id: 'sci_p_1',
        prompt: 'Which body part do we use to see colors and shapes?',
        options: ['Eyes', 'Ears', 'Nose', 'Tongue'],
        correctIndex: 0,
        explanation: 'We use our eyes to see everything around us, including shapes, colors, and objects.',
        imageKeyword: 'eye',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'sci_p_2',
        prompt: 'Which of these is a living thing?',
        options: ['A stone', 'A puppy', 'A chair', 'A pencil'],
        correctIndex: 1,
        explanation: 'A puppy is a living thing because it breathes, eats food, and grows.',
        imageKeyword: 'dog',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'sci_p_3',
        prompt: 'Which part of a plant takes in water from the soil?',
        options: ['Roots', 'Flowers', 'Leaves', 'Fruits'],
        correctIndex: 0,
        explanation: 'Roots grow under the soil and absorb water and nutrients to help the plant grow.',
        imageKeyword: 'plant',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'sci_p_4',
        prompt: 'What gives us bright light and warmth during the daytime?',
        options: ['The Moon', 'The Sun', 'A Flashlight', 'The Stars'],
        correctIndex: 1,
        explanation: 'The Sun is a giant star that provides Earth with sunlight and warmth every day.',
        imageKeyword: 'sun',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'sci_p_5',
        prompt: 'Which animal has fins and lives in water?',
        options: ['Fish', 'Bird', 'Cat', 'Carabao'],
        correctIndex: 0,
        explanation: 'Fish use fins to swim and gills to breathe underwater.',
        imageKeyword: 'fish',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'sci_p_6',
        prompt: 'Which sense do we use when listening to our favorite song?',
        options: ['Sense of Taste', 'Sense of Hearing', 'Sense of Smell', 'Sense of Touch'],
        correctIndex: 1,
        explanation: 'We use our ears and the sense of hearing to listen to sounds and music.',
        imageKeyword: 'hearing',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'sci_p_7',
        prompt: 'What kind of weather makes us use an umbrella and raincoat?',
        options: ['Sunny Day', 'Rainy Day', 'Windy Day', 'Hot Day'],
        correctIndex: 1,
        explanation: 'We use umbrellas and raincoats on rainy days to keep ourselves dry.',
        imageKeyword: 'rain',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'sci_p_8',
        prompt: 'Which animal starts its life as a caterpillar?',
        options: ['Butterfly', 'Frog', 'Eagle', 'Turtle'],
        correctIndex: 0,
        explanation: 'A caterpillar grows and transforms into a beautiful butterfly inside a chrysalis.',
        imageKeyword: 'butterfly',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'sci_p_9',
        prompt: 'Which body part beats continuously to pump blood throughout our body?',
        options: ['Lungs', 'Heart', 'Stomach', 'Bones'],
        correctIndex: 1,
        explanation: 'The heart is a muscular organ that pumps blood to all parts of our body.',
        imageKeyword: 'heart',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'sci_p_10',
        prompt: 'What happens to water when you put it in a freezer?',
        options: ['It turns into ice', 'It turns into steam', 'It turns into air', 'It disappears'],
        correctIndex: 0,
        explanation: 'Freezing liquid water cools it down until it turns into solid ice.',
        imageKeyword: 'ice',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
    ];
  }

  // ==========================================
  // --- INTERMEDIATE SCIENCE (GRADES 4 - 6) ---
  // ==========================================
  static List<QuizQuestion> _intermediateScienceQuestions(int grade, QuizDifficulty difficulty) {
    return [
      QuizQuestion(
        id: 'sci_i_1',
        prompt: 'What green pigment in plant leaves absorbs sunlight for photosynthesis?',
        options: ['Chlorophyll', 'Carotene', 'Anthocyanin', 'Melanin'],
        correctIndex: 0,
        explanation: 'Chlorophyll is the green pigment in plant leaves that traps light energy for food making.',
        imageKeyword: 'leaf',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'sci_i_2',
        prompt: 'What state of matter has a definite volume but takes the shape of its container?',
        options: ['Solid', 'Liquid', 'Gas', 'Plasma'],
        correctIndex: 1,
        explanation: 'Liquids flow and take the shape of their container while keeping a fixed volume.',
        imageKeyword: 'water',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'sci_i_3',
        prompt: 'Which planet is the largest in our solar system?',
        options: ['Earth', 'Mars', 'Jupiter', 'Saturn'],
        correctIndex: 2,
        explanation: 'Jupiter is the largest planet in our solar system, famous for its Great Red Spot.',
        imageKeyword: 'jupiter',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'sci_i_4',
        prompt: 'What force pulls objects toward the ground when you drop them?',
        options: ['Friction', 'Magnetism', 'Gravity', 'Electricity'],
        correctIndex: 2,
        explanation: 'Gravity is the invisible force that pulls everything toward Earth.',
        imageKeyword: 'gravity',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'sci_i_5',
        prompt: 'Which organ in our body helps us digest food by mixing it with acid?',
        options: ['Lungs', 'Stomach', 'Heart', 'Kidneys'],
        correctIndex: 1,
        explanation: 'The stomach breaks down food with digestive juices and stomach acids.',
        imageKeyword: 'digestion',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'sci_i_6',
        prompt: 'What part of the water cycle happens when water changes from liquid to water vapor?',
        options: ['Evaporation', 'Condensation', 'Precipitation', 'Collection'],
        correctIndex: 0,
        explanation: 'Evaporation happens when the sun warms surface water and turns it into water vapor.',
        imageKeyword: 'water cycle',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'sci_i_7',
        prompt: 'Which simple machine consists of a grooved wheel with a rope around it?',
        options: ['Pulley', 'Lever', 'Wedge', 'Screw'],
        correctIndex: 0,
        explanation: 'A pulley uses a grooved wheel and rope to lift heavy loads easily.',
        imageKeyword: 'pulley',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'sci_i_8',
        prompt: 'What famous cone-shaped volcano in the Philippines is known for its near-perfect shape?',
        options: ['Mount Pinatubo', 'Mayon Volcano', 'Taal Volcano', 'Mount Apo'],
        correctIndex: 1,
        explanation: 'Mayon Volcano in Albay, Bicol is world-famous for its symmetrical cone shape.',
        imageKeyword: 'volcano',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'sci_i_9',
        prompt: 'Which animal group gives birth to live babies and feeds them milk?',
        options: ['Reptiles', 'Birds', 'Mammals', 'Amphibians'],
        correctIndex: 2,
        explanation: 'Mammals are warm-blooded vertebrates that nurse their young with milk.',
        imageKeyword: 'mammal',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'sci_i_10',
        prompt: 'What happens when two north poles of magnets are brought close together?',
        options: ['They attract', 'They repel', 'They stick together', 'Nothing happens'],
        correctIndex: 1,
        explanation: 'Like magnetic poles (North-North or South-South) repel and push each other away.',
        imageKeyword: 'magnet',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
    ];
  }

  // ==========================================
  // --- SECONDARY SCIENCE (GRADES 7 - 12) ---
  // ==========================================
  static List<QuizQuestion> _secondaryScienceQuestions(int grade, QuizDifficulty difficulty) {
    return [
      QuizQuestion(
        id: 'sci_s_1',
        prompt: 'Which organelle is widely known as the powerhouse of the eukaryotic cell?',
        options: ['Ribosome', 'Mitochondria', 'Golgi apparatus', 'Lysosome'],
        correctIndex: 1,
        explanation: 'Mitochondria generate cellular energy in the form of ATP through cellular respiration.',
        imageKeyword: 'cell',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'sci_s_2',
        prompt: 'What is the chemical formula for common table salt?',
        options: ['KCl', 'NaOH', 'NaCl', 'CaCO3'],
        correctIndex: 2,
        explanation: 'Table salt is sodium chloride, formed by an ionic bond between Sodium (Na) and Chlorine (Cl).',
        imageKeyword: 'chemistry',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'sci_s_3',
        prompt: 'What layer of the Earth lies directly beneath the solid continental crust?',
        options: ['Outer Core', 'Mantle', 'Inner Core', 'Lithosphere'],
        correctIndex: 1,
        explanation: 'The mantle is the thick semi-solid rocky layer located beneath Earth’s crust.',
        imageKeyword: 'geology',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'sci_s_4',
        prompt: 'What type of eclipse occurs when the Moon passes directly between the Sun and Earth?',
        options: ['Lunar Eclipse', 'Solar Eclipse', 'Stellar Eclipse', 'Planetary Eclipse'],
        correctIndex: 1,
        explanation: 'A solar eclipse happens when the Moon casts its shadow onto the Earth by blocking the Sun.',
        imageKeyword: 'space',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'sci_s_5',
        prompt: 'What is the basic unit of heredity in living organisms?',
        options: ['Gene', 'Protein', 'Ribosome', 'Enzyme'],
        correctIndex: 0,
        explanation: 'Genes are segments of DNA that carry genetic instructions passed from parents to offspring.',
        imageKeyword: 'dna',
        subject: 'Science',
        grade: grade,
        difficulty: difficulty.id,
      ),
    ];
  }

  // ==========================================
  // --- PRIMARY MATH (GRADES 1 - 3) ---
  // ==========================================
  static List<QuizQuestion> _primaryMathQuestions(int grade, QuizDifficulty difficulty) {
    return [
      QuizQuestion(
        id: 'math_p_1',
        prompt: 'What is 5 + 3?',
        options: ['7', '8', '9', '6'],
        correctIndex: 1,
        explanation: 'Adding 5 and 3 gives 8 (5 + 3 = 8).',
        imageKeyword: 'math',
        subject: 'Mathematics',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'math_p_2',
        prompt: 'How many sides does a triangle have?',
        options: ['3', '4', '5', '6'],
        correctIndex: 0,
        explanation: 'A triangle is a shape with exactly 3 straight sides and 3 corners.',
        imageKeyword: 'triangle',
        subject: 'Mathematics',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'math_p_3',
        prompt: 'What is 10 - 4?',
        options: ['5', '6', '7', '8'],
        correctIndex: 1,
        explanation: 'If you take away 4 from 10, you have 6 left (10 - 4 = 6).',
        imageKeyword: 'numbers',
        subject: 'Mathematics',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'math_p_4',
        prompt: 'Which shape is round like a ball or a coin?',
        options: ['Square', 'Circle', 'Triangle', 'Rectangle'],
        correctIndex: 1,
        explanation: 'A circle is completely round with no corners or straight edges.',
        imageKeyword: 'circle',
        subject: 'Mathematics',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'math_p_5',
        prompt: 'What number comes right after 19?',
        options: ['18', '20', '21', '22'],
        correctIndex: 1,
        explanation: 'When counting numbers in order: 18, 19, 20.',
        imageKeyword: 'numbers',
        subject: 'Mathematics',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'math_p_6',
        prompt: 'What is 4 + 4?',
        options: ['6', '7', '8', '9'],
        correctIndex: 2,
        explanation: 'Adding 4 and 4 equals 8 (4 + 4 = 8).',
        imageKeyword: 'math',
        subject: 'Mathematics',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'math_p_7',
        prompt: 'How many days are there in one week?',
        options: ['5 days', '6 days', '7 days', '8 days'],
        correctIndex: 2,
        explanation: 'There are 7 days in a week: Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday.',
        imageKeyword: 'calendar',
        subject: 'Mathematics',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'math_p_8',
        prompt: 'If you have 2 apples and your friend gives you 3 more, how many apples do you have?',
        options: ['4 apples', '5 apples', '6 apples', '7 apples'],
        correctIndex: 1,
        explanation: '2 + 3 = 5 apples in total.',
        imageKeyword: 'apple',
        subject: 'Mathematics',
        grade: grade,
        difficulty: difficulty.id,
      ),
    ];
  }

  // ==========================================
  // --- INTERMEDIATE MATH (GRADES 4 - 6) ---
  // ==========================================
  static List<QuizQuestion> _intermediateMathQuestions(int grade, QuizDifficulty difficulty) {
    return [
      QuizQuestion(
        id: 'math_i_1',
        prompt: 'What is 7 x 8?',
        options: ['54', '56', '58', '64'],
        correctIndex: 1,
        explanation: '7 multiplied by 8 equals 56.',
        imageKeyword: 'multiplication',
        subject: 'Mathematics',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'math_i_2',
        prompt: 'What is 1/2 + 1/4?',
        options: ['2/6', '3/4', '2/4', '1/6'],
        correctIndex: 1,
        explanation: 'Convert 1/2 to 2/4. Then 2/4 + 1/4 = 3/4.',
        imageKeyword: 'fraction',
        subject: 'Mathematics',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'math_i_3',
        prompt: 'What is the perimeter of a square with a side length of 5 cm?',
        options: ['10 cm', '15 cm', '20 cm', '25 cm'],
        correctIndex: 2,
        explanation: 'Perimeter of a square = 4 x side = 4 x 5 cm = 20 cm.',
        imageKeyword: 'geometry',
        subject: 'Mathematics',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'math_i_4',
        prompt: 'What is 100 divided by 4?',
        options: ['20', '25', '30', '50'],
        correctIndex: 1,
        explanation: '100 divided by 4 equals 25.',
        imageKeyword: 'division',
        subject: 'Mathematics',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'math_i_5',
        prompt: 'What is 0.5 written as a simple fraction?',
        options: ['1/5', '1/2', '1/4', '5/100'],
        correctIndex: 1,
        explanation: '0.5 equals five-tenths (5/10), which simplifies to 1/2.',
        imageKeyword: 'fraction',
        subject: 'Mathematics',
        grade: grade,
        difficulty: difficulty.id,
      ),
    ];
  }

  // ==========================================
  // --- SECONDARY MATH (GRADES 7 - 12) ---
  // ==========================================
  static List<QuizQuestion> _secondaryMathQuestions(int grade, QuizDifficulty difficulty) {
    return [
      QuizQuestion(
        id: 'math_s_1',
        prompt: 'Solve for x in the linear equation: 3x + 9 = 24',
        options: ['x = 3', 'x = 5', 'x = 7', 'x = 9'],
        correctIndex: 1,
        explanation: 'Subtract 9 from both sides: 3x = 15. Divide by 3: x = 5.',
        imageKeyword: 'algebra',
        subject: 'Mathematics',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'math_s_2',
        prompt: 'What is the value of the hypotenuse in a right triangle with legs of length 3 and 4?',
        options: ['5', '6', '7', '8'],
        correctIndex: 0,
        explanation: 'By the Pythagorean theorem: c² = 3² + 4² = 9 + 16 = 25. Therefore c = 5.',
        imageKeyword: 'triangle',
        subject: 'Mathematics',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'math_s_3',
        prompt: 'What is the sum of the interior angles of any triangle?',
        options: ['90°', '180°', '270°', '360°'],
        correctIndex: 1,
        explanation: 'The interior angles of any planar triangle always add up to exactly 180 degrees.',
        imageKeyword: 'angle',
        subject: 'Mathematics',
        grade: grade,
        difficulty: difficulty.id,
      ),
    ];
  }

  // ==========================================
  // --- PRIMARY PHILIPPINE HISTORY (GRADES 1 - 3) ---
  // ==========================================
  static List<QuizQuestion> _primaryHistoryQuestions(int grade, QuizDifficulty difficulty) {
    return [
      QuizQuestion(
        id: 'hist_p_1',
        prompt: 'What is the national bird of the Philippines?',
        options: ['Maya', 'Philippine Eagle', 'Owl', 'Parrot'],
        correctIndex: 1,
        explanation: 'The Philippine Eagle (Haribon) is the majestic national bird of the Philippines.',
        imageKeyword: 'philippine eagle',
        subject: 'Philippine History',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'hist_p_2',
        prompt: 'What color is on the top of the Philippine flag during peacetime?',
        options: ['Red', 'Blue', 'White', 'Yellow'],
        correctIndex: 1,
        explanation: 'The blue stripe is at the top of the Philippine flag during times of peace.',
        imageKeyword: 'philippine flag',
        subject: 'Philippine History',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'hist_p_3',
        prompt: 'How many rays are on the sun in the Philippine flag?',
        options: ['6 rays', '7 rays', '8 rays', '10 rays'],
        correctIndex: 2,
        explanation: 'The sun has 8 rays, representing the first 8 provinces that rose against Spanish rule.',
        imageKeyword: 'sun',
        subject: 'Philippine History',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'hist_p_4',
        prompt: 'Who is known as the national hero of the Philippines?',
        options: ['Dr. Jose Rizal', 'Andres Bonifacio', 'Lapu-Lapu', 'Apolinario Mabini'],
        correctIndex: 0,
        explanation: 'Dr. Jose Rizal is celebrated as the national hero of the Philippines.',
        imageKeyword: 'jose rizal',
        subject: 'Philippine History',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'hist_p_5',
        prompt: 'What is the national animal of the Philippines?',
        options: ['Horse', 'Carabao', 'Dog', 'Cat'],
        correctIndex: 1,
        explanation: 'The carabao (water buffalo) is the hardworking national animal of the Philippines.',
        imageKeyword: 'carabao',
        subject: 'Philippine History',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'hist_p_6',
        prompt: 'Who helps put out fires and keep our community safe?',
        options: ['Firefighter', 'Pilot', 'Baker', 'Farmer'],
        correctIndex: 0,
        explanation: 'Firefighters are brave community helpers who put out fires and protect lives.',
        imageKeyword: 'firefighter',
        subject: 'Philippine History',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'hist_p_7',
        prompt: 'What is the capital city of the Philippines?',
        options: ['Cebu', 'Davao', 'Manila', 'Baguio'],
        correctIndex: 2,
        explanation: 'Manila is the historic capital city of the Philippines.',
        imageKeyword: 'manila',
        subject: 'Philippine History',
        grade: grade,
        difficulty: difficulty.id,
      ),
    ];
  }

  // ==========================================
  // --- INTERMEDIATE PHILIPPINE HISTORY (GRADES 4 - 6) ---
  // ==========================================
  static List<QuizQuestion> _intermediateHistoryQuestions(int grade, QuizDifficulty difficulty) {
    return [
      QuizQuestion(
        id: 'hist_i_1',
        prompt: 'Who was the brave chieftain of Mactan who defeated Ferdinand Magellan in 1521?',
        options: ['Rajah Sulayman', 'Lapu-Lapu', 'Datu Puti', 'Andres Bonifacio'],
        correctIndex: 1,
        explanation: 'Lapu-Lapu led the warriors of Mactan in 1521, making him the first Filipino hero to resist foreign colonizers.',
        imageKeyword: 'lapu lapu',
        subject: 'Philippine History',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'hist_i_2',
        prompt: 'What revolutionary society was founded by Andres Bonifacio in 1892?',
        options: ['La Liga Filipina', 'Katipunan (KKK)', 'Propaganda Movement', 'Hukbalahap'],
        correctIndex: 1,
        explanation: 'Andres Bonifacio founded the Kataas-taasang, Kagalang-galangang Katipunan ng mga Anak ng Bayan (KKK) in 1892.',
        imageKeyword: 'katipunan',
        subject: 'Philippine History',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'hist_i_3',
        prompt: 'What are the three main island groups that make up the Philippines?',
        options: [
          'Luzon, Visayas, Mindanao',
          'Palawan, Panay, Samar',
          'Batanes, Cebu, Sulu',
          'Mindoro, Bohol, Leyte'
        ],
        correctIndex: 0,
        explanation: 'The Philippine archipelago is divided into three major island groups: Luzon, Visayas, and Mindanao.',
        imageKeyword: 'philippines',
        subject: 'Philippine History',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'hist_i_4',
        prompt: 'In which province was Philippine Independence proclaimed on June 12, 1898?',
        options: ['Bulacan', 'Kawit, Cavite', 'Batangas', 'Laguna'],
        correctIndex: 1,
        explanation: 'General Emilio Aguinaldo proclaimed Philippine Independence from his home in Kawit, Cavite.',
        imageKeyword: 'cavite',
        subject: 'Philippine History',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'hist_i_5',
        prompt: 'What famous novel written by Dr. Jose Rizal exposed the abuses during the Spanish era?',
        options: ['Noli Me Tangere', 'Florante at Laura', 'Ibong Adarna', 'Mi Ultimo Adios'],
        correctIndex: 0,
        explanation: 'Noli Me Tangere (Touch Me Not) awakened Filipino national consciousness.',
        imageKeyword: 'book',
        subject: 'Philippine History',
        grade: grade,
        difficulty: difficulty.id,
      ),
    ];
  }

  // ==========================================
  // --- SECONDARY PHILIPPINE HISTORY (GRADES 7 - 12) ---
  // ==========================================
  static List<QuizQuestion> _secondaryHistoryQuestions(int grade, QuizDifficulty difficulty) {
    return [
      QuizQuestion(
        id: 'hist_s_1',
        prompt: 'What 1898 treaty officially ceded the Philippines from Spain to the United States for 20 million dollars?',
        options: ['Treaty of Paris', 'Pact of Biak-na-Bato', 'Treaty of Tordesillas', 'Treaty of Manila'],
        correctIndex: 0,
        explanation: 'The Treaty of Paris signed on December 10, 1898 ended the Spanish-American War.',
        imageKeyword: 'history',
        subject: 'Philippine History',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'hist_s_2',
        prompt: 'Who was the first President of the Philippine Commonwealth established in 1935?',
        options: ['Manuel L. Quezon', 'Sergio Osmeña', 'Jose P. Laurel', 'Manuel Roxas'],
        correctIndex: 0,
        explanation: 'Manuel L. Quezon was elected as the first President of the Commonwealth of the Philippines.',
        imageKeyword: 'president',
        subject: 'Philippine History',
        grade: grade,
        difficulty: difficulty.id,
      ),
    ];
  }

  // ==========================================
  // --- PRIMARY ENGLISH (GRADES 1 - 3) ---
  // ==========================================
  static List<QuizQuestion> _primaryEnglishQuestions(int grade, QuizDifficulty difficulty) {
    return [
      QuizQuestion(
        id: 'eng_p_1',
        prompt: 'Which word rhymes with "cat"?',
        options: ['Dog', 'Hat', 'Sun', 'Cup'],
        correctIndex: 1,
        explanation: '"Cat" and "Hat" end with the same sound (-at), so they rhyme.',
        imageKeyword: 'reading',
        subject: 'English',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'eng_p_2',
        prompt: 'Which of these is a naming word (noun)?',
        options: ['Jump', 'Quickly', 'School', 'Happy'],
        correctIndex: 2,
        explanation: '"School" is a noun because it names a place.',
        imageKeyword: 'school',
        subject: 'English',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'eng_p_3',
        prompt: 'What is the opposite of the word "hot"?',
        options: ['Cold', 'Warm', 'Bright', 'Fast'],
        correctIndex: 0,
        explanation: 'The opposite of hot is cold (e.g. hot tea vs cold ice).',
        imageKeyword: 'ice',
        subject: 'English',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'eng_p_4',
        prompt: 'Which of these is an action word (verb)?',
        options: ['Run', 'Blue', 'Chair', 'Soft'],
        correctIndex: 0,
        explanation: '"Run" is an action word (verb) showing what someone does.',
        imageKeyword: 'running',
        subject: 'English',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'eng_p_5',
        prompt: 'What punctuation mark belongs at the end of a question: "Where is my book___"?',
        options: ['. (Period)', '? (Question Mark)', '! (Exclamation Mark)', ', (Comma)'],
        correctIndex: 1,
        explanation: 'We always use a question mark (?) at the end of an asking sentence.',
        imageKeyword: 'book',
        subject: 'English',
        grade: grade,
        difficulty: difficulty.id,
      ),
    ];
  }

  // ==========================================
  // --- INTERMEDIATE ENGLISH (GRADES 4 - 6) ---
  // ==========================================
  static List<QuizQuestion> _intermediateEnglishQuestions(int grade, QuizDifficulty difficulty) {
    return [
      QuizQuestion(
        id: 'eng_i_1',
        prompt: 'Which part of speech describes or gives more information about a noun?',
        options: ['Adjective', 'Verb', 'Preposition', 'Conjunction'],
        correctIndex: 0,
        explanation: 'An adjective describes a noun (e.g. "a bright star", "a happy child").',
        imageKeyword: 'grammar',
        subject: 'English',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'eng_i_2',
        prompt: 'What is a word with the same or nearly the same meaning as "cheerful"?',
        options: ['Sad', 'Happy', 'Angry', 'Tired'],
        correctIndex: 1,
        explanation: '"Happy" and "cheerful" are synonyms with similar meanings.',
        imageKeyword: 'happy',
        subject: 'English',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'eng_i_3',
        prompt: 'Choose the correct verb: "The students ______ studying for their exam."',
        options: ['is', 'are', 'was', 'be'],
        correctIndex: 1,
        explanation: '"Students" is plural, so we use the plural verb "are".',
        imageKeyword: 'student',
        subject: 'English',
        grade: grade,
        difficulty: difficulty.id,
      ),
    ];
  }

  // ==========================================
  // --- SECONDARY ENGLISH (GRADES 7 - 12) ---
  // ==========================================
  static List<QuizQuestion> _secondaryEnglishQuestions(int grade, QuizDifficulty difficulty) {
    return [
      QuizQuestion(
        id: 'eng_s_1',
        prompt: 'What figure of speech makes a direct comparison between two unlike things using "like" or "as"?',
        options: ['Metaphor', 'Simile', 'Personification', 'Hyperbole'],
        correctIndex: 1,
        explanation: 'A simile uses "like" or "as" to compare two things (e.g. "as brave as a lion").',
        imageKeyword: 'poetry',
        subject: 'English',
        grade: grade,
        difficulty: difficulty.id,
      ),
      QuizQuestion(
        id: 'eng_s_2',
        prompt: 'In grammar, what voice is used when the subject performs the action expressed by the verb?',
        options: ['Passive Voice', 'Active Voice', 'Imperative Voice', 'Subjunctive Voice'],
        correctIndex: 1,
        explanation: 'In the active voice, the subject acts upon its verb (e.g. "The chef cooked a meal").',
        imageKeyword: 'writing',
        subject: 'English',
        grade: grade,
        difficulty: difficulty.id,
      ),
    ];
  }
}
