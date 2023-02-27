import 'package:flutter/material.dart';

class PravalerProgressIndicator extends StatelessWidget {
  final int parcelasPagas;
  final int totalParcelas;
  final double porcentagemPreenchida;

  const PravalerProgressIndicator({
    Key? key,
    required this.parcelasPagas,
    required this.totalParcelas,
    required this.porcentagemPreenchida,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: Semantics(
                  label:
                      'Gráfico parcelas pagas: ${porcentagemPreenchida * 100} preenchido',
                  child: CircularProgressIndicator(
                    value: porcentagemPreenchida,
                    strokeWidth: 12,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(255, 99, 91, 1)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Parcelas pagas',
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.none,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      '$parcelasPagas de $totalParcelas',
                      style: const TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.none,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
