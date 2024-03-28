class QuizData {
  final String imagePath;
  final List<Question> questions;

  QuizData({required this.imagePath, required this.questions});
}

List<QuizData> quizDataList = [
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/1.jpg',
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
    imagePath: 'assets/Images/SherlockHolmes/2.jpg',
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
    imagePath: 'assets/Images/SherlockHolmes/3.jpg',
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
    imagePath: 'assets/Images/SherlockHolmes/4.jpg',
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
        options: ['7', '5', '6', '8'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'HOW MANY CHAIRS ARE IN THE CLASS ROOM?',
        options: ["7", "8", "9", "6"],
        correctAnswerIndex: 3,
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
    imagePath: 'assets/Images/SherlockHolmes/5.jpg',
    questions: [
      Question(
        question: 'HOW MANY GIRLS ARE IN THE CLASS EXCEPT TEACHER ?',
        options: ["2", "3", "4", "1"],
        correctAnswerIndex: 1,
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
        options: ["NONE", "LEFT", "RIGHT", "BOTH"],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'HOW MANY WINDOWS ARE IN THE CLASS?',
        options: ['4', '2', '1', 'NONE'],
        correctAnswerIndex: 2,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/6.jpg',
    questions: [
      Question(
        question: 'HOW MANY PHOTOFRAME IN THE PICTURE?',
        options: ["NONE", "3", "4", "2"],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'WHAT FOOD ITEM IS ON THE TABLE?',
        options: ['BURGER', 'PIZZA', 'SANDWICH', 'CAKE'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHERE IS BOWL ?',
        options: [
          'ON THE  FLOOR',
          'ON THE TABLE',
          'UNDER THE TABLE',
          'NOWHERE'
        ],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF A CUP BOARD?',
        options: ["GREEN", "BLUE", "PURPLE", "YELLOW"],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'WHAT IS CAT DOING?',
        options: ['EATING', 'PLAYING', 'SLEEPING', 'DRINKING'],
        correctAnswerIndex: 2,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/7.jpg',
    questions: [
      Question(
        question: 'WHAT IS THE COLOR OF THE CYCLE?',
        options: ["BLACK", "YELLOW", "BLUE", "RED"],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'HOW MANY TREE SEEN IN THE PICTURE?',
        options: ['5', '3', '4', '1'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'WHO RUN THE BICYCLE?',
        options: ['GIRL', 'BOY', 'KID', 'NONE'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE HOUSE?',
        options: ["GREY", "BLACK", "YELLOW", "GREEN"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY CAR SEEN IN THE PICTURE?',
        options: ['4', '2', '3', '1'],
        correctAnswerIndex: 1,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/8.jpg',
    questions: [
      Question(
        question: 'WHAT IS THE COLOR OF SOFA?',
        options: ["BLUE", "PURPLE", "PINK", "RED"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE LAMP',
        options: ['GREEN', 'PINK', 'RED', 'WHITE'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE WALL?',
        options: ['PURPLE', 'PINK', 'YELLOW', 'CREAM'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'ACCORDING TO YOU, WHICH SIDE THE PURSE IS ?',
        options: ["RIGHT", "LEFT"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'THE LAMP IS ON OR OFF?',
        options: ['ON', 'OFF'],
        correctAnswerIndex: 1,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/9.jpg',
    questions: [
      Question(
        question: 'HOW MANY CUSHION ON THE SOFA?',
        options: ["4", "7", "5", "6"],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'WHAT ISN\'T ON OR UNDER THE TABLE ?',
        options: ['WATER BOTTLE', 'ICE CREAM BOWL', 'BOOK', 'FLOWER POT'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY SINGLE SOFA CHAIR IN THE PICTURE?',
        options: ['1', '4', '2', 'NONE'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'WHAT IS COLOR OF THE CARPET ?',
        options: ["MULTI COLOR", "BLUE", "RED", "GREEN"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE SOFA?',
        options: ['RED', 'BLUE', 'PURPLE', 'YELLOW'],
        correctAnswerIndex: 2,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/10.jpg',
    questions: [
      Question(
        question: 'WHAT IS THE COLOR OF THE GUITAR ?',
        options: ["RED", "GREEN", "YELLOW", "BLACK"],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'HOW MANY BOYS ARE IN THE PICTURE?',
        options: ['3', '4', '5', '2'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'THE BOY WITH RED CAP, WHAT DID HE DRAW ?',
        options: ['HOUSE', 'FLOWER', 'TREE', 'ROBOT'],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'HOW MANY BOYS WERA CAP?',
        options: ["4", "2", "ALL", "NONE"],
        correctAnswerIndex: 1,
      ),
      Question(
        question:
            'ACCORDING TO YOU, THE BOY WHO IS SITTING IN THE PICTURE IS RIGHT SIDE. TRUE/FLASE ?',
        options: ['FALSE', 'TRUE'],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/11.jpg',
    questions: [
      Question(
        question: 'HOW MANY GIRLS ARE SITTING IN THE PICTURE?',
        options: ["4", "3", "2", "1"],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'HOW MANY BOYS WEAR CAP?',
        options: ["2", "1", "NONE", "ALL"],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'HOW MANY TREES ARE THERE?',
        options: ["3", "2", "1", "4"],
        correctAnswerIndex: 0,
      ),
      Question(
        question:
            'THE GIRL WHO TRY TO CATCH BUTTERFLY ,WHAT IS THE COLOR OF HER HAIR?',
        options: ["RED", "BROWN", "BLACK", "GOLDEN"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY KIDS ARE STANDING IN THE PICTURE?',
        options: ["4", "2", "3", "NONE"],
        correctAnswerIndex: 2,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/12.jpg',
    questions: [
      Question(
        question: 'HOW MANY LAPTOPS ARE ON THE TABLE?',
        options: ['3', '1', '2', 'NONE'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'HOW MANY DRAWERS THE CUPBOARD HAVE?',
        options: ['3', '4', '6', '5'],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'WHAT TIME SHOWN IN THE CLOCK?',
        options: ['12:15', '12:30', '12:45', '12:00'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHO WEAR SPECTS?',
        options: ['THE GIRL', 'BOTH', 'THE BOY', 'NONE'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'HOW MANY LAMPS ARE SEEN IN THE PICTURE?',
        options: ['3', '2', '4', 'NONE'],
        correctAnswerIndex: 1,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/13.jpg',
    questions: [
      Question(
        question:
            'ACCORDING TO YOU, WHICH SIDE THE SIGN BOARD OF BUS STOP  IS?',
        options: ["RIGHT", "LEFT", "BOTH SIDE", "NOWHERE"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'THE BOY WITH GREEN TSHIRT , WHAT IS IN HIS HANDS?',
        options: ["NOTHING", "BOOK", "MOBILE", "BAG"],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'HOW MANY BOYS IN THE PICTURE?',
        options: ["1", "2", "4", "3"],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'HOW MANY BOYS WEAR WHITE SHIRT?',
        options: ["1", "2", "3", "NONE"],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'HOW MANY GIRL WEAR SPECTS?',
        options: ["1", "2", "ALL", "NONE"],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/14.jpg',
    questions: [
      Question(
        question: 'HOW MANY STREET LAMP ARE SEEN IN THE PICTURE?',
        options: ['3', '6', '5', '4'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY FAMILY DOING SKETTING ? ', //Wrong Question
        options: ['NONE', '1', '2', '4'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'WHICH PET IS SEEN IN THE PICTURE ?',
        options: ['PARROT', 'CAT', 'DOG', 'NONE'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'EACH FAMILY HAVE 1 KID ONLY.   TRUE OR FALSE',
        options: ["FALSE", "TRUE"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY BANCHES ARE IN THE PARK?',
        options: ["1", "2", "3", "4"],
        correctAnswerIndex: 2,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/15.jpg',
    questions: [
      Question(
        question: 'HOW MANY STICKY NOTES ARE IN THE NOTICE BOARD?',
        options: ["3", "4", "5", "6"],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'WHAT IS COLOR OF MUG ?',
        options: ['BLUE', 'GREEN', 'RED', 'YELLOW'],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'HOW MANY WINDOWS ARE IN THE ROOM?',
        options: ['1', '2', 'NONE', '4'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE GUITAR?',
        options: ["BLUE", "GREEN", "RED", "PINK"],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'HOW MANY SPEAKER ARE IN THE ROOM?',
        options: ['1', '2', '3', '4'],
        correctAnswerIndex: 1,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/16.jpg',
    questions: [
      Question(
        question: 'HOW MANY CUSHION SEEN IN THE PICTURE ?',
        options: ["3", "2", "4", "1"],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE SOFA?',
        options: ['PURPLE', 'GREEN', 'YELLOW', 'RED'],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE WALL?',
        options: ['SKY BLUE', 'PURPLE', 'PINK', 'GREEN'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY DOOR AND WINDOW SHOWN IN THE PICTURE?',
        options: ["1", "2", "3", "NONE"],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'THE WOODEN CHAIR IS WHICH SIDE OF THE ROOM?',
        options: ['RIGHT', 'LEFT'],
        correctAnswerIndex: 1,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/17.jpg',
    questions: [
      Question(
        question: 'WHAT IS THE COLOR OF TV?',
        options: ["GREEN", "RED", "BLUE", "YELLOW"],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'HOW MANY STAR HANGING FROM THE CILLING?',
        options: ['3', '4', '2', '1'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHICH COLOR CAR LAYING IN THE MIDDLE OF THE ROOM?',
        options: ['BLUE', 'RED', 'YELLOW', 'GREEN'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'WHERE IS THE GUITAR?',
        options: [
          "NEAR THE SOFA",
          "NEAR THE WINDOW ",
          "NEAR THE TV",
          "NOT IN PICTURE"
        ],
        correctAnswerIndex: 1,
      ),
      Question(
        question:
            'Who discovered penicillin?', // 5th Question is missing i need to make one myself.
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
    imagePath: 'assets/Images/SherlockHolmes/18.jpg',
    questions: [
      Question(
        question: 'HOW MANY WINDOWS ARE SEEN IN THE PICTURE?',
        options: ["1", "2", "4", "3"],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE TV?',
        options: ['RED', 'GREY', 'BLACK -WHITE', 'PURPLE'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE CURTAINS?',
        options: ['GREEN', 'PINK', 'WHITE', 'PURPLE'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE TABLE LAMP ?',
        options: ["BLUE", "PINK", "PURPLE", "YELLOW"],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'EACH SOFA HAS CUSHION , TRUE OR FALSE',
        options: ['TRUE', 'FALSE'],
        correctAnswerIndex: 1,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/19.jpg',
    questions: [
      Question(
        question: 'WHAT IS THE COLOR OF BEDSHEET',
        options: ["PURPLE", "GREEN", "PINK", "WHITE"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE CLOCK?',
        options: ['RED- GREEN', 'RED-PURPLE', 'RED- WHITE', 'WHITE- BLUE'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'WHAT IS WRITTEN ON THE WHITE BOARD?',
        options: ['ALPHABETS', 'NUMBERS', 'MATH FORMULA', 'NOTHING'],
        correctAnswerIndex: 3,
      ),
      Question(
        question:
            'ACCORDING TO YOU, ON WHICH SIDE CHAIR IS AVAILABLE IN THE ROOM ?', //wrong question
        options: ["RIGHT", "LEFT"],
        correctAnswerIndex: 0,
      ),
      Question(
        question:
            'WHAT IS MADE IN THE WALL ?', // wrong question or options missing
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
    imagePath: 'assets/Images/SherlockHolmes/20.jpg',
    questions: [
      Question(
        question: 'WHAT IS THE COLOR OF THE CURTAIN?',
        options: ["BLUE", "GREEN", "PURPLE", "PINK"],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'HOW MANY DRAWERS THE STUDY TABLE HAS?',
        options: ['1', '2', '3', 'NONE'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE BED SHEET ?',
        options: ['GREEN', 'BLUE', 'PURPLE', 'WHITE'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'WHERE IS THE GLOB?',
        options: ["ON STUDY TABLE", "IN THE RACK", "ON  A TABLE", "NOWHERE"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE LAMP?',
        options: ['PINK', 'YELLOW', 'BLUE', 'GREEN'],
        correctAnswerIndex: 1,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/21.jpg',
    questions: [
      Question(
        question: 'WHO IS STANDING IN THE PICTURE?',
        options: ["THE LADY", "THE GIRL", " 2 KID", "NO ONE"],
        correctAnswerIndex: 1,
      ),
      Question(
        question:
            'WHAT IS EXTRA IN PHOTOFRAME OTHER THAN FAMILY?', // wrong question
        options: ['3', '1', '2', 'NONE'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'TWO KIDS WEARING SAME COLOR TSHIRT ?   YES OR NO ',
        options: ['NO', 'YES'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'THE LADY AND HER DAUGHTER HAVE SAME COLOR CLOTHS?',
        options: [
          "YES",
          "NO",
        ],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE TSHIRT THE FATHER WEAR ?',
        options: ['RED', 'GREEN', 'PINK', 'BLACK'],
        correctAnswerIndex: 3,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/22.jpg',
    questions: [
      Question(
        question: 'WHAT IS THE COLOR OF THE CHAIR?',
        options: ["WOODEN", "BLUE", "YELLOW", "PURPLE"],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'WHAT IS WRITTEN ON THE BLACK BOARD?',
        options: ['ALPHABETS', 'SUM', 'NOTHING', 'CHEMISTRY'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE WALL?',
        options: ['GREEN', 'BLUE', 'PINK', 'WHITE'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHAT IS COLOR OF THE TEACHERS TABLE?',
        options: [
          "GREEN- WHITE",
          "PINK - WHITE",
          "BLUE- WHITE",
          "YELLOW - WHITE"
        ],
        correctAnswerIndex: 1,
      ),
      Question(
        question:
            'ACCORDING TO YOU, THE DOOR IS LEFT SIDE OF THE ROOM', //wrong question
        options: ['YELLOW', 'PINK', 'BLUE', 'GREEN'],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/23.jpg',
    questions: [
      Question(
        question: 'HOW MANY GIRLS ARE IN THE PICTURE?',
        options: ["1", "2", "3", "4"],
        correctAnswerIndex: 2,
      ),
      Question(
        question:
            'THE BOY WHO SITTING IN SINGLE CHAIR SOFA WEAR SPECTS   TRUE OR FALSE',
        options: ['TRUE', 'FALSE'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY STUDY TABLE ARE THERE?',
        options: ['1', '2', '3', 'NONE'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'THE GIRL NEAR THE BOY , HOW MANY BOOK SHE HAS?',
        options: ["2", "4", "1", "3"],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'WHAT TIME SHOWN IN THE CLOCK?',
        options: ['08:00', '07:00', '06:00', '05:00'],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/24.jpg',
    questions: [
      Question(
        question: 'WHAT IS COLOR OF WALL?',
        options: ["PINK", "PURPLE", "SKY BLUE", "WHITE"],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'HOW MANY GLASSES ON THE TABLE?',
        options: ['3', '2', '1', 'NONE'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHAT IS  ON THE TABLE RATHER THAN WATER JUG AND GLASSES',
        options: ['SANDWITCH', 'BURGER', 'PIZZA', 'FRUITS'],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'HOW MANY LAMPS IN THE ROOM?',
        options: ['1', '2', '3', 'NONE'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'THERE IS CELLING FAN. TRUE OR FALSE', //wrong question
        options: ['YELLOW', 'PINK', 'BLUE', 'GREEN'],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/25.jpg',
    questions: [
      Question(
        question: 'WHAT IS THE COLOR OF THE TOY CAR?',
        options: ["YELLOW", "RED", "GREEN", "BLUE"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHICH COLOR THE CURTAINS HAVE?',
        options: ["GREEN", "PINK", "WHITE", "PURPLE"],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'WHAT IS IN THE BASKET OR BUCKET ?',
        options: ['CAR', 'TEDDY', 'DOLL', 'BOOKS'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF LAMP?',
        options: [
          "PINK- WHITE",
          "BLUE- WHITE",
          "PURPLE- WHITE",
          "GREEN- WHITE"
        ],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'HOW MANY WAGES THE TOY TRAIN HAS?',
        options: ['2', '3', '4', 'NONE'],
        correctAnswerIndex: 1,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/26.jpg',
    questions: [
      Question(
        question: 'HOW MANY HOUSES IN THE PICTURE?',
        options: ['3', '4', '5', '6'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'WHO ARE PLAYING WITH BALL?',
        options: ['2 GIRLS', '2 BOYS', '1 GIRL 1 BOY', '2  BOY 1 GIRL'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY KIDS ARE PLAYING?',
        options: ['5', '6', '7', '8'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'WHICH COLOR HOUSE IS NOT THERE?',
        options: ['YELLOW', 'RED', 'GREEN', 'PURPLE'],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'WHICH COLOR THE SLIDER HAS?',
        options: ['RED', 'BLUE', 'GREEN', 'YELLOW'],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/27.jpg',
    questions: [
      Question(
        question: 'WHO IS ON THE BED?',
        options: ["TEDDY", "BOY", "GIRL", "NONE"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'HOW MANY BOOKS ON THE STUDY TABLE?',
        options: ['4', '2', '3', 'NONE'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF NOTICE BOARD ?',
        options: ['PINK', 'RED', 'BLACK', 'GREEN'],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'HOW MANY DRAWERS THE BED HAS?',
        options: ['2', '3', '4', 'NONE'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE CLOCK?',
        options: [
          'YELLOW- WHITE',
          'YELLOW - RED',
          'WHITE -RED',
          'WHITE - PINK'
        ],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/28.jpg',
    questions: [
      Question(
        question: 'HOW MANY BED ARE IN THE ROOM',
        options: ['1', '3', '2', 'NONE'],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'WHAT TIME SEEN IN THE CLOCK?',
        options: ['03:00', '12:15', '02:00', '09:00'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHAT COLOR THE BAG HAS WHICH IS ON THE TABLE?',
        options: ['GREEN', 'RED', 'YELLOW', 'BLUE'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'WHOSE PICTURE IS STICK ON THE WALL?',
        options: ["ROBOT", "GIRAFFE", "LION", "ELEPHANT"],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'WHO IS ON THE BED?',
        options: ['RABBIT', 'DOG', 'DOLL', 'KID'],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/29.jpg',
    questions: [
      Question(
        question: 'WHAT KIDS ARE DOING?',
        options: ["READING", "PLAYING", "SLEEPING", "EATING"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'IT’S A MORNING TIME OR NIGHT TIME?',
        options: ['MORNING', 'NIGHT'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'WHAT IS COLOR OF CURTAIN?',
        options: ['BLUE', 'PINK', 'YELLOW', 'PURPLE'],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'WHAT IS IN THE RACK?',
        options: ["GLOB", "TOYS", "BOOKS", "PHOTO FRAME"],
        correctAnswerIndex: 2,
      ),
      Question(
        question: 'WHAT IS ON THE TABLE ?',
        options: ['ROBOT', 'BOOK', 'JUG', 'LAPTOP'],
        correctAnswerIndex: 0,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/30.jpg',
    questions: [
      Question(
        question: 'HOW MANY PILLOW ON THE BED?',
        options: ['1', '2', '3', 'NONE'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'WHAT IS A BOY DOING?',
        options: [
          'READING BOOK',
          'PLAYING WITH TOYS',
          'PLAYING WITH  PHONE',
          'PLAYING WITH BALL'
        ],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'WHAT IS WRITTEN ON THE BOX WHICH LAY DOWN NEAR BED?',
        options: ['TOY BOX', 'TOOL BOX', 'TOYS', 'BOX'],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHAT IS ON THE CUPBOARD ?',
        options: ["TOYS", "FOOTBALL", "BOOKS", "PHOTO FRAME"],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'WHICH COLOR TSHIRT THE BOY WEAR?',
        options: ['GREEN', 'PURPLE', 'RED', 'PINK'],
        correctAnswerIndex: 2,
      ),
    ],
  ),
  QuizData(
    imagePath: 'assets/Images/SherlockHolmes/31.jpg',
    questions: [
      Question(
        question: 'WHAT IS THE COLOR O THE LAMP?',
        options: ['BLACK', 'GREEN', 'YELLOW', 'RED'],
        correctAnswerIndex: 3,
      ),
      Question(
        question: 'WHAT IS UNDER THE TABLE?',
        options: ['DUSTBIN', 'BALL', 'DOG', 'TOYS '],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF PEN STAND?',
        options: ['BLACK', 'YELLOW', 'GREEN', 'RED'],
        correctAnswerIndex: 1,
      ),
      Question(
        question: 'WHAT TIME SEEN IN THE CLOCK?',
        options: ["04:00", "05:00", "03:00", "10:00"],
        correctAnswerIndex: 0,
      ),
      Question(
        question: 'WHAT IS THE COLOR OF THE CHAIR?',
        options: ['BLACK', 'WHITE', 'BROWN', 'YELLOW'],
        correctAnswerIndex: 2,
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
