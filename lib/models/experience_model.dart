

// lib/models/experience_model.dart
class Experience {
  final String company;
  final String role;
  final String duration;
  final String skills;
  final List<String> responsibilities;

  Experience({
    required this.company,
    required this.role,
    required this.duration,
    required this.skills,
    required this.responsibilities,
  });

  static List<Experience> getExperiences() {
    return [
      Experience(
        company: "vativeApps",
        role: "Junior Flutter Developer",
        duration: "May 2024 - Present",
        skills: "REST APIs, WebSockets, Maps",
        responsibilities: [
          "Worked on social media and business related apps.",
          "Integrated WebSockets for real-time communication and Google Maps for location services.",
          "Implemented thermal printer integration supporting both Bluetooth and Network printers for receipt generation in POS applications.",
          "Integrated push notifications for Android and IOs.",
          "Developed localization features.",
          "Developed and integrated REST APIs across multiple mobile apps."
        ],
      ),
      Experience(
        company: "Plural Dynamics",
        role: "Flutter Developer Intern",
        duration: "January 2024 - April (4 Months)",
        skills: "REST API, GetX",
        responsibilities: [
          "Customized UI of an E-commerce App and Integrated 15+ API endpoints",
          "Utilized clean architecture using the MVVM design pattern.",
          "Maintained efficient state management using GetX."
        ],
      ),
    ];
  }
}
