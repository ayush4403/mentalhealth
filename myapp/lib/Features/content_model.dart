
class OnbordingContent {
  String image;
  String title;
  String discription;

  OnbordingContent({
    required this.image,
    required this.title,
    required this.discription,
  });
}

List<OnbordingContent> contents = [
  OnbordingContent(
      title: 'Engaging Activities',
      image: 'assets/GIF/gif1.json',
      discription: "Engage in guided meditations, breathing "
          "exercises, and yoga sessions to cultivate inner "
          "calm and mindfulness in your daily life. "),
  OnbordingContent(
      title: 'Challenging Games',
      image: 'assets/GIF/gif2.json',
      discription: "Stimulate your mind and challenge yourself "
          "with a collection of mental exercises and brain "
          "games designed to boost cognitive agility. "),
  OnbordingContent(
      title: 'Knowledge Treasure',
      image: 'assets/GIF/gif3.json',
      discription: "Explore a treasure trove of tips, facts, and "
          "articles about mental health—empowering you "
          "with knowledge and insights to support your well-being. "),
  OnbordingContent(
      title: 'Progress Tracking',
      image: 'assets/GIF/gif4.json',
      discription:
          "Track your progress! Receive weekly reports summarizing your activities, "
          "games played, mood tracking, and other metrics— "
          "empowering you to visualize your growth and wellness journey. "),
  OnbordingContent(
      title: 'Mood Insights',
      image: 'assets/GIF/gif5.json',
      discription: "Log and track your moods and emotions effortlessly. "
          "Gain valuable insights into your emotional well-being, empowering you "
          "to understand patterns and make informed choices. "),
];
