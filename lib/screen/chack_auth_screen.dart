import 'package:flutter/material.dart';
import 'package:formvalidation/screen/screens.dart';
import 'package:formvalidation/services/services.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //si hay cambios en el servicio este no hara caso, luego o se redibuja (optimizacion)
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Text("Espere");
            }
            if (snapshot.data == "") {
              Future.microtask(() => {
                    {
                      //quitar animaciones
                      Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                              transitionDuration: const Duration(seconds: 0),
                              pageBuilder: ((_, __, ___) =>
                                  const LoginScreen())))
                    }
                  });
            } else {
              Future.microtask(() => {
                    {
                      //quitar animaciones
                      Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                              transitionDuration: const Duration(seconds: 0),
                              pageBuilder: ((_, __, ___) =>
                                  const HomeScreen())))
                    }
                  });
            }

            return Container();
          },
        ),
      ),
    );
  }
}
