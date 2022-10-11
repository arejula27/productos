import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: 450,
        child: Opacity(
          opacity: 0.9,
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(45), topRight: Radius.circular(45)),
              child: getImage()),
        ),
      ),
    );
  }
}

BoxDecoration _buildBoxDecoration() => BoxDecoration(
        color: Colors.black,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(45), topRight: Radius.circular(45)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5))
        ]);

Widget getImage() {
  return const FadeInImage(
    image: NetworkImage(
        "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimages.creativemarket.com%2F0.1.0%2Fps%2F6663618%2F600%2F400%2Fm2%2Ffpnw%2Fwm0%2Fhola-calligraphy-in-speech-bubble-01-.jpg%3F1562843636%26s%3Df1616a263a202c835e47b08d9f52a260&f=1&nofb=1&ipt=a3cdadbf7d745e4a31fe4057f2550962e224826e0528b6ed7393c01aea538425&ipo=images"),
    placeholder: AssetImage('assets/jar-loading.gif'),
    fit: BoxFit.cover,
  );
}
