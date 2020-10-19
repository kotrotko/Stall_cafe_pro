import 'package:shared_preferences/shared_preferences.dart';

void saveOrder(currentOrderEntries) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (currentOrderEntries.length != 0) {
    prefs.setString('order', currentOrderEntries.toList().join(', '));
  } else {
    prefs.clear();
  }
}

Future<List<String>> getOrder() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('order')) {
    return prefs.getString('order').split(', ');
  } else {
    return [];
  }
}
