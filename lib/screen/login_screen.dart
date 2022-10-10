import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:formvalidation/providers/login_form_provider.dart';
import 'package:formvalidation/widgets/widgets.dart';
import '../styles/input_decorations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 250),
            CardContainer(
                child: Column(
              children: [
                const SizedBox(height: 10),
                Text('Login', style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: 30),

                //el scope del providerForm es solo el formulario
                ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(),
                  child: _LoginForm(),
                ),
                const SizedBox(height: 10),
              ],
            )),
            const SizedBox(height: 50),
            const Text(
              'Crear una nueva cuenta',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    ));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //indicamos que tipo de provider queremos y nos lo guardamos.
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      //esta clave sera usada por el provider para interactuar con el form y conocer
      //su estado, es inizaliada en el provider.
      key: loginForm.formKey,
      //se evalua por pirmera vez al tocar el form
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                hintText: 'messirve@gmail.com',
                labelText: 'Correo electrónico',
                prefixIcon: Icons.alternate_email_rounded),

            onChanged: (value) => loginForm.email = value,
            //si es corrector devuelve null, sino el string del error
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);

              //comprobar si es igual que match o nulo, si es nulo usa el string ''
              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El valor ingresado no es un correo';
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                hintText: '*****',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline),
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              return (value != null && value.length > 6)
                  ? null
                  : "Contraseña debe tener al menos 6 caracteres";
            },
          ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      //quitamos el teclado de pantalla
                      FocusScope.of(context).unfocus();
                      //llamamso a un método del provider
                      if (!loginForm.isValidForm()) {
                        return;
                      }
                      loginForm.isLoading = true;
                      await Future.delayed(const Duration(seconds: 2));
                      loginForm.isLoading = false;
                      Navigator.pushReplacementNamed(context, "home");
                    },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading ? "Espere..." : "Ingresar",
                  style: const TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
    );
  }
}
