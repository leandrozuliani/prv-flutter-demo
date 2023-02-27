import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'models/boleto.dart';
import 'models/boleto_parcela.dart';
import 'providers/disclaimers.dart';
import 'screens/pravaler_boleto.dart';
import 'screens/pravaler_home.dart';
import 'screens/pravaler_login_form.dart';
import 'screens/pravaler_splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Disclaimers>(create: (BuildContext context) {
          Map<String, String> values = {
            "Precisa de uma forcinha para pagar seus estudos?":
                "O Pravaler é uma empresa de crédito estudantil que tem como objetivo facilitar a forma de pagamento para você estudar",
            "Faça toda contratação do financiamento online":
                "Depois de preencher o cadastro toda nossa análise de crédito até a assinatura do contrato é feita online",
            "Preencha o cadastro e veja nossas opções de pagamento":
                "Durante o cadastro você pode avaliar qual a opção de pagamento que mais se encaixa no seu orçamento",
            "Boletos das mensalidades do semestre no aplicativo":
                "Depois que você vira aluno Pravaler nós disponibilizamos todos os boletos referentes as mensalidades do curso dentro do aplicativo",
          };
          return Disclaimers(disclaimer: values);
        }),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pravaler',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const Splash(),
      routes: {
        '/home': (context) => const HomeLogin(),
        '/login': (context) => const LoginForm(),
        // '/payments': (context) {
        //   return Payments2();
        // },
        '/payments': (routeContext) => FutureBuilder<Boleto>(
              future: getBillet(),
              builder: (buildContext, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  final boleto = snapshot.data!;
                  return BilletInformation(boleto: boleto);
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Text('Erro ao tentar processar JSON local'));
                } else {
                  return Container();
                }
              },
            ),
      },
      initialRoute: '/',
    );
  }

  // getBillet() - simula o backend trazendo os dados do boleto
  Future<Boleto> getBillet() async {
    final jsonString = await rootBundle.loadString('mocks/financiamento.json');
    final jsonData = json.decode(jsonString);

    final List<BoletoParcela> parcelas = List<BoletoParcela>.from(
        jsonData['parcelas'].map((parcela) => BoletoParcela.fromJson(parcela)));

    final boleto = Boleto(
      parcelas: parcelas,
      taxaJuros: jsonData['taxaJuros'].toDouble(),
      multaMora: jsonData['multaMora'].toDouble(),
      valorTotal: jsonData['valorTotal'].toDouble(),
      periodo: jsonData['periodo'],
      curso: jsonData['curso'],
      dataContratacao: DateTime.parse(jsonData['dataContratacao']),
      dataUltimoVencimento: DateTime.parse(jsonData['dataUltimoVencimento']),
      codigoDeBarras: jsonData['codigoDeBarras'],
    );

    return boleto;
  }
}
