import 'package:fluttertoast/fluttertoast.dart';
import 'package:listme/commons/styles.dart';

showToastMessage(message) {
  Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.BOTTOM,
    textColor: black,
    backgroundColor: white,
  );
}