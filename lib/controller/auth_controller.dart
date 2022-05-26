import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:proyecto_papeleria/ui/views/Admin/admin_dashboard.dart';
import 'package:proyecto_papeleria/ui/views/Auth/login_page.dart';
import '../ui/widgets/splash_screen.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  //-----------------------
  @override
  void onReady() async {
    super.onReady();
    _setInitialScreen(auth.currentUser);
  }

  _setInitialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => const SplashScreen());
      Get.offAll(() => LoginPage());
    } else {
    }
  }
    void logIn(String email , String pass) async {
    try {
      await auth
          .signInWithEmailAndPassword(
              email: email.trim(), password: pass.trim())
          .then((result) {
          Get.offAll(() => AdminDashBoard());
      });
    } catch (e) {
      pError(e);
    }
  } 
    String pError(Object e) {
    String message = "";
    if (e.hashCode.toInt() == 505284406) {
      message = "Email no registrado";
      Get.snackbar("Login Incorrecto", message);
      return message;
    }

    if (e.hashCode.toInt() == 185768934) {
      message = "Contraseña Incorrecta";
      Get.snackbar("Login Incorrecto", message);
      return message;
    }
    if (e.hashCode.toInt() == 34618382) {
      message = "Email registrado Con otra Cuenta";
      Get.snackbar("Registro Incorrecto", message);
      return message;
    }
    return message;
  }
  void signOut() async {
    auth.signOut();
    Get.offAll(() => LoginPage());
  }
}
