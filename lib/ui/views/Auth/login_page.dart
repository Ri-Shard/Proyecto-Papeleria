import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_papeleria/controller/auth_controller.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
    AuthController controller = AuthController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }
  body(){
          return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                    Text("Iniciar Sesion",
              style: GoogleFonts.poppins(
                decorationColor:Colors.black,
                decorationStyle: TextDecorationStyle.wavy,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
            Image.asset("assets/images/CoverImage.png"),
            const SizedBox(height: 40,),
            TextFormField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
                    const SizedBox(height: 20,),
                    ElevatedButton.icon(onPressed: (){controller.logIn(emailController.text,passwordController.text);}, icon:const Icon( Icons.lock_open), label: const Text(" Iniciar Sesion"))
          ],
        ),
        )        
    

       
  );
  }
    }