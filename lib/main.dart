import 'package:flutter/material.dart';
import 'data/moedas_data.dart';
import 'models/moeda_model.dart';

void main() {
  runApp(const FlexConvert());
}

class FlexConvert extends StatelessWidget {
  const FlexConvert({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlexConvert',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController controller = TextEditingController();

  MoedaModel moedaOrigem = moedas[0];
  MoedaModel moedaDestino = moedas[1];

  double resultado = 0;

  void converter() {
    double valor = double.tryParse(controller.text) ?? 0;

    double emDolar = valor * moedaOrigem.valorEmDolar;
    double convertido = emDolar / moedaDestino.valorEmDolar;

    setState(() {
      resultado = convertido;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("FlexConvert"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Valor",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => converter(),
            ),

            const SizedBox(height: 20),

            DropdownButton<MoedaModel>(
              value: moedaOrigem,
              isExpanded: true,
              items: moedas.map((moeda) {
                return DropdownMenuItem(
                  value: moeda,
                  child: Text(moeda.nome),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  moedaOrigem = value!;
                  converter();
                });
              },
            ),

            const SizedBox(height: 10),

            DropdownButton<MoedaModel>(
              value: moedaDestino,
              isExpanded: true,
              items: moedas.map((moeda) {
                return DropdownMenuItem(
                  value: moeda,
                  child: Text(moeda.nome),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  moedaDestino = value!;
                  converter();
                });
              },
            ),

            const SizedBox(height: 30),

            Text(
              "Resultado: ${resultado.toStringAsFixed(2)} ${moedaDestino.sigla}",
              style: const TextStyle(fontSize: 22),
            )
          ],
        ),
      ),
    );
  }
}