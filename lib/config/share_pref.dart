import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeAccessToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Remove old token if it exists
  await prefs.remove('access_token');
  // Store the new token
  await prefs.setString('access_token', token);
}
Future<void> storeOnBoard(bool isFirstTime) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Remove old value if it exists
  await prefs.remove('is_first_time');
  // Store the new value
  await prefs.setBool('is_first_time', isFirstTime);
}


/// Get onboarding status
Future<bool> getOnBoardStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('is_first_time') ?? false; // Default: false (not first time)
}


Future<String?> getAccessToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('access_token');
}
Future<void> clearAllData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear(); // Clears all stored preferences
}