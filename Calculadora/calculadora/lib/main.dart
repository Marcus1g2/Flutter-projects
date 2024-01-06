import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculadora",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const Calculadora(),
    );
  }
}

class Calculadora extends StatefulWidget {
  const Calculadora({Key? key}) : super(key: key);

  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  late String display;
  late String primeiro;
  late String segundo;
  late String operador;
  late bool desabilitarBotao;

  @override
  void initState() {
    super.initState();
    clear();
  }

  void inserir(String input) {
    if (input == '0' &&
        (operador.isEmpty && primeiro.isEmpty ||
            operador.isNotEmpty && segundo.isEmpty)) {
      return;
    }

    if (['x', '-', '+', '/'].contains(input)) {
      if (primeiro.isEmpty) {
        primeiro = '0';
      }

      operador = input;
    } else {
      if (operador.isEmpty) {
        primeiro += input;
      } else {
        segundo += input;
      }
    }

    setState(() {
      if (operador.isEmpty) {
        display = primeiro;
      } else {
        if (segundo.isEmpty) {
          display = '$primeiro $operador';
        } else {
          display = '$primeiro $operador $segundo';
          desabilitarBotao = true;
        }
      }
    });
  }

  void clear() {
    setState(() {
      display = "0";
      primeiro = "";
      segundo = "";
      operador = "";
      desabilitarBotao = false;
    });
  }

  void calcular() {
    double resultado = 0;
    double num1 = double.parse(primeiro);
    double num2 = double.parse(segundo);

    switch (operador) {
      case "*":
        resultado = num1 * num2;
        break;
      case "/":
        resultado = num1 / num2;
        break;
      case "+":
        resultado = num1 + num2;
        break;
      case "-":
        resultado = num1 - num2;
        break;
    }

    setState(() {
      display = "$resultado";
      primeiro = "$resultado";
      segundo = "";
      desabilitarBotao = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculadora simples")),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: 70.0),
        child: FloatingActionButton(
          onPressed: clear,
          child: const Text("C"),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 3, child: Text(display)),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (String numero in ["7", "8", "9", "/"])
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => inserir(numero),
                      child: Text(numero),
                    ),
                  )
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (String numero in ["4", "5", "6", "*"])
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => inserir(numero),
                      child: Text(numero),
                    ),
                  ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (String numero in ["1", "2", "3", "-"])
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => inserir(numero),
                            child: Text(numero),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => inserir("0"),
                          child: Text("0"),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => inserir("+"),
                          child: Text("+"),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: calcular,
                          child: Text("="),
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
    );
  }
}
