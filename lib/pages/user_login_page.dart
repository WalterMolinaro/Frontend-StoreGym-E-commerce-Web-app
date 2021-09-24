import 'package:flutter/material.dart';
import 'package:progetto_piattaforme/custom_widget/build_app_bar.dart';
import 'package:progetto_piattaforme/dto/account_pageDTO.dart';
import 'package:progetto_piattaforme/model/utente.dart';
import 'package:progetto_piattaforme/network/rest_client.dart';
import 'package:progetto_piattaforme/pages/log_in_page.dart';
import 'package:progetto_piattaforme/pages/shopping_cart.dart';

import 'account_page.dart';

class UserLoginPage extends StatelessWidget {
  // ignore: non_constant_identifier_names
  static bool STATUS_USER = false;

  // ignore: non_constant_identifier_names
  static int COUNT_LOG =
      0; // il COUT_LOG MI SERVE PER CONTARE QUANTE VOLTE EFFETTUO LA FETCH DEI PRODOTTI PER UN SINGOLO UTENTE, NATURALEMTNE SOLO UNA VOLTA AD ACCESSO
  // ignore: non_constant_identifier_names
  static Utente UTENTE = Utente(
      idUtente: -1,
      carrello: new ShoppingCart(carrelloId: -1, listProducts: []),
      nomeUtente: "tappo",
      cognomeUtente: "tappo",
      telefonoUtente: "tappo",
      indirizzoUtente: "tappo",
      email: "tappo",
      password: "tappo",
      dataRegistrazione: "tappo");
  static const String routeName = "/UserPage";

  const UserLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final keyScaffold = GlobalKey<ScaffoldState>();
    final _formKeyAccesso = GlobalKey<FormState>();
    final _pswKeyAccesso = GlobalKey<FormFieldState>();
    final Login userLogin = new Login(email: "", password: "");
    return SafeArea(
      child: Scaffold(
        key: keyScaffold,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "content/images/sfondo_user2.png",
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            Column(
              children: <Widget>[
                BuildAppBar(),
                Expanded(
                  flex: 3,
                  child: Form(
                    key: _formKeyAccesso,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Divider(),
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  "Accedi ora",
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: TextFormField(
                                style: TextStyle(
                                    fontSize: 25, color: Colors.green),
                                decoration: InputDecoration(labelText: "Email"),
                                onSaved: (value) =>
                                    userLogin.email = value!.toLowerCase(),
                                validator: (value) {
                                  if (value!.isEmpty)
                                    return "Campo obbligatorio";
                                  else if (!RegExp(
                                          r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value))
                                    return "Email non valida";
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: TextFormField(
                              style:
                                  TextStyle(fontSize: 25, color: Colors.green),
                              key: _pswKeyAccesso,
                              obscureText: true,
                              decoration:
                                  InputDecoration(labelText: "Password"),
                              onSaved: (value) => userLogin.password = value!,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return "Campo obbligatorio";
                                else if (value.length < 8)
                                  return "Password lunga almeno 8 caratteri";
                                return null;
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 60),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 20,
                                    ),
                                    onPressed: () async {
                                      if (_formKeyAccesso.currentState!
                                          .validate()) {
                                        //tutti i validate effettuate nella form sono recuperati così.

                                        _formKeyAccesso.currentState!
                                            .save(); //tutti i campi onSaved della funzione Text nella form saranno richiamati da questa funzione

                                        Utente utente =
                                            await RestClient.getUser(
                                                userLogin.email,
                                                userLogin.password);
                                        if (utente.email == "tappo" ||
                                            utente.password == "tappo") {
                                          // ignore: deprecated_member_use
                                          keyScaffold.currentState!
                                              // ignore: deprecated_member_use
                                              .showSnackBar(new SnackBar(
                                            content: Text(
                                              "Email e/o Password errate, riprovare!",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ));
                                        } else {
                                          UserLoginPage.STATUS_USER = true;
                                          Utente utentePerOrdine =
                                              await RestClient.getUser(
                                                  utente.email,
                                                  utente.password);
                                          UTENTE = utentePerOrdine;
                                          ShoppingCart.staticIdCart =
                                              utentePerOrdine
                                                  .carrello.carrelloId;
                                          Navigator.pushNamed(
                                              context, AccountPage.routeName,
                                              arguments: AccountPageDTO(
                                                  user: utentePerOrdine,
                                                  listProducts: RestClient
                                                      .fetchOrdersUser(
                                                          utentePerOrdine
                                                              .idUtente!)));
                                        }
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0,
                                          bottom: 8.0,
                                          right: 170,
                                          left: 170),
                                      child: Text("Accedi ora",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Non sei ancora registrato?\nFallo ora!",
                            style: TextStyle(fontSize: 30, color: Colors.green),
                          ),
                          Icon(
                            Icons.arrow_right_alt,
                            size: 60,
                            color: Colors.green,
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, LoginPage.routeName);
                              },
                              icon: Icon(
                                Icons.app_registration,
                                size: 50,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Login {
  String email;
  String password;

  Login({required this.email, required this.password});
}
