// lib/models/project_model.dart
class Project {
  final String title;
  final String? playStoreLink;
  final String? githubLink;
  final List<String> description;
  final String? imageUrl;

  Project({
    required this.title,
    this.playStoreLink,
    this.githubLink,
    required this.description,
    this.imageUrl,
  });

  static List<Project> getProjects() {
    return [
      Project(
        title: "Rider App (Cravo)",
        playStoreLink: "https://play.google.com/store/apps/details?id=com.vativeapps.cravorider",
        description: [
          "Implemented WebSockets for continuous location updates based on distance.",
          "Integrated Google Maps for navigation to customers and restaurants.",
          "Developed real-time push notifications for updates using firebase_messaging and flutter_local_notifications plugin.",
          "Integrated in-app chat functionality for communication with customers and support."
        ],
        imageUrl: "assets/images/cravo_rider.png",
      ),
      Project(
        title: "Food Delivery App (Cravo)",
        playStoreLink: "https://play.google.com/store/apps/details?id=com.vativeapps.cravocustomer",
        description: [
          "Implemented localization support by localizing the app.",
          "Integrated WebSockets to track the the rider's location in real-time.",
          "Implemented Google Maps for enhanced navigation.",
          "Integrated push notifications for updates",
          "Created in-app chat functionality for communication with the rider.",
        ],
        imageUrl: "assets/images/cravo_customer.png",
      ),
      Project(
        title: "MinoLive App",
        playStoreLink: "https://play.google.com/store/apps/details?id=com.mino.app",
        description: [
          "Resolved messaging and call functionality bugs.",
          "Optimized the UI for better user experience.",
          "Implemented localization for the application.",
          "Integrated push notifications for multiple features (Posts, Chat, Calls, Comments).",
          "Integrated translations on live streaming comments using Google Cloud Translation API and lang_detect for language detection.",
        ],
        imageUrl: "assets/images/minolive.png",
      ),
      Project(
        title: "Chat-App",
        githubLink: "https://github.com/SyedAhmed334/Chat-App-Flutter",
        description: [
          "Developed a real-time chat application using Flutter and Firebase.",
          "Integrated Firebase Cloud Firestore for storing chat messages.",
          "Implemented Firebase authentication for secure user login with Google Sign-In.",
          "Used Firebase Storage to handle and store media files.",
          "Employed Provider for efficient state management and performance optimization."
        ],
        imageUrl: "assets/images/chat_app.png",
      ),
      Project(
        title: "E-MakeUp",
        githubLink: "https://github.com/SyedAhmed334/Makeup-App",
        description: [
          "Built an e-commerce app to browse and purchase makeup products.",
          "Integrated REST API to retrieve and display makeup products dynamically.",
          "Implemented SQLite database for secure local storage of user data.",
          "Leveraged Provider for optimized state management and better performance.",
          "Integrated Firebase authentication to enable secure user login."
        ],
        imageUrl: "assets/images/makeup_app.png",
      ),
    ];
  }
}