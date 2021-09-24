import 'package:flutter/material.dart';
import 'package:progetto_piattaforme/custom_widget/build_app_bar.dart';
import 'package:progetto_piattaforme/custom_widget/button.dart';
import 'package:progetto_piattaforme/model/ordine.dart';
import 'package:progetto_piattaforme/model/utente.dart';
import 'package:intl/intl.dart';
import 'package:progetto_piattaforme/responsive/layout_responsive.dart';

class AccountPage extends StatelessWidget {
  static const String routeName = '\Account';

  final Utente user;
  final Future<List<Ordine>> listOrders;
  const AccountPage({Key? key, required this.user, required this.listOrders})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildAppBar(),
              Divider(),
              Container(
                padding: EdgeInsets.only(top: 20, left: 20),
                child: Row(
                  children: [
                    Text(
                        "Ciao " +
                            user.nomeUtente.substring(0, 1).toUpperCase() +
                            user.nomeUtente.substring(1).toLowerCase().trim() +
                            "!",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.green,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        "Nella panoramica del tuo account puoi visualizzare le tue ultime attività e gestire i tuoi dati.",
                        style:
                            TextStyle(color: Colors.amber[100], fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(),
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 20),
                  child: Text(
                    "ORDINI EFFETTUATI",
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: FutureBuilder<List<Ordine>>(
                future: listOrders,
                builder: (context, snapshot) {
                  if (snapshot.hasError)
                    return Text(
                      "NESSUN ORDINE EFFETTUATO!",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                        shadows: <Shadow>[
                          Shadow(offset: Offset(1, 10), blurRadius: 8),
                        ],
                      ),
                    );
                  return snapshot.hasData
                      ? ManagmentOrdersList(snapshot: snapshot)
                      : Row(
                          children: [
                            Text("NESSUN ORDINE EFFETTUATO!",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green)),
                          ],
                        );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(),
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, top: 15),
                  child: Row(
                    children: [
                      Text(
                        "I TUOI DATI",
                        style: TextStyle(fontSize: 18, color: Colors.green),
                      ),
                      Spacer(),
                      Text(
                        "INDIRIZZO DI SPEDIZIONE",
                        style: TextStyle(fontSize: 18, color: Colors.green),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Button(
                            text: Text("elabora/aggiungi"), onPressed: () {}),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 20, left: 20),
                      child: Row(
                        children: [
                          Text(
                            "Nome: " + user.nomeUtente,
                            style: TextStyle(color: Colors.amber[100]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 20, left: 20),
                            child: Row(
                              children: [
                                Text(
                                  "Cognome: " + user.cognomeUtente,
                                  style: TextStyle(color: Colors.amber[100]),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 20, left: 20),
                            child: Row(
                              children: [
                                Text(
                                  "Email: " + user.email,
                                  style: TextStyle(color: Colors.amber[100]),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 20, left: 20),
                            child: Row(
                              children: [
                                Text(
                                  "Telefono: " + user.telefonoUtente,
                                  style: TextStyle(color: Colors.amber[100]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      child: Text(
                        "Non hai indicato alcun indirizzo di spedizione standard!",
                        style: TextStyle(color: Colors.amber[100]),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          "Hai delle domande sul tuo ordine?",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          "Il nostro team di assistenza è a tua completa disposizione: " +
                              "FAQ & Assistenza " +
                              "service@storegym.it",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class ManagmentOrdersList extends StatelessWidget {
  final AsyncSnapshot<List<Ordine>> snapshot;
  const ManagmentOrdersList({Key? key, required this.snapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (snapshot.data!.length != 0)
      return LayoutResponsive(
        desktop: GridView.count(
            crossAxisCount: 5,
            childAspectRatio: 1,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: snapshot.data!.map((ordine) {
              return GridTile(child: BuildGridOrder(ordine: ordine));
            }).toList()),
        tablet: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: snapshot.data!.map((ordine) {
            return GridTile(
                child: BuildGridOrder(
              ordine: ordine,
            ));
          }).toList(),
        ),
      );
    else
      return ListView(
        children: [
          Center(
            child: Text(
              "Nessun ordine effettuato!",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.amber[100],
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
  }
}

class BuildGridOrder extends StatelessWidget {
  final Ordine ordine;

  const BuildGridOrder({Key? key, required this.ordine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(border: Border.all()),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Ordine in data: " + formatData(ordine.dataCreazione),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: ordine.prodottiInOrdine.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(border: Border.all()),
                      child: ListTile(
                        leading: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: (Image.network(ordine.prodottiInOrdine[index]
                                .prodotto.immagineProdotto))),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                ordine.prodottiInOrdine[index].prodotto
                                    .nomeProdotto,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            Text(
                              " x${ordine.prodottiInOrdine[index].quantitaRichiesta}",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    );
                  })),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(border: Border.all()),
              child: Text(
                "Totale ordine: ${convertiTotale(ordine.totaleOrdine)} €",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  convertiTotale(double totaleOrdine) {
    var f = NumberFormat("###.0#", 'en_US');
    double totale = totaleOrdine;
    return f.format(totale);
  }

  String formatData(String dataCreazione) {
    List<String> split = dataCreazione.split(" ");
    return split[0];
  }
}
