import 'package:fluttertoast/fluttertoast.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
void toast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: colorBlue,
      textColor: Styles.colorWhite,
      fontSize: 16.0);
}