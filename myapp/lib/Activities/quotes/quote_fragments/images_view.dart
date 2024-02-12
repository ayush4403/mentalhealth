import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class ImageWithText extends StatefulWidget {
  final String queryname;

  const ImageWithText({super.key, required this.queryname});

  @override
  _ImageWithTextState createState() => _ImageWithTextState();
}

class _ImageWithTextState extends State<ImageWithText> {
  late Future<List<Map<String, dynamic>>> _imageData;
  final _random = Random();
  Map<String, List<String>> quoteMap = {
    'Motivation': [
      "The only way to do great work is to love what you do. – Steve Jobs",
      "Your time is limited, don’t waste it living someone else’s life. – Steve Jobs",
      "I am not a product of my circumstances. I am a product of my decisions. – Stephen R. Covey",
      "The best revenge is massive success. – Frank Sinatra",
      "You miss 100% of the shots you don’t take. – Wayne Gretzky",
      "The future belongs to those who believe in the beauty of their dreams. – Eleanor Roosevelt",
      "Don’t watch the clock; do what it does. Keep going. – Sam Levenson",
      "The only limit to our realization of tomorrow will be our doubts of today. – Franklin D. Roosevelt",
      "You are never too old to set another goal or to dream a new dream. – C.S. Lewis",
      "The only way to do great work is to love what you do. – Steve Jobs",
    ],
    'Education': [
      "Education is the passport to the future, for tomorrow belongs to those who prepare for it today. – Malcolm X",
      "The roots of education are bitter, but the fruit is sweet. – Aristotle",
      "Education is the most powerful weapon which you can use to change the world. – Nelson Mandela",
      "The only person who is educated is the one who has learned how to learn …and change. – Carl Rogers",
      "Education is not the filling of a pail, but the lighting of a fire. – William Butler Yeats",
      "The beautiful thing about learning is that no one can take it away from you. – B.B. King",
      "An investment in knowledge pays the best interest. – Benjamin Franklin",
      "Education is the key to unlock the golden door of freedom. – George Washington Carver",
      "The function of education is to teach one to think intensively and to think critically. Intelligence plus character – that is the goal of true education. – Martin Luther King Jr.",
      "The mind is not a vessel to be filled, but a fire to be kindled. – Plutarch",
    ],
    'Diet': [
      "Take care of your body. It’s the only place you have to live. – Jim Rohn",
      "Let food be thy medicine and medicine be thy food. – Hippocrates",
      "Your diet is a bank account. Good food choices are good investments. – Bethenny Frankel",
      "The food you eat can be either the safest and most powerful form of medicine or the slowest form of poison. – Ann Wigmore",
      "The greatest wealth is health. – Virgil",
      "You are what you eat. – Anthelme Brillat-Savarin",
      "The doctor of the future will no longer treat the human frame with drugs, but rather will cure and prevent disease with nutrition. – Thomas Edison",
      "To eat is a necessity, but to eat intelligently is an art. – La Rochefoucauld",
      "Let food be thy medicine and medicine be thy food. – Hippocrates",
      "Your diet is a bank account. Good food choices are good investments. – Bethenny Frankel",
    ],
    'Financial': [
      "Money often costs too much. – Ralph Waldo Emerson",
      "The lack of money is the root of all evil. – Mark Twain",
      "The art is not in making money, but in keeping it. – Proverb",
      "The safe way to double your money is to fold it over and put it in your pocket. – Kin Hubbard",
      "A simple fact that is hard to learn is that the time to save money is when you have some. – Joe Moore",
      "A wise person should have money in their head, but not in their heart. – Jonathan Swift",
      "Money can’t buy happiness, but it will certainly get you a better class of memories. – Ronald Reagan",
      "The stock market is filled with individuals who know the price of everything, but the value of nothing. – Phillip Fisher",
      "Money is only a tool. It will take you wherever you wish, but it will not replace you as the driver. – Ayn Rand",
      "Too many people spend money they earned..to buy things they don’t want..to impress people that they don’t like. – Will Rogers",
    ],
    'Fitness': [
      "The last three or four reps is what makes the muscle grow. This area of pain divides a champion from someone who is not a champion. – Arnold Schwarzenegger",
      "The only bad workout is the one that didn’t happen. – Unknown",
      "The clock is ticking. Are you becoming the person you want to be? – Greg Plitt",
      "Whether you think you can, or you think you can’t, you’re right. – Henry Ford",
      "Success usually comes to those who are too busy to be looking for it. – Henry David Thoreau",
      "The only place where success comes before work is in the dictionary. – Vidal Sassoon",
      "The successful warrior is the average man, with laser-like focus. – Bruce Lee",
      "Success is walking from failure to failure with no loss of enthusiasm. – Winston Churchill",
      "We are what we repeatedly do. Excellence, then, is not an act, but a habit. – Aristotle",
      "The only way to do great work is to love what you do. – Steve Jobs",
    ],
    'Mental Health': [
      "You are braver than you believe, stronger than you seem, and smarter than you think. – A.A. Milne",
      "Your present circumstances don’t determine where you can go; they merely determine where you start. – Nido Qubein",
      "Success is not final, failure is not fatal: It is the courage to continue that counts. – Winston Churchill",
      "Hardships often prepare ordinary people for an extraordinary destiny. – C.S. Lewis",
      "Believe you can and you're halfway there. – Theodore Roosevelt",
      "What you get by achieving your goals is not as important as what you become by achieving your goals. – Zig Ziglar",
      "Keep your face always toward the sunshine—and shadows will fall behind you. – Walt Whitman",
      "It does not matter how slowly you go as long as you do not stop. – Confucius",
      "You are never too old to set another goal or to dream a new dream. – C.S. Lewis",
      "The only way to do great work is to love what you do. – Steve Jobs",
    ],
    'Self Improvement': [
      "The only way to do great work is to love what you do. – Steve Jobs",
      "Success is not the key to happiness. Happiness is the key to success. If you love what you are doing, you will be successful. – Albert Schweitzer",
      "Your time is limited, don’t waste it living someone else’s life. – Steve Jobs",
      "The best way to predict the future is to create it. – Peter Drucker",
      "You don’t have to be great to start, but you have to start to be great. – Zig Ziglar",
      "The only limit to our realization of tomorrow will be our doubts of today. – Franklin D. Roosevelt",
      "Life is 10% what happens to us and 90% how we react to it. – Charles R. Swindoll",
      "The best time to plant a tree was 20 years ago. The second best time is now. – Chinese Proverb",
      "If you want to achieve greatness stop asking for permission. – Anonymous",
      "The only way to do great work is to love what you do. – Steve Jobs",
    ],
    'Social Life': [
      "In the end, we will remember not the words of our enemies, but the silence of our friends. – Martin Luther King Jr.",
      "Friendship is born at that moment when one person says to another, 'What! You too? I thought I was the only one. – C.S. Lewis",
      "A friend is someone who knows all about you and still loves you. – Elbert Hubbard",
      "A true friend never gets in your way unless you happen to be going down. – Arnold H. Glasow",
      "Friendship is the only cement that will ever hold the world together. – Woodrow Wilson",
      "I would rather walk with a friend in the dark, than alone in the light. – Helen Keller",
      "Lots of people want to ride with you in the limo, but what you want is someone who will take the bus with you when the limo breaks down. – Oprah Winfrey",
      "Friendship is the hardest thing in the world to explain. It’s not something you learn in school. But if you haven’t learned the meaning of friendship, you really haven’t learned anything. – Muhammad Ali",
      "True friendship comes when the silence between two people is comfortable. – David Tyson Gentry",
      "A friend is one that knows you as you are, understands where you have been, accepts what you have become, and still, gently allows you to grow. – William Shakespeare",
    ],
    'Productivity': [
      "The way to get started is to quit talking and begin doing. – Walt Disney",
      "You don’t have to be great to start, but you have to start to be great. – Zig Ziglar",
      "The only limit to our realization of tomorrow will be our doubts of today. – Franklin D. Roosevelt",
      "Don’t watch the clock; do what it does. Keep going. – Sam Levenson",
      "The secret of getting ahead is getting started. – Mark Twain",
      "Well done is better than well said. – Benjamin Franklin",
      "It does not matter how slowly you go, so long as you do not stop. – Confucius",
      "You miss 100% of the shots you don’t take. – Wayne Gretzky",
      "The only way to do great work is to love what you do. – Steve Jobs",
      "Life is 10% what happens to us and 90% how we react to it. – Charles R. Swindoll",
      "Go and get your things. Dreams mean work.",
      "Power comes in response to a need, not a desire, You have to create that need.",
      "If you are going through hell, keep going.",
      "To win any battle, you must fight as if you are already dead.",
      "Today is the day when external things will not get the better of you. You will choose strength over weakness. courage over cowardice.",
      "Luck is what happens when preparations meets opportunity.",
      "The important thing about a problem, is not its solution, but the strength we gain finding that solution.",
      "The nearer a man comes to a calm mind, the closer he is to strength.",
      "In the midst of chaos, there is also opportunity.",
      "The man who loves walking will go further than the man who loves the destination.",
    ],
    'Career': [
      "Choose a job you love, and you will never have to work a day in your life. – Confucius",
      "The only way to do great work is to love what you do. – Steve Jobs",
      "Success is not the key to happiness. Happiness is the key to success. If you love what you are doing, you will be successful. – Albert Schweitzer",
      "Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. – Steve Jobs",
      "The future belongs to those who believe in the beauty of their dreams. – Eleanor Roosevelt",
      "I never dreamed about success. I worked for it. – Estée Lauder",
      "Don’t be afraid to give up the good to go for the great. – John D. Rockefeller",
      "Opportunities don't happen, you create them. – Chris Grosser",
      "Success is not the key to happiness. Happiness is the key to success. If you love what you are doing, you will be successful. – Albert Schweitzer",
      "The only limit to our realization of tomorrow will be our doubts of today. – Franklin D. Roosevelt",
    ],
    // Add more categories here
  };

  @override
  void initState() {
    super.initState();
    _imageData = fetchImageData();
  }

  Future<List<Map<String, dynamic>>> fetchImageData() async {
    final response = await http.get(
      Uri.parse(
          'https://api.unsplash.com/photos/random?count=10&query=${widget.queryname}&client_id=XhrMaB2QalO0YMRnfM6iaXwNfYDDIlDUbeK49ABfWyg'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data.map((dynamic item) => {
            'imageUrl': item['urls']['regular'],
            'description': quoteMap[widget.queryname]![
                _random.nextInt(quoteMap[widget.queryname]!.length)],
          }));
    } else {
      throw Exception('Failed to load images');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.queryname),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _imageData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return PageView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ImageItem(
                  imageUrl: snapshot.data![index]['imageUrl'],
                  customDescription: snapshot.data![index]['description'],
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ImageItem extends StatelessWidget {
  final String imageUrl;
  final String customDescription;

  const ImageItem({
    Key? key,
    required this.imageUrl,
    required this.customDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            imageUrl,
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 20),
        Text(
          customDescription,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
