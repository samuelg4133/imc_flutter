import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculador de IMC',
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Asap',
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _msg = "Informe seus dados!";

  void _limpar() {
    pesoController.text = "";
    alturaController.text = "";

    setState(() {
      _msg = "Informe seus dados";
    });
  }

  void _calcular() {
    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text) / 100;

    double imc = peso / (altura * altura);

    print(imc);

    setState(() {
      if (imc >= 30) {
        _msg = "Seu imc é de ${imc.toStringAsFixed(2)}. \nVocê está obeso!";
      } else if (imc >= 25) {
        _msg = "Seu imc é de ${imc.toStringAsFixed(2)}. \nVocê tem sobrepeso!";
      } else if (imc >= 18.5) {
        _msg =
            "Seu imc é de ${imc.toStringAsFixed(2)}. \nVocê tem peso normal!";
      } else if (imc < 18.5) {
        _msg = "Seu imc é de ${imc.toStringAsFixed(2)}. \nVocê está magro!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculadora IMC',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _limpar,
            color: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Image.network(
                    'https://image.freepik.com/vetores-gratis/fit-pessoas-fazendo-exercicio_18591-41275.jpg',
                    height: 150.0,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Peso (Kg)',
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0),
                  controller: pesoController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Informe seu peso";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Altura (cm)',
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0),
                  controller: alturaController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Informe sua altura";
                    }
                  },
                ),
                RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _calcular();
                    }
                  },
                  color: Colors.green,
                  child: Text(
                    'Calcular',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "$_msg",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
