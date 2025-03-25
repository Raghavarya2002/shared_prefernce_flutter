import 'package:flutter/material.dart';
import 'package:shared_prefernce/models.dart';
import 'package:shared_prefernce/preferences_services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _preferencesService = PreferencesService();
  final _userNameController = TextEditingController();
  var _selectedGender = Gender.FEMALE;
  var _selectedLanguages = Set<ProgrammingLanguages>();
  var _isEmployed = false;


  Future<void> _populateFields() async {
    final settings = await _preferencesService.getSettings();
    setState(() {
      _userNameController.text = settings.userName;
      _selectedGender = settings.gender;
      _selectedLanguages = settings.programmingLanguages;
      _isEmployed = settings.isEmployed;
    });
  }

  @override
  void initState() {
    _populateFields();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Shared preferences')),
        body: ListView(
          children: [
            ListTile(
              title: TextField(
                controller: _userNameController,
                decoration: InputDecoration(labelText: 'UserName'),
              ),
            ),
            RadioListTile(
              title: Text('Female'),
              value: Gender.FEMALE,
              groupValue: _selectedGender,
              onChanged:
                  (newValue) => setState(() => _selectedGender = newValue!),
            ),

            RadioListTile(
              title: Text('Male'),
              value: Gender.MALE,
              groupValue: _selectedGender,
              onChanged:
                  (newValue) => setState(() => _selectedGender = newValue!),
            ),

            RadioListTile(
              title: Text('Other'),
              value: Gender.OTHER,
              groupValue: _selectedGender,
              onChanged:
                  (newValue) => setState(() => _selectedGender = newValue!),
            ),

            CheckboxListTile(
              title: Text('DART'),
              value: _selectedLanguages.contains(ProgrammingLanguages.DART),
              onChanged: (_) {
                setState(() {
                  _selectedLanguages.contains(ProgrammingLanguages.DART)
                      ? _selectedLanguages.remove(ProgrammingLanguages.DART)
                      : _selectedLanguages.add(ProgrammingLanguages.DART);
                });
              },
            ),
            CheckboxListTile(
              title: Text('KOTLIN'),
              value: _selectedLanguages.contains(ProgrammingLanguages.KOTLIN),
              onChanged: (_) {
                setState(() {
                  _selectedLanguages.contains(ProgrammingLanguages.KOTLIN)
                      ? _selectedLanguages.remove(ProgrammingLanguages.KOTLIN)
                      : _selectedLanguages.add(ProgrammingLanguages.KOTLIN);
                });
              },
            ),
            CheckboxListTile(
              title: Text('JAVASCRIPT'),
              value: _selectedLanguages.contains(
                ProgrammingLanguages.JAVASCRIPT,
              ),
              onChanged: (_) {
                setState(() {
                  _selectedLanguages.contains(ProgrammingLanguages.JAVASCRIPT)
                      ? _selectedLanguages.remove(
                        ProgrammingLanguages.JAVASCRIPT,
                      )
                      : _selectedLanguages.add(ProgrammingLanguages.JAVASCRIPT);
                });
              },
            ),
            CheckboxListTile(
              title: Text('SWIFT'),
              value: _selectedLanguages.contains(ProgrammingLanguages.SWIFT),
              onChanged: (_) {
                setState(() {
                  _selectedLanguages.contains(ProgrammingLanguages.SWIFT)
                      ? _selectedLanguages.remove(ProgrammingLanguages.SWIFT)
                      : _selectedLanguages.add(ProgrammingLanguages.SWIFT);
                });
              },
            ),

            SwitchListTile(
              title: Text('isEmployed'),
              value: _isEmployed,
              onChanged: (newValue) => setState(() => _isEmployed = newValue),
            ),
            TextButton(onPressed: _saveSettings, child: Text('Save Settings')),
          ],
        ),
      ),
    );
  }

  void _saveSettings() {
    final newSettings = Settings(
      userName: _userNameController.text,
      gender: _selectedGender,
      programmingLanguages: _selectedLanguages,
      isEmployed: _isEmployed,
    );
    print(newSettings);
    _preferencesService.saveSettings(newSettings);
  }
}
