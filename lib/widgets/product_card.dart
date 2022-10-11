import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 400,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        decoration: _cardBorder(),
        child: Stack(alignment: Alignment.bottomLeft, children: [
          _BackgroundImage(),
          _ProductDetails(),
          Positioned(
            child: _PriceTag(),
            top: 0,
            right: 0,
          ),
          Positioned(
            child: _NotAvailable(),
            top: 0,
            left: 0,
          ),
        ]),
      ),
    );
  }

  BoxDecoration _cardBorder() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(color: Colors.black12, offset: Offset(0, 7), blurRadius: 10)
        ]);
  }
}

class _NotAvailable extends StatelessWidget {
  const _NotAvailable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'No disponible',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      width: 100,
      height: 70,
      decoration: BoxDecoration(
          color: Colors.yellow[800],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
    );
    ;
  }
}

class _PriceTag extends StatelessWidget {
  const _PriceTag({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        //con este boxfit logramos que siemore se vea el texto
        fit: BoxFit.contain,
        child: Text(
          "103.99 €",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), bottomLeft: Radius.circular(25))),
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: const SizedBox(
        width: double.infinity,
        height: 400,
        child: FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(
              "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimages.creativemarket.com%2F0.1.0%2Fps%2F6663618%2F600%2F400%2Fm2%2Ffpnw%2Fwm0%2Fhola-calligraphy-in-speech-bubble-01-.jpg%3F1562843636%26s%3Df1616a263a202c835e47b08d9f52a260&f=1&nofb=1&ipt=a3cdadbf7d745e4a31fe4057f2550962e224826e0528b6ed7393c01aea538425&ipo=images"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "cositas",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "id de cositas",
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ]),
      ),
    );
  }
}
