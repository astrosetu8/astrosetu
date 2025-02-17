//import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiRoute {

  static String? baseurl = "http://65.1.117.252:5001/api/user";
  String login = "$baseurl/auth/login";
  String verifyOtp = "$baseurl/auth/verify_otp";
  String updateProfile = "$baseurl/auth/update_profile";
  String dashboard = "$baseurl/dashboard";
  String astrologers = "$baseurl/astrologers/";


}
