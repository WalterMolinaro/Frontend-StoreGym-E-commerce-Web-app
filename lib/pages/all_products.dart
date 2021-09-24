import 'package:flutter/material.dart';
import 'package:progetto_piattaforme/custom_widget/build_app_bar.dart';
import 'package:progetto_piattaforme/custom_widget/build_grid_product.dart';
import 'package:progetto_piattaforme/custom_widget/build_grid_product_details.dart';

import 'package:progetto_piattaforme/model/products.dart';
import 'package:progetto_piattaforme/responsive/layout_responsive.dart';

class AllProducts extends StatelessWidget {
  static const String routeName = "/TuttiProdotti";
  final String? label;
  final Future<List<Products>> productsFuture;

  AllProducts({Key? key, required this.productsFuture, this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        BuildAppBar(),
        Container(
            child: Divider(), padding: EdgeInsets.only(top: 10, bottom: 20)),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10.0),
              child: Text(
                "Ricerca per: " +
                    label!.substring(0, 1).toUpperCase() +
                    label!.substring(1).toLowerCase(),
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(10.0, 5.0),
                      blurRadius: 3.0,
                    ),
                    Shadow(
                      offset: Offset(10.0, 5.0),
                      blurRadius: 8.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Flexible(
          child: FutureBuilder<List<Products>>(
              future: productsFuture,
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  return Center(
                      child: Text(
                    "NESSUN ELEMENTO TROVATO ",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.green,
                      shadows: <Shadow>[
                        Shadow(offset: Offset(1, 10), blurRadius: 8),
                      ],
                    ),
                  ));

                return snapshot.hasData
                    ? ManagementProductsList(snapshot: snapshot)
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              }),
        ),
      ],
    ));
  }
}

class ManagementProductsList extends StatelessWidget {
  final AsyncSnapshot<List<Products>> snapshot;
  const ManagementProductsList({Key? key, required this.snapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: LayoutResponsive(
        tablet: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: snapshot.data!.map((product) {
            return GestureDetector(
              child: GridTile(child: BuildGridProduct(product: product)),
              onTap: () {
                goToDetailPage(context, product);
              },
            );
          }).toList(),
        ),
        desktop: GridView.count(
          crossAxisCount: 4,
          childAspectRatio: 1,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: snapshot.data!.map((product) {
            return GestureDetector(
              child: GridTile(child: BuildGridProduct(product: product)),
              onTap: () {
                goToDetailPage(context, product);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

void goToDetailPage(BuildContext context, Products product) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) =>
              BuildGridProductDetails(product: product)));
}
