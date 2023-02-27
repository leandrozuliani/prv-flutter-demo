import 'package:intl/intl.dart';

import 'boleto_parcela.dart';

class Boleto {
  String periodo;
  String curso;
  String codigoDeBarras;
  DateTime dataContratacao;
  DateTime dataUltimoVencimento;
  double taxaJuros;
  double multaMora;
  double valorTotal;
  List<BoletoParcela> parcelas;

  Boleto({
    required this.periodo,
    required this.curso,
    required this.codigoDeBarras,
    required this.dataContratacao,
    required this.dataUltimoVencimento,
    required this.taxaJuros,
    required this.multaMora,
    required this.valorTotal,
    required this.parcelas,
  });

  factory Boleto.fromJson(Map<String, dynamic> json) {
    List<BoletoParcela> parcelas = [];
    for (var parcela in json['parcelas']) {
      parcelas.add(BoletoParcela.fromJson(parcela));
    }

    return Boleto(
      periodo: json['periodo'],
      curso: json['curso'],
      codigoDeBarras: json['codigoDeBarras'],
      dataContratacao: DateTime.parse(json['dataContratacao']),
      dataUltimoVencimento: DateTime.parse(json['dataUltimoVencimento']),
      taxaJuros: json['taxaJuros'],
      multaMora: json['multaMora'],
      valorTotal: json['valorTotal'],
      parcelas: parcelas,
    );
  }

  static Map<dynamic, String> formatBoletoInfo(Boleto boleto) {
    return {
      'valorParcela': NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
          .format(boleto.parcelas[5].valorParcela),
      'dataUltimoVencimento':
          DateFormat('dd/MM/yyyy').format(boleto.dataUltimoVencimento),
      'dataContratacao':
          DateFormat('dd/MM/yyyy').format(boleto.dataContratacao),
      'parcelaAtual':
          '${boleto.parcelas[5].numeroParcela} de ${boleto.parcelas.length}',
      'codigoDeBarras': boleto.codigoDeBarras,
    };
  }
}
