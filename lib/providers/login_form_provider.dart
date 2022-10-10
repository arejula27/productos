import 'package:flutter/material.dart';

//nos permite guardar el estado del firmulario de autentucacion
class LoginFormProvider extends ChangeNotifier {
  String email = "";
  String password = "";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //solo hacer ractivas las variables que impliquen un cambio visual
  //bool isLoading ;
  bool isValidForm() {
    //si no es valido, no hacemos nada, el propio formulario ya muestra los errores
    print(formKey.currentState?.validate() ?? false);
    return formKey.currentState?.validate() ?? false;
  }
}
