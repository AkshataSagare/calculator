import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {

  Future<void> saveData(List<String> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('calculator_history', data);
  }

  Future<List<String>> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('calculator_history') ?? [];
  }

  Future<void> clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('calculator_history');
  }
}