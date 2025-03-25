import 'package:shared_preferences/shared_preferences.dart';

import 'models.dart';

class PreferencesService {
  Future saveSettings(Settings setting) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString('username', setting.userName);
    await preferences.setBool('isEmployed', setting.isEmployed);
    await preferences.setInt('gender', setting.gender.index);
    await preferences.setStringList(
      'programmingLanguages',
      setting.programmingLanguages
          .map((lang) => lang.index.toString())
          .toList(),
    );
    print('Saved Settings');
  }

  Future<Settings> getSettings() async {
    final preferences = await SharedPreferences.getInstance();
    final username = preferences.getString('username');
    final isEmployed = preferences.getBool('isEmployed');
    final gender = Gender.values[preferences.getInt('gender') ?? 0];

    final programmingLanguagesIndicies = preferences.getStringList(
      'programmingLanguages',
    );
    final programmingLanguages =
        programmingLanguagesIndicies
            ?.map(
              (stringIndex) =>
                  ProgrammingLanguages.values[int.parse(stringIndex)],
            )
            .toSet();

    return Settings(
      userName: username!,
      gender: gender,
      programmingLanguages: programmingLanguages!,
      isEmployed: isEmployed!,
    );
  }
}
