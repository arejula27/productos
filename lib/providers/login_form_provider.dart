import 'package:flutter/material.dart';

//nos permite guardar el estado del firmulario de autentucacion
class LoginFormProvider extends ChangeNotifier {
  String email = "";
  String password = "";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //solo hacer ractivas las variables que impliquen un cambio visual
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    //al cambiar esta variable va a avisar a todos los widgets que escuchen este
    ///provider
    notifyListeners();
  }

  bool isValidForm() {
    //si no es valido, no hacemos nada, el propio formulario ya muestra los errores
    return formKey.currentState?.validate() ?? false;
  }
}
