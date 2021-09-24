import 'package:flutter/material.dart';
import 'package:progetto_piattaforme/dto/product_details_dto.dart';
import 'package:progetto_piattaforme/model/products.dart';
import 'package:progetto_piattaforme/pages/product_details.dart';

class BuildGridProduct extends StatelessWidget {
  final Products product;

  const BuildGridProduct({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Hero(
                      tag: "image${product.prodottoId}",
                      child: FadeInImage.assetNetwork(
                        placeholder: "content/images/no_image.png",
                        image: product.immagineProdotto,
                        width: 400,
                        height: 400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    product.nomeProdotto,
                    maxLines: 1,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: Text(
                      product.descrizioneProdotto,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "Peso prodotto: ${product.peso} KG",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Prezzo: ${product.prezzo}€",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 10),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8.0, left: 50.0, right: 50.0),
                      child: Text(
                        "Acquista ora",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, ProductDetails.routeName,
                          arguments: ProductDetailsDTO(product: this.product));
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
