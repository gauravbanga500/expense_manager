import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const USER_ID_KEY = "uid";

  void setUID(int uid) async {
    var pref = await SharedPreferences.getInstance();
    pref.setInt(USER_ID_KEY, uid);

  }
  Future<int> getUID() async{
    var pref = await SharedPreferences.getInstance();
    int? uid = pref.getInt(USER_ID_KEY);
    return uid ?? 0;

  }
}
