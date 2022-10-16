import 'package:flutter/material.dart';
import 'package:formvalidation/models/models.dart';
import 'package:formvalidation/screen/screens.dart';
import 'package:formvalidation/services/services.dart';
import 'package:formvalidation/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //leer del provider para que se cree, si nadie lo lee,
    //este no se crea. PAra cambia dicho comportamiento en main poner:
    //lazy:false
    final productService = Provider.of<ProductService>(context);
    final authService = Provider.of<AuthService>(context);

    return productService.isLoading
        ? const LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: const Center(child: Text("Productos")),
              leading: IconButton(
                icon: const Icon(Icons.logout_outlined),
                onPressed: () {
                  authService.logout();
                  Navigator.pushReplacementNamed(context, "login");
                },
              ),
            ),
            body: ListView.builder(
                itemCount: productService.products.length,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                      child: ProductCard(
                        product: productService.products[index],
                      ),
                      onTap: () {
                        productService.selectedProduct =
                            productService.products[index].copy();
                        Navigator.pushNamed(context, 'product');
                      },
                    )),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                productService.selectedProduct =
                    Product(available: true, name: "", price: 0);
                Navigator.pushNamed(context, 'product');
              },
            ),
          );
  }
}
