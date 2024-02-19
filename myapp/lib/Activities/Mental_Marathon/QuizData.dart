class QuizData {
  static final List<String> topics = [
    'Numerical Aptitude',
    'Logical Reasoning',
    'Verbal Aptitude',
    'Critical Thinking',
    'Problem Solving',
    'Coding and Decoding',
  ];

  static final Map<String, List<Map<String, dynamic>>> topicQuestions = {
    'Numerical Aptitude': [
      {
        'text': 'What is the sum of 245 and 367?',
        'options': ["562", "612", "603", "611"],
        'correctAnswer': "612",
      },
      {
        'text':
            'If a shirt costs \$20 after a 25% discount, what was its original price?',
        'options': ["\$25", "\$22", "\$27", "\$30"],
        'correctAnswer': "\$25",
      },
      {
        'text': 'Simplify: (5 + 3) * 2 - 7',
        'options': ["15", "13", "11", "9"],
        'correctAnswer': "11",
      },
      {
        'text': 'Calculate the product of 18 and 25.',
        'options': ["400", "425", "450", "475"],
        'correctAnswer': "450"
      },
      {
        'text': 'Find the quotient of 144 divided by 12.',
        'options': ["10", "12", "14", "16"],
        'correctAnswer': "12"
      },
    ],
    'Logical Reasoning': [
      {
        'text':
            'If all cats are mammals and some mammals are black, can we conclude that some cats are black?',
        'options': ["Yes", "No", "Maybe", "Not sure"],
        'correctAnswer': "Yes",
      },
      {
        'text': 'What comes next in the sequence: 2, 4, 8, 16, ___?',
        'options': ["32", "24", "20", "18"],
        'correctAnswer': "32",
      },
      {
        'text':
            'If Jane is twice as old as Jack and Jack is 20 years old, how old is Jane?',
        'options': ["30", "40", "50", "60"],
        'correctAnswer': "40",
      },
      {
        'text':
            'If a train travels at 60 miles per hour, how long will it take to cover a distance of 120 miles?',
        'options': ["1 hour", "2 hours", "3 hours", "4 hours"],
        'correctAnswer': "2 hours"
      },
      {
        'text':
            'If a bookshelf has 5 shelves and each shelf can hold 10 books, how many books can the bookshelf hold in total?',
        'options': ["25", "30", "40", "50"],
        'correctAnswer': "50"
      },
    ],
    'Verbal Aptitude': [
      {
        'text': 'What is the synonym of "Benevolent"?',
        'options': ["Kind", "Angry", "Lazy", "Clever"],
        'correctAnswer': "Kind",
      },
      {
        'text': 'Choose the correctly spelled word:',
        'options': ["Accomodate", "Acommodate", "Accommodate", "Accommodatte"],
        'correctAnswer': "Accommodate",
      },
      {
        'text': 'What is the opposite of "Diligent"?',
        'options': ["Lazy", "Smart", "Careful", "Honest"],
        'correctAnswer': "Lazy",
      },
      {
        'text': 'Find the antonym of Eloquent.',
        'options': ["Articulate", "Inarticulate", "Verbose", "Loquacious"],
        'correctAnswer': "Inarticulate"
      },
      {
        'text': 'What is the synonym of Meticulous?',
        'options': ["Careful", "Sloppy", "Careless", "Negligent"],
        'correctAnswer': "Careful"
      },
    ],
    'Critical Thinking': [
      {
        'text': 'What is a common logical fallacy?',
        'options': [
          "Strawman",
          "Hasty Generalization",
          "Ad Hominem",
          "All of the above"
        ],
        'correctAnswer': "All of the above",
      },
      {
        'text':
            'In a group of 100 people, 99 have a bachelor\'s degree. What can you conclude?',
        'options': [
          "All have master's degrees",
          "One doesn't have a bachelor's degree",
          "Nothing"
        ],
        'correctAnswer': "Nothing",
      },
      {
        'text':
            'If all birds can fly and a penguin is a bird, can a penguin fly?',
        'options': ["Yes", "No", "Depends on the species", "Not sure"],
        'correctAnswer': "No",
      },
      {
        'text':
            'If all roses are flowers and some flowers fade quickly, can all roses be said to fade quickly?',
        'options': ["Yes", "No", "Depends on the type of rose", "Not sure"],
        'correctAnswer': "No"
      },
      {
        'text':
            'If all lawyers can argue well and Jane is a lawyer, does it mean Jane always wins arguments?',
        'options': ["Yes", "No", "Depends on Jane's experience", "Not sure"],
        'correctAnswer': "No"
      },
    ],
    'Problem Solving': [
      {
        'text':
            'How many ways are there to arrange the letters in the word "PROBLEM"?',
        'options': ["720", "120", "5040", "240"],
        'correctAnswer': "720",
      },
      {
        'text': 'If a train travels at 60 mph, how far will it go in 3 hours?',
        'options': ["120 miles", "180 miles", "200 miles", "220 miles"],
        'correctAnswer': "180 miles",
      },
      {
        'text': 'What is the missing number: 2, 5, 10, __, 26',
        'options': ["12", "15", "18", "20"],
        'correctAnswer': "18",
      },
      {
        'text':
            'A rectangular garden has a length of 15 meters and a width of 10 meters. What is the area of the garden?',
        'options': [
          "100 sq meters",
          "150 sq meters",
          "200 sq meters",
          "250 sq meters"
        ],
        'correctAnswer': "150 sq meters"
      },
      {
        'text':
            'If a car travels at a speed of 60 miles per hour, how long will it take to cover a distance of 180 miles?',
        'options': ["2 hours", "3 hours", "4 hours", "5 hours"],
        'correctAnswer': "3 hours"
      },
    ],
    'Coding and Decoding': [
      {
        'text': 'If "APPLE" is coded as "53133", how is "ORANGE" coded?',
        'options': ["182051", "152051", "182501", "152501"],
        'correctAnswer': "182501",
      },
      {
        'text':
            'Decode the following: "RSTUV" is coded as "NOPQR". What is "XYZ"?',
        'options': ["ABC", "UVW", "DEF", "MNO"],
        'correctAnswer': "ABC",
      },
      {
        'text': 'If "CHAIR" is coded as "98761", how is "TABLE" coded?',
        'options': ["28145", "28451", "28751", "28541"],
        'correctAnswer': "28451",
      },
      {
        'text': 'If "WATER" is coded as "231205", how is "FIRE" coded?',
        'options': ["69218", "61218", "69281", "61281"],
        'correctAnswer': "61218"
      },
      {
        'text': 'If "MANGO" is coded as "719614", how is "PEACH" coded?',
        'options': ["65138", "63158", "65183", "63183"],
        'correctAnswer': "63183"
      },
    ],
  };
}
