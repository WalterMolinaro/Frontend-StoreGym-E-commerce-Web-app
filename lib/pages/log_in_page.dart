import 'package:flutter/material.dart';

import 'package:progetto_piattaforme/custom_widget/build_app_bar.dart';
import 'package:progetto_piattaforme/dto/account_pageDTO.dart';
import 'package:progetto_piattaforme/model/utente.dart';
import 'package:progetto_piattaforme/network/rest_client.dart';
import 'package:progetto_piattaforme/pages/account_page.dart';
import 'package:progetto_piattaforme/pages/shopping_cart.dart';
import 'package:progetto_piattaforme/pages/user_login_page.dart';

class LoginPage extends StatefulWidget {
  static bool statusUserLog = false;

  static const String routeName = 'loginPage';

  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKeyRegistrazione = GlobalKey<FormState>();
  final _formKeyAccesso = GlobalKey<FormState>();
  //Questa key è necessaria alla conferma della password, verrà usata per recuperare il valore del primo inserimento e confrontarlo con il secondo
  final _pswKey = GlobalKey<FormFieldState>();
  final _pswKeyAccesso = GlobalKey<FormFieldState>();
  final keyScaffold = new GlobalKey<ScaffoldState>();
  bool statoRegistrazione = false;
  final RegisterUser utente = RegisterUser();

