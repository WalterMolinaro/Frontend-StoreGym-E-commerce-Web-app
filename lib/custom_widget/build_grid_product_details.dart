import 'package:flutter/material.dart';
import 'package:progetto_piattaforme/model/products.dart';

class BuildGridProductDetails extends StatefulWidget {
  final Products product;

  const BuildGridProductDetails({Key? key, required this.product})
      : super(key: key);

  @override
  _BuiGridldProductDetailsState createState() =>
      _BuiGridldProductDetailsState();
}

class _BuiGridldProductDetailsState extends State<BuildGridProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: "image${widget.product.prodottoId}",
                child: FadeInImage.assetNetwork(
                    placeholder: "content/images/no_image.png",
                    image: widget.product.immagineProdotto),
              ),
              SizedBox(
                height: 30,
              ),
              // ignore: deprecated_member_use
              OutlineButton(
                  child: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop())
            ],
          ),
        ),
      ),
    );
  }
}
