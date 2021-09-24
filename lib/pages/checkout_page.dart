import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:progetto_piattaforme/custom_widget/build_app_bar.dart';
import 'package:progetto_piattaforme/model/ordine.dart';
import 'package:intl/intl.dart';
import 'package:progetto_piattaforme/model/utente.dart';
import 'package:progetto_piattaforme/network/rest_client.dart';
import 'package:progetto_piattaforme/pages/confermed_order_page.dart';
import 'package:progetto_piattaforme/pages/shopping_cart.dart';
import 'package:progetto_piattaforme/pages/user_login_page.dart';

class CheckOutPage extends StatelessWidget {
  static const routeName = "/checkOut";
  final Ordine ordine;
  CheckOutPage({Key? key, required this.ordine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          BuildAppBar(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(),
          ),
          Expanded(
            child: ListView(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Sommario ordini",
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
                    Spacer(),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: PageView(
              physics: BouncingScrollPhysics(),
              controller: PageController(initialPage: 0, viewportFraction: 0.9),
              children: [
                BuildFormIndirizzoFatturazioneValidation(),
                ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: IndicationStepsCheckOut(
                        label: "2. Modalità di pagamento",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 10, bottom: 10),
                      child: Text(
                        "Seleziona la modalità di pagamento",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ViewRadioButtom(),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: IndicationStepsCheckOut(
                        label: "3. Conferma il tuo ordine",
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Prodotto",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text(
                          "Somma",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: ordine.prodottiInOrdine.length,
                          itemBuilder: (BuildContext contex, int index) {
                            return Row(
                              children: [
                                Text(
                                  ordine.prodottiInOrdine[index]
                                          .quantitaRichiesta
                                          .toString() +
                                      "x  ",
                                  style: TextStyle(fontSize: 17),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    ordine.prodottiInOrdine[index].prodotto
                                        .nomeProdotto,
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                                Text(
                                  calcolaTotaleProdottoOrdine(
                                          ordine.prodottiInOrdine[index]
                                              .prodotto.prezzo,
                                          ordine.prodottiInOrdine[index]
                                              .quantitaRichiesta) +
                                      " €",
                                  style: TextStyle(fontSize: 17),
                                ),
                                Text(" "),
                              ],
                            );
                          }),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Text(
                                "Spedizione",
                                style: TextStyle(fontSize: 17),
                              )),
                              Text(
                                "4.90 €",
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Text(
                                "TOTALE",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              )),
                              Text(
                                "${calcolaTotaleOrdine(ordine)} €",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text("IVA inclusa"),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    style:
                                        ElevatedButton.styleFrom(elevation: 10),
                                    onPressed: () async {
                                      await RestClient.addOrderForUser(
                                          ordine); //mi inserisce l'ordine nel db

                                      ShoppingCart.staticListProducts = [];
                                      RestClient.deleteShoppingCart(
                                          ShoppingCart.staticIdCart);
                                      Utente ut = await RestClient.getUser(
                                          UserLoginPage.UTENTE.email,
                                          UserLoginPage.UTENTE.password);
                                      ShoppingCart.staticIdCart =
                                          ut.carrello.carrelloId;
                                      Navigator.pushNamed(
                                        context,
                                        ConfermedOrderPage.routeName,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0,
                                          bottom: 8.0,
                                          left: 100,
                                          right: 100),
                                      child: Text(
                                        "Effettua ordine!",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  calcolaTotaleOrdine(Ordine ordine) {
    var f = NumberFormat('###.0#', 'en_US');
    double totale = 0.0;

    for (ProdottiInOrdine prodottoInOrdine in ordine.prodottiInOrdine) {
      totale +=
          prodottoInOrdine.prodotto.prezzo * prodottoInOrdine.quantitaRichiesta;
    }
    totale += 4.90; //per le spese di spedizione
    return f.format(totale);
  }
}

class BuildFormIndirizzoFatturazioneValidation extends StatefulWidget {
  static GlobalKey<FormState> staticKeyIndirizzoFatt =
      new GlobalKey<FormState>();
  const BuildFormIndirizzoFatturazioneValidation({
    Key? key,
  }) : super(key: key);

  @override
  _BuildFormIndirizzoFatturazioneValidationState createState() =>
      _BuildFormIndirizzoFatturazioneValidationState();
}

class _BuildFormIndirizzoFatturazioneValidationState
    extends State<BuildFormIndirizzoFatturazioneValidation> {
  final GlobalKey<FormState> _keyIndirizzoFatturazione =
      new GlobalKey<FormState>();
  final IndirizzoFatturazione indirizzoFatturazioneUtente =
      new IndirizzoFatturazione(
          nome: "",
          cognome: "",
          cellulare: "",
          ditta: "",
          indirizzo: "",
          numeroCivico: "",
          citta: "",
          paese: "",
          cap: "");

  @override
  void initState() {
    BuildFormIndirizzoFatturazioneValidation.staticKeyIndirizzoFatt =
        _keyIndirizzoFatturazione;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: BuildFormIndirizzoFatturazioneValidation.staticKeyIndirizzoFatt,
      child: ListView(
        children: <Widget>[
          IndicationStepsCheckOut(
            label: "1. Indica indirizzo di fatturazione",
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: "Nome*"),
              onSaved: (value) =>
                  indirizzoFatturazioneUtente.nome = value!.toUpperCase(),
              validator: (value) {
                if (value!.isEmpty)
                  return "Campo obbligatorio";
                else if (value.length < 3) return "Nome non valido";
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: "Cognome*"),
              onSaved: (value) =>
                  indirizzoFatturazioneUtente.cognome = value!.toUpperCase(),
              validator: (value) {
                if (value!.isEmpty)
                  return "Campo obbligatorio";
                else if (value.length < 3) return "Cognome non valido";
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Cellulare*(per avvisi di consegna via SMS)"),
              onSaved: (value) =>
                  indirizzoFatturazioneUtente.cellulare = value!.toUpperCase(),
              validator: (value) {
                if (value!.isEmpty)
                  return "Campo obbligatorio";
                else if (value.length < 3) return "Cellulare non valido";
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: TextFormField(
              decoration:
                  InputDecoration(labelText: "Ditta/Altre informazioni"),
              onSaved: (value) =>
                  indirizzoFatturazioneUtente.ditta = value!.toUpperCase(),
              validator: (value) {
                if (value!.isEmpty)
                  return "Campo obbligatorio";
                else if (value.length < 3) return "Ditta non valida";
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: "Indirizzo*"),
              onSaved: (value) =>
                  indirizzoFatturazioneUtente.indirizzo = value!.toUpperCase(),
              validator: (value) {
                if (value!.isEmpty)
                  return "Campo obbligatorio";
                else if (value.length < 3) return "Indirizzo non valido";
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: "N.*"),
              onSaved: (value) => indirizzoFatturazioneUtente.numeroCivico =
                  value!.toUpperCase(),
              validator: (value) {
                if (value!.isEmpty)
                  return "Campo obbligatorio";
                else if (value.length < 1) return "Numero civico  non valido";
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: "C.A.P*"),
              onSaved: (value) =>
                  indirizzoFatturazioneUtente.cap = value!.toUpperCase(),
              validator: (value) {
                if (value!.isEmpty)
                  return "Campo obbligatorio";
                else if (value.length < 2) return "CAP non valido";
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: "Città"),
              onSaved: (value) =>
                  indirizzoFatturazioneUtente.citta = value!.toUpperCase(),
              validator: (value) {
                if (value!.isEmpty)
                  return "Campo obbligatorio";
                else if (value.length < 2) return "Città non valida";
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: TextFormField(
              decoration: InputDecoration(labelText: "Paese"),
              onSaved: (value) =>
                  indirizzoFatturazioneUtente.paese = value!.toUpperCase(),
              validator: (value) {
                if (value!.isEmpty)
                  return "Campo obbligatorio";
                else if (value.length < 3) return "Paese non valido";
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}

String calcolaTotaleProdottoOrdine(double prezzo, int quantitaRichiesta) {
  var f = NumberFormat('###.0#', 'en_US');
  double totale = prezzo * quantitaRichiesta;
  return f.format(totale);
}

enum CartaEnum { paypal, mastercard, googlepay }

class ViewRadioButtom extends StatefulWidget {
  const ViewRadioButtom({Key? key}) : super(key: key);

  @override
  _ViewRadioButtomState createState() => _ViewRadioButtomState();
}

class _ViewRadioButtomState extends State<ViewRadioButtom> {
  CartaEnum radioScelta = CartaEnum.paypal;

  void onRadioTap(newValue) {
    setState(() {
      radioScelta = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Radio(
              groupValue: radioScelta,
              value: CartaEnum.paypal,
              onChanged: onRadioTap,
            ),
            Text(
              "PayPal",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              padding: EdgeInsets.only(left: 100),
              height: 60,
              width: 250,
              child: Image.network(
                  "https://cdn.pixabay.com/photo/2015/05/26/09/37/paypal-784404_960_720.png"),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(),
        ),
        Row(
          children: [
            Radio(
              groupValue: radioScelta,
              value: CartaEnum.mastercard,
              onChanged: onRadioTap,
            ),
            Text(
              "Carta di credito",
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Container(
                height: 60,
                width: 250,
                child: Image.network(
                  "https://th.bing.com/th/id/R.d6cab8dfdd2c091b6f3dc0d3ef3a3c88?rik=zPGLeovPP7s6Rg&riu=http%3a%2f%2fwww.tradeshopitalia.com%2fimg%2fcms%2fbanner_paypal_lungo.png&ehk=qhMbZDuEhW96EBshVewtmFJorGGJFePdyqBoj%2bxLfMI%3d&risl=&pid=ImgRaw&r=0",
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(),
        ),
        Row(
          children: [
            Radio(
              groupValue: radioScelta,
              value: CartaEnum.googlepay,
              onChanged: onRadioTap,
            ),
            Text(
              "Google Pay",
              style: TextStyle(fontSize: 20),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                padding: const EdgeInsets.only(left: 85),
                height: 40,
                width: 250,
                child: Image.network(
                    "https://th.bing.com/th/id/OIP.iBVjbjKq7HcMQNt-BMSC-gHaBn?pid=ImgDet&rs=1"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class IndicationStepsCheckOut extends StatelessWidget {
  final String label;
  const IndicationStepsCheckOut({
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 8, bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Colors.grey[400],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  label,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}

class IndirizzoFatturazione {
  String nome = "";
  String cognome = "";
  String cellulare = "";
  String ditta = "";
  String indirizzo = "";
  String numeroCivico = "";
  String cap = "";
  String citta = "";
  String paese = "";

  IndirizzoFatturazione({
    required this.nome,
    required this.cognome,
    required this.cellulare,
    required this.ditta,
    required this.indirizzo,
    required this.numeroCivico,
    required this.citta,
    required this.paese,
    required this.cap,
  });
}
