import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields() {
    setState(() {
      weightController.text = "";
      heightController.text = "";
      _infoText = "Informe seus dados";
    });
  }

  void calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text);
      double imc = weight / (height * height);
      print(imc);
      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.99) {
        _infoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.99 && imc < 29.99) {
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.99 && imc < 34.99) {
        _infoText = "Obesidade grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.99 && imc < 39.99) {
        _infoText = "Obesidade grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Body Mass Index'),
        centerTitle: true,
        backgroundColor: Colors.pink,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _resetFields();
              })
        ],
      ),
      body: Stack(
        children: <Widget>[
          Image.asset(
            "images/h.jpeg",
            fit: BoxFit.fitWidth,
            width: double.maxFinite,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(25, 2, 25, 2),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Icon(
                      Icons.person_outline,
                      size: 120,
                      color: Colors.pink,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Peso (KG)",
                          labelStyle: TextStyle(
                              color: Colors.pink,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.pink,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                        controller: weightController,
                        // ignore: missing_return
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira seu peso";
                          }
                        }),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Altura (M)",
                        labelStyle: TextStyle(
                            color: Colors.pink,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      textAlign: TextAlign.center,
                      controller: heightController,
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira sua altura";
                        }
                      },
                      style: TextStyle(
                          color: Colors.pink,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(107, 50, 107, 0.0),
                      child: Container(
                        height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              calculate();
                            }
                          },
                          child: Text(
                            "Calcular",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          color: Colors.pink,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        _infoText,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
