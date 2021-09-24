import 'package:flutter/material.dart';

class BuildBoxQuantity extends StatefulWidget {
  static int quantityOfProduct = 1;
  const BuildBoxQuantity({Key? key}) : super(key: key);

  @override
  _BuildBoxQuantityState createState() => _BuildBoxQuantityState();
}

class _BuildBoxQuantityState extends State<BuildBoxQuantity> {
  int quantity = 1;
  @override
  void initState() {
    super.initState();
    BuildBoxQuantity.quantityOfProduct = quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            new BoxShadow(
              color: Colors.white,
              offset: new Offset(0, 0),
            )
          ],
        ),
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (quantity <= 1) {
                    } else {
                      quantity--;
                      BuildBoxQuantity.quantityOfProduct = quantity;
                    }
                  });
                },
                icon: Icon(
                  Icons.minimize_outlined,
                  color: Colors.black,
                )),
            Expanded(
              child: Center(
                  child: Text(
                "$quantity",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              )),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    quantity++;
                    BuildBoxQuantity.quantityOfProduct = quantity;
                  });
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                )),
          ],
        ),
      ),
    );
  }
}
