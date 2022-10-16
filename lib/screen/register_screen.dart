import 'package:flutter/material.dart';
import 'package:formvalidation/services/services.dart';
import 'package:provider/provider.dart';

import 'package:formvalidation/providers/providers.dart';
import 'package:formvalidation/widgets/widgets.dart';
import '../styles/input_decorations.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                Text('Crear cuenta',
                    style: Theme.of(context).textTheme.headline4),
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
            TextButton(
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder())),
              onPressed: () => Navigator.pushReplacementNamed(context, "login"),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
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
              return (value != null && value.length >= 6)
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
                      //llamamos a un método del provider
                      if (!loginForm.isValidForm()) {
                        return;
                      }
                      loginForm.isLoading = true;
                      final authService =
                          Provider.of<AuthService>(context, listen: false);
                      final error = await authService.createUser(
                          loginForm.email, loginForm.password);
                      loginForm.isLoading = false;
                      if (error == null) {
                        Navigator.pushReplacementNamed(context, "home");
                      }
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
