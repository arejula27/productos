import 'package:flutter/material.dart';
import 'package:formvalidation/styles/input_decorations.dart';

import '../widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(),
                Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 40,
                          color: Colors.white,
                        ))),
                Positioned(
                    top: 60,
                    right: 20,
                    child: IconButton(
                        onPressed: () {
                          //Camara o galeria
                        },
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          size: 40,
                          color: Colors.white,
                        )))
              ],
            ),
            _ProductForm(),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save_outlined),
          onPressed: () {
            //guardar producto
          }),
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: _buildBoxDecoration(),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
          child: Column(
        children: [
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecorations.authInputDecoration(
                hintText: "Nombre del producto", labelText: "Nombre:"),
          ),
          const SizedBox(height: 30),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecorations.authInputDecoration(
                hintText: "30€", labelText: "Precio:"),
          ),
          const SizedBox(height: 30),
          SwitchListTile.adaptive(
              title: Text("Disponible"),
              value: true,
              activeColor: Colors.indigo,
              onChanged: (value) {
                //TODO
              }),
          const SizedBox(height: 30),
        ],
      )),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 5),
              blurRadius: 5)
        ]);
  }
}
