
import 'package:shared_preferences/shared_preferences.dart';

void saveOrder(currentOrderEntries) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('order', currentOrderEntries.toSet().toList().join(', '));
}

//Read the id of dish as integer
Future<List<String>> getOrder() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('order')) {
    return prefs.getString('order').split(', ');
  } else {
    return [];
  }
}