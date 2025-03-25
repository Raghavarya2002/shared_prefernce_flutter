enum Gender { FEMALE, MALE, OTHER }

enum ProgrammingLanguages { DART, KOTLIN, JAVASCRIPT, SWIFT }

class Settings {
  final String userName;
  final Gender gender;
  final Set<ProgrammingLanguages> programmingLanguages;
  final bool isEmployed;

  Settings({
    required this.userName,
    required this.gender,
    required this.programmingLanguages,
    required this.isEmployed,
  });
}