  @override
  void initState() {
    super.initState();
    LoginPage.statusUserLog = statoRegistrazione;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: keyScaffold,
        body: Column(
          children: [
            BuildAppBar(),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Divider(),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Registrati ora",
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
            Expanded(
              child: Form(
                key: _formKeyRegistrazione,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: "Nome"),
                          onSaved: (value) =>
                              utente.nomeUtente = value!.toUpperCase(),
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
                          decoration: InputDecoration(labelText: "Cognome"),
                          onSaved: (value) =>
                              utente.cognomeUtente = value!.toUpperCase(),
                          validator: (value) {
                            if (value!.isEmpty)
                              return "Campo obbligatorio";
                            else if (value.length < 3)
                              return "Cognome non valido";
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: "Telefono"),
                          onSaved: (value) =>
                              utente.telefonoUtente = value!.toLowerCase(),
                          validator: (value) {
                            if (value!.isEmpty)
                              return "Campo obbligatorio";
                            else if (value.length < 8)
                              return "Telefono non valido";
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: "Indirizzo"),
                          onSaved: (value) =>
                              utente.indirizzoUtente = value!.toUpperCase(),
                          validator: (value) {
                            if (value!.isEmpty)
                              return "Campo obbligatorio";
                            else if (value.length < 3)
                              return "Indirizzo non valido";
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: TextFormField(
                            decoration: InputDecoration(labelText: "Email"),
                            onSaved: (value) =>
                                utente.email = value!.toLowerCase(),
                            validator: (value) {
                              if (value!.isEmpty)
                                return "Campo obbligatorio";
                              else if (!RegExp(
                                      r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) return "Email non valida";
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: TextFormField(
                          key: _pswKey,
                          obscureText: true,
                          decoration: InputDecoration(labelText: "Password"),
                          onSaved: (value) => utente.password = value!,
                          validator: (value) {
                            if (value!.isEmpty)
                              return "Campo obbligatorio";
                            else if (value.length < 8)
                              return "Password lunga almeno 8 caratteri";
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: TextFormField(
                          obscureText: true,
                          decoration:
                              InputDecoration(labelText: "Conferma Password"),
                          onSaved: (value) => utente.rePassword = value!,
                          validator: (value) {
                            if (value! != _pswKey.currentState!.value)
                              return "Password non confermata";
                            else if (value.isEmpty) return "Campo obbligatorio";
                            return null;
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 20),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(elevation: 20),
                                onPressed: () async {
                                  if (_formKeyRegistrazione.currentState!
                                      .validate()) {
                                    //tutti i validate effettuate nella form sono recuperati così.

                                    _formKeyRegistrazione.currentState!.save();

                                    final String nomeUtente = utente.nomeUtente;
                                    final String cognomeUtente =
                                        utente.cognomeUtente;
                                    final String email =
                                        utente.email.toString();
                                    final String indirizzoUtente =
                                        utente.indirizzoUtente;
                                    final String password =
                                        utente.password.toString();
                                    final String dataRegistrazione =
                                        DateTime.now().toString();
                                    final String telefonoUtente =
                                        utente.telefonoUtente;

                                    ShoppingCart carrello = new ShoppingCart(
                                        carrelloId: utente.carrello.carrelloId,
                                        listProducts: []);
                                    final Utente ut =
                                        await RestClient.createUser(
                                            nomeUtente,
                                            cognomeUtente,
                                            telefonoUtente,
                                            indirizzoUtente,
                                            email,
                                            password,
                                            carrello,
                                            dataRegistrazione);
                                    if (ut.nomeUtente != "tappo" &&
                                        ut.email != "tappo") {
                                      statoRegistrazione = true;

                                      UserLoginPage.UTENTE = ut;
                                      UserLoginPage.COUNT_LOG = 0;
                                      UserLoginPage.STATUS_USER = true;
                                      ShoppingCart.staticListProducts = [];
                                      Utente utentePerOrdine =
                                          await RestClient.getUser(
                                              ut.email, ut.password);
                                      UserLoginPage.UTENTE = utentePerOrdine;
                                      ShoppingCart.staticIdCart =
                                          utentePerOrdine.carrello.carrelloId;
                                      Navigator.pushNamed(
                                          context, AccountPage.routeName,
                                          arguments: AccountPageDTO(
                                              user: utentePerOrdine,
                                              listProducts:
                                                  RestClient.fetchOrdersUser(
                                                      utentePerOrdine
                                                          .idUtente!)));
                                    } else {
                                      // ignore: deprecated_member_use
                                      keyScaffold.currentState!.showSnackBar(
                                          new SnackBar(
                                              content:
                                                  Text("Email già esistente")));
                                    }
                                    // ci sarebbe da passare anche il future della lista degli ordini che quell'utente ha fatto.
                                  } //tutti i campi onSaved della funzione Text nella form saranno richiamati da questa funzione
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 8,
                                      right: 170,
                                      left: 170),
                                  child: Text(
                                    "Registrati",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
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
                            decoration: InputDecoration(labelText: "Email"),
                            onSaved: (value) =>
                                utente.email = value!.toLowerCase(),
                            validator: (value) {
                              if (value!.isEmpty)
                                return "Campo obbligatorio";
                              else if (!RegExp(
                                      r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) return "Email non valida";
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: TextFormField(
                          key: _pswKeyAccesso,
                          obscureText: true,
                          decoration: InputDecoration(labelText: "Password"),
                          onSaved: (value) => utente.password = value!,
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
                            padding: EdgeInsets.only(
                              top: 10,
                              bottom: 20,
                            ),
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKeyAccesso.currentState!
                                      .validate()) {
                                    //tutti i validate effettuate nella form sono recuperati così.

                                    _formKeyAccesso.currentState!
                                        .save(); //tutti i campi onSaved della funzione Text nella form saranno richiamati da questa funzione

                                    Utente u = await RestClient.getUser(
                                        utente.email, utente.password);

                                    if (u.email == "tappo" ||
                                        u.password == "tappo") {
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
                                      UserLoginPage.COUNT_LOG = 0;
                                      UserLoginPage.STATUS_USER = true;

                                      ShoppingCart.staticListProducts = [];

                                      Utente utentePerOrdine =
                                          await RestClient.getUser(
                                              u.email, u.password);
                                      UserLoginPage.UTENTE = utentePerOrdine;
                                      ShoppingCart.staticIdCart =
                                          utentePerOrdine.carrello.carrelloId;
                                      Navigator.pushNamed(
                                          context, AccountPage.routeName,
                                          arguments: AccountPageDTO(
                                              user: u,
                                              listProducts:
                                                  RestClient.fetchOrdersUser(
                                                      utentePerOrdine
                                                          .idUtente!)));
                                    }
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 8,
                                      right: 170,
                                      left: 170),
                                  child: Text(
                                    "Accedi ora",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RegisterUser extends Utente {
  RegisterUser()
      : super(
            idUtente: -1,
            nomeUtente: "",
            telefonoUtente: "",
            dataRegistrazione: "",
            cognomeUtente: "",
            password: "",
            email: "",
            indirizzoUtente: "",
            carrello: new ShoppingCart(carrelloId: -1, listProducts: []));
  String rePassword = "";
}
