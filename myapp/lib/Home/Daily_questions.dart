// ignore_for_file: file_names

class DailyQuestion {
  final String text;
  final List<String> options;

  DailyQuestion(this.text, this.options);
}

// Define your list of DailyQuestions here
List<DailyQuestion> questions = [
  DailyQuestion(
    "How are you feeling today?",
    ["😀", "😢", "😡", "😇", "😴"],
  ),
   DailyQuestion(
    "How would you rate the quality of your sleep recently?",
    ["😀", "😢", "😡", "😇", "😴"],
  ),
   DailyQuestion(
    "How would you rate your energy levels today?",
    ["😀", "😢", "😡", "😇", "😴"],
  ),
   DailyQuestion(
    "How connected do you feel with others today?",
    ["😀", "😢", "😡", "😇", "😴"],
  ),
   DailyQuestion(
    "Have you taken a moment for mindfulness today?",
    ["😀", "😢", "😡", "😇", "😴"],
  ),
  // Add more questions here...
];
