class QuizData {
  final String imagePath;
  final List<Question> questions;

  QuizData({required this.imagePath, required this.questions});
}

List<QuizData> quizDataList = [
  QuizData(
    imagePath: 'assets/SherlockHolmes/1.jpg',
    questions: [
      Question(
        question: 'HOW MANY LAMPS IN THE PICTURE ?',
        options: ["1", "3", "2", "None"],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE SOFA?',
        options: ["YELLOW", "ORANGE", "PINK", "GREEN"],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'WHAT IS INSIDE THE PHOTO FRAME ?',
        options: ["BOAT", "FLOWER POT", "MOUNTAIN", "FAMILY"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE TELEPHONE ?',
        options: ["BLUE", "PINK", "RED", "GREEN"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY COLOR THE CARPET HAS ?',
        options: ["5", "3", "2", "4"],
        correctAnswerIndex: 3,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/SherlockHolmes/2.jpg',
    questions: [
      Question(
        question: 'WHAT IS THE COLOR OF THE CLOCK ?',
        options: ['RED', 'GREEN', 'BLUE', 'YELLOW'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE CAR?',
        options: ['BLUE', 'RED', 'YELLOW', 'GREEN'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'HOW MANY ALPHABET  IN A TOY CUBE ?',
        options: ['1', '2', '4', '3'],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE WALL?',
        options: ['BLUE', 'RED', 'PURPLE', 'YELLOW'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY PILLOW ARE ON THE BED?',
        options: ['1', '2', '3', '4'],
        correctAnswerIndex: 1,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/SherlockHolmes/3.jpg',
    questions: [
      Question(
        question: 'HOW MANY PEOPLE ARE IN THE CLASS?',
        options: ["6", "3", "4", "2"],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'HOW MANY STUDENT ARE STANDING?',
        options: ["1", "2", "3", "ALL"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE GIRL\'S TSHIRT ?',
        options: ["GREEN", "PINK", "RED", "PURPLE"],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE BOOK WHICH HOLD BY TEACHER ?',
        options: ["BLUE", "RED", "PURPLE", "YELLOW"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY TREES CAN BE SEEN FROM A WINDOW?',
        options: ["3", "4", "2", "5"],
        correctAnswerIndex: 1,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/SherlockHolmes/4.jpg',
    questions: [
      Question(
        question: 'WHAT IS THE COLOR OF THE CHAIR?',
        options: ['GREEN', 'YELLOW', 'RED', 'WHITE'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHICH FRUIT IS ON THE TABLE?',
        options: ['APPLE', 'PINEAPPLE', 'STOBERRY', 'BANANA'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY NOTES PINNED ON THE NOTICE BOARD ?',
        options: ['6', '5', '7', '8'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY CHAIRS ARE IN THE CLASS ROOM?',
        options: ["6", "8", "9", "7"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHERE IS THE GLOB?',
        options: [
          "ON THE RACK",
          "IN THE RACK",
          "ON THE TABLE",
          "IN THE CUPBOARD"
        ],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/SherlockHolmes/5.jpg',
    questions: [
      Question(
        question: 'HOW MANY GIRLS ARE IN THE CLASS EXCEPT TEACHER ?',
        options: ["3", "2", "4", "1"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE BOOK HOLD BY TEACHER ?',
        options: ['GREEN', 'BLUE', 'PINK', 'RED'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY KIDS HAS WEAR SPECTS ?',
        options: ['1', '2', '3', 'NONE'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'ACCORDING TO YOU,WHICH HAND IS UP OF ALL KIDS? ',
        options: ["RIGHT", "LEFT", "NONE", "BOTH"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY WINDOWS ARE IN THE CLASS?',
        options: ['1', '2', '4', 'NONE'],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/SherlockHolmes/6.jpg',
    questions: [
      Question(
        question:
            'If a train travels at 75 miles per hour, how long will it take to cover a distance of 225 miles?',
        options: ["2 hours", "3 hours", "4 hours", "5 hours"],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the capital of Australia?',
        options: ['Sydney', 'Melbourne', 'Canberra', 'Brisbane'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'Which country is known as the Land of the Rising Sun?',
        options: ['China', 'South Korea', 'Japan', 'Vietnam'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the square root of 144?',
        options: ["10", "12", "14", "16"],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'Who discovered penicillin?',
        options: [
          'Alexander Fleming',
          'Marie Curie',
          'Louis Pasteur',
          'Joseph Lister'
        ],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/SherlockHolmes/7.jpg',
    questions: [
      Question(
        question:
            'If a train travels at 75 miles per hour, how long will it take to cover a distance of 225 miles?',
        options: ["2 hours", "3 hours", "4 hours", "5 hours"],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the capital of Australia?',
        options: ['Sydney', 'Melbourne', 'Canberra', 'Brisbane'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'Which country is known as the Land of the Rising Sun?',
        options: ['China', 'South Korea', 'Japan', 'Vietnam'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the square root of 144?',
        options: ["10", "12", "14", "16"],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'Who discovered penicillin?',
        options: [
          'Alexander Fleming',
          'Marie Curie',
          'Louis Pasteur',
          'Joseph Lister'
        ],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/SherlockHolmes/8.jpg',
    questions: [
      Question(
        question:
            'If a train travels at 75 miles per hour, how long will it take to cover a distance of 225 miles?',
        options: ["2 hours", "3 hours", "4 hours", "5 hours"],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the capital of Australia?',
        options: ['Sydney', 'Melbourne', 'Canberra', 'Brisbane'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'Which country is known as the Land of the Rising Sun?',
        options: ['China', 'South Korea', 'Japan', 'Vietnam'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the square root of 144?',
        options: ["10", "12", "14", "16"],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'Who discovered penicillin?',
        options: [
          'Alexander Fleming',
          'Marie Curie',
          'Louis Pasteur',
          'Joseph Lister'
        ],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/SherlockHolmes/9.jpg',
    questions: [
      Question(
        question:
            'If a train travels at 75 miles per hour, how long will it take to cover a distance of 225 miles?',
        options: ["2 hours", "3 hours", "4 hours", "5 hours"],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the capital of Australia?',
        options: ['Sydney', 'Melbourne', 'Canberra', 'Brisbane'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'Which country is known as the Land of the Rising Sun?',
        options: ['China', 'South Korea', 'Japan', 'Vietnam'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the square root of 144?',
        options: ["10", "12", "14", "16"],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'Who discovered penicillin?',
        options: [
          'Alexander Fleming',
          'Marie Curie',
          'Louis Pasteur',
          'Joseph Lister'
        ],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/SherlockHolmes/10.jpg',
    questions: [
      Question(
        question:
            'If a train travels at 75 miles per hour, how long will it take to cover a distance of 225 miles?',
        options: ["2 hours", "3 hours", "4 hours", "5 hours"],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the capital of Australia?',
        options: ['Sydney', 'Melbourne', 'Canberra', 'Brisbane'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'Which country is known as the Land of the Rising Sun?',
        options: ['China', 'South Korea', 'Japan', 'Vietnam'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the square root of 144?',
        options: ["10", "12", "14", "16"],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'Who discovered penicillin?',
        options: [
          'Alexander Fleming',
          'Marie Curie',
          'Louis Pasteur',
          'Joseph Lister'
        ],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/SherlockHolmes/11.jpg',
    questions: [
      Question(
        question: 'HOW MANY GIRLS ARE SITTING IN THE PICTURE?',
        options: ["2", "3", "4", "1"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY BOYS WEAR CAP?',
        options: ["1", "2", "NONE", "ALL"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY TREES ARE THERE?',
        options: ["3", "2", "1", "4"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'THE GIRL WHO TRY TO CATCH BUTTERFLY ,WHAT IS THE COLOR OF HER HAIR?',
        options: ["RED", "BROWN", "BLACK", "GOLDEN"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY KIDS ARE STANDING IN THE PICTURE?',
        options: ["3", "2", "4", "NONE"],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/SherlockHolmes/12.jpg',
    questions: [
      Question(
        question: 'HOW MANY LAPTOPS ARE ON THE TABLE?',
        options: ['2', '1', '3', 'NONE'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY DRAWERS THE CUPBOARD HAVE?',
        options: ['5', '4', '6', '3'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHAT TIME SHOWN IN THE CLOCK?',
        options: ['12:15', '12:30', '12:45', '12:00'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHO WEAR SPECTS?',
        options: ['BOTH', 'THE GIRL', 'THE BOY', 'NONE'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY LAMPS ARE SEEN IN THE PICTURE?',
        options: ['2', '3', '4', 'NONE'],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/SherlockHolmes/13.jpg',
    questions: [
      Question(
        question: 'ACCORDING TO YOU, WHICH SIDE THE SIGN BOARD OF BUS STOP  IS?',
        options: ["RIGHT", "LEFT", "BOTH SIDE", "NOWHERE"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'THE BOY WITH GREEN TSHIRT , WHAT IS IN HIS HANDS?',
        options: ["MOBILE", "BOOK", "NOTHING", "BAG"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY BOYS IN THE PICTURE?',
        options: ["3", "2", "4", "1"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY BOYS WEAR WHITE SHIRT?',
        options: ["2", "1", "3", "NONE"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY GIRL WEAR SPECTS?',
        options: ["1", "2", "ALL", "NONE"],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/SherlockHolmes/14.jpg',
    questions: [
      Question(
        question: 'HOW MANY STREET LAMP ARE SEEN IN THE PICTURE?',
        options: ['3', '6', '5', '4'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY FAMILY DOING SKETTING ? ', //Wrong Question
        options: ['1', '2', 'NONE', '4'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHICH PET IS SEEN IN THE PICTURE ?',
        options: ['DOG', 'CAT', 'PARROT', 'NONE'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'EACH FAMILY HAVE 1 KID ONLY.   TRUE OR FALSE',
        options: ["FALSE", "TRUE", "9", "7"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY BANCHES ARE IN THE PARK?',
        options: [
          "ON THE RACK",
          "IN THE RACK",
          "ON THE TABLE",
          "IN THE CUPBOARD"
        ],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/SherlockHolmes/15.jpg',
    questions: [
      Question(
        question: 'HOW MANY GIRLS ARE IN THE CLASS EXCEPT TEACHER ?',
        options: ["3", "2", "4", "1"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE BOOK HOLD BY TEACHER ?',
        options: ['GREEN', 'BLUE', 'PINK', 'RED'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY KIDS HAS WEAR SPECTS ?',
        options: ['1', '2', '3', 'NONE'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'ACCORDING TO YOU,WHICH HAND IS UP OF ALL KIDS? ',
        options: ["RIGHT", "LEFT", "NONE", "BOTH"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY WINDOWS ARE IN THE CLASS?',
        options: ['1', '2', '4', 'NONE'],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/SherlockHolmes/16.jpg',
    questions: [
      Question(
        question:
            'If a train travels at 75 miles per hour, how long will it take to cover a distance of 225 miles?',
        options: ["2 hours", "3 hours", "4 hours", "5 hours"],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the capital of Australia?',
        options: ['Sydney', 'Melbourne', 'Canberra', 'Brisbane'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'Which country is known as the Land of the Rising Sun?',
        options: ['China', 'South Korea', 'Japan', 'Vietnam'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the square root of 144?',
        options: ["10", "12", "14", "16"],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'Who discovered penicillin?',
        options: [
          'Alexander Fleming',
          'Marie Curie',
          'Louis Pasteur',
          'Joseph Lister'
        ],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/SherlockHolmes/17.jpg',
    questions: [
      Question(
        question:
            'If a train travels at 75 miles per hour, how long will it take to cover a distance of 225 miles?',
        options: ["2 hours", "3 hours", "4 hours", "5 hours"],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the capital of Australia?',
        options: ['Sydney', 'Melbourne', 'Canberra', 'Brisbane'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'Which country is known as the Land of the Rising Sun?',
        options: ['China', 'South Korea', 'Japan', 'Vietnam'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the square root of 144?',
        options: ["10", "12", "14", "16"],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'Who discovered penicillin?',
        options: [
          'Alexander Fleming',
          'Marie Curie',
          'Louis Pasteur',
          'Joseph Lister'
        ],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/SherlockHolmes/18.jpg',
    questions: [
      Question(
        question:
            'If a train travels at 75 miles per hour, how long will it take to cover a distance of 225 miles?',
        options: ["2 hours", "3 hours", "4 hours", "5 hours"],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the capital of Australia?',
        options: ['Sydney', 'Melbourne', 'Canberra', 'Brisbane'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'Which country is known as the Land of the Rising Sun?',
        options: ['China', 'South Korea', 'Japan', 'Vietnam'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the square root of 144?',
        options: ["10", "12", "14", "16"],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'Who discovered penicillin?',
        options: [
          'Alexander Fleming',
          'Marie Curie',
          'Louis Pasteur',
          'Joseph Lister'
        ],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/SherlockHolmes/19.jpg',
    questions: [
      Question(
        question:
            'If a train travels at 75 miles per hour, how long will it take to cover a distance of 225 miles?',
        options: ["2 hours", "3 hours", "4 hours", "5 hours"],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the capital of Australia?',
        options: ['Sydney', 'Melbourne', 'Canberra', 'Brisbane'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'Which country is known as the Land of the Rising Sun?',
        options: ['China', 'South Korea', 'Japan', 'Vietnam'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the square root of 144?',
        options: ["10", "12", "14", "16"],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'Who discovered penicillin?',
        options: [
          'Alexander Fleming',
          'Marie Curie',
          'Louis Pasteur',
          'Joseph Lister'
        ],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/SherlockHolmes/20.jpg',
    questions: [
      Question(
        question:
            'If a train travels at 75 miles per hour, how long will it take to cover a distance of 225 miles?',
        options: ["2 hours", "3 hours", "4 hours", "5 hours"],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the capital of Australia?',
        options: ['Sydney', 'Melbourne', 'Canberra', 'Brisbane'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'Which country is known as the Land of the Rising Sun?',
        options: ['China', 'South Korea', 'Japan', 'Vietnam'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'What is the square root of 144?',
        options: ["10", "12", "14", "16"],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'Who discovered penicillin?',
        options: [
          'Alexander Fleming',
          'Marie Curie',
          'Louis Pasteur',
          'Joseph Lister'
        ],
        correctAnswerIndex: 0,
      ),
    ],
  ),
];

class Question {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}
