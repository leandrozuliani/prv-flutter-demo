class BoletoParcela {
  int numeroParcela;
  String status; // ou poderia ser com enum ParcelaStatus
  DateTime dataVencimento;
  double valorParcela;
  int diasAtraso;

  BoletoParcela({
    required this.numeroParcela,
    required this.status,
    required this.dataVencimento,
    required this.valorParcela,
    required this.diasAtraso,
  });

  factory BoletoParcela.fromJson(Map<String, dynamic> json) {
    return BoletoParcela(
      numeroParcela: json['numeroParcela'],
      status: json['status'],
      dataVencimento: DateTime.parse(json['dataVencimento']),
      valorParcela: json['valorParcela'],
      diasAtraso: json['diasAtraso'],
    );
  }
}
