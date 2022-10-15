import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formvalidation/providers/product_form_provider.dart';
import 'package:formvalidation/services/services.dart';
import 'package:formvalidation/styles/input_decorations.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    return ChangeNotifierProvider(
        create: (_) => ProductFormProvider(productService.selectedProduct),
        child: _ProductScreenBody(productService: productService));
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductService productService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(
                  url: productService.selectedProduct.picture,
                ),
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
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;
    return Container(
      width: double.infinity,
      decoration: _buildBoxDecoration(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
          child: Column(
        children: [
          const SizedBox(height: 10),
          TextFormField(
            initialValue: product.name,
            onChanged: ((value) => product.name = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "El nombre es obligatorio";
              }
              return null;
            },
            decoration: InputDecorations.authInputDecoration(
                hintText: "Nombre del producto", labelText: "Nombre:"),
          ),
          const SizedBox(height: 30),
          TextFormField(
            initialValue: "${product.price} €",
            onChanged: (value) {
              if (double.tryParse(value) == null) {
                product.price = 0;
              } else {
                product.price = double.parse(value);
              }
            },
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
            ],
            keyboardType: TextInputType.number,
            decoration: InputDecorations.authInputDecoration(
                hintText: "30€", labelText: "Precio:"),
          ),
          const SizedBox(height: 30),
          SwitchListTile.adaptive(
            title: const Text("Disponible"),
            value: product.available,
            activeColor: Colors.indigo,
            onChanged: (value) => productForm.updateAvailability(value),
          ),
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
