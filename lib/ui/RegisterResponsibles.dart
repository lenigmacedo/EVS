import 'package:evs_prot/models/ResponsiblesModel.dart';
import 'package:evs_prot/theme/Theme.dart' as Theme;
import 'package:evs_prot/utils/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterResponsibles extends StatefulWidget {
  @override
  _RegisterResponsiblesState createState() => _RegisterResponsiblesState();
}

class _RegisterResponsiblesState extends State<RegisterResponsibles> {
  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Responsibles> responsibleList;

  //Definindo os controladores de cada texto, é necessário um controlador para cada campo
  //Com os controladores consigo pegar os valores que estão inseridos nos campos
  final TextEditingController edtCodigo = TextEditingController();
  final TextEditingController edtAnexo = TextEditingController();
  final TextEditingController edtDesc = TextEditingController();

  @override
  void initState() {
    super.initState();
    var db = databaseHelper.initializeDatabase();
  }

  @override
  Widget build(BuildContext context) {
    //Definindo orientação vertical e removendo cor transparente barra de status
    Theme.Settings.orientation;
    Theme.Settings.statusBar;

    return Scaffold(
        appBar: null,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height >= 700
                ? MediaQuery.of(context).size.height
                : 700,
            decoration: BoxDecoration(gradient: Theme.ColorsTheme.gradient),
            child: SafeArea(
              minimum: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/logo.jpg",
                    height: 180,
                    width: 180,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Cadastro de Responsável",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    height: 310,
                    width: 350,
                    child: Card(
                      child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 25, 30, 0),
                                  child: TextFormField(
                                    controller: edtCodigo,
                                    validator: (text) {
                                      if (text.isEmpty) {
                                        return "Campo não pode ser vazio";
                                      }

                                      return null;
                                    },
                                    style: TextStyle(fontSize: 22),
                                    decoration: InputDecoration(
                                        hintText: "Código",
                                        hintStyle: TextStyle(fontSize: 22),
                                        disabledBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 25, 30, 0),
                                  child: TextFormField(
                                    //Definindo o controlador deste campo
                                    controller: edtAnexo,
                                    validator: (text) {
                                      if (text.isEmpty) {
                                        return "Campo não pode ser vazio";
                                      }

                                      return null;
                                    },
                                    style: TextStyle(fontSize: 22),
                                    decoration: InputDecoration(
                                        hintText: "Nome",
                                        hintStyle: TextStyle(fontSize: 22),
                                        disabledBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 25, 30, 0),
                                  child: TextFormField(
                                    controller: edtDesc,
                                    validator: (text) {
                                      if (text.isEmpty) {
                                        return "Campo não pode ser vazio";
                                      }

                                      return null;
                                    },
                                    style: TextStyle(fontSize: 22),
                                    maxLines: 3,
                                    maxLength: 60,
                                    decoration: InputDecoration(
                                        hintText: "Outro",
                                        hintStyle: TextStyle(fontSize: 22),
                                        disabledBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        MaterialButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              Responsibles responsibles = Responsibles(
                                  "${edtCodigo.text}", "${edtDesc.text}");

                              databaseHelper
                                  .insertResponsible(responsibles)
                                  .then((result) => print(result));
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "Salvar localmente",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          color: Colors.grey[350],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: MaterialButton(
                            onPressed: () async {
                              //Se o formulário estiver validado, irá chamar a função
                              if (_formKey.currentState.validate()) {
                                // Chama a função que irá enviar os dados do front para o back
                                addData();
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              "Enviar ao servidor",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            color: Theme.ColorsTheme.primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        databaseHelper
                            .getResponsibleMapList()
                            .then((result) => print(result));
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "Recuperar dados locais",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    color: Colors.grey[350],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future addData() async {
    //URL onde está hospedado os arquivos php
    var url = "https://testeubs.000webhostapp.com/insert.php";

    // Enviando os dados para o back end
    http.post(url, body: {
      //edtCodigo.text pega o valor que está dentro do campo Codigo e envia para a solicitação post

      "codigo": "${edtCodigo.text}",
      "name": "${edtDesc.text}"
    }).then((response) {
      print(response.body);

      //Após enviar a requisição, o app pega o retorno que é enviado do arquivo php
    });
  }
}

/*
Responsibles responsibles = Responsibles(
                                  "${edtCodigo.text}", "${edtDesc.text}");

                              databaseHelper
                                  .insertResponsible(responsibles)
                                  .then((result) => print(result));
 */
