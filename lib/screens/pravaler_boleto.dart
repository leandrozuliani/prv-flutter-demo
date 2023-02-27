import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/progressbar_parcelas_pagas.dart';
import '../enums/billet_tabs.dart';
import '../models/boleto.dart';

/// Informações do boleto em dia, em atraso e das parcelas.
class BilletInformation extends StatefulWidget {
  final Boleto boleto;

  const BilletInformation({Key? key, required this.boleto}) : super(key: key);

  @override
  _BilletInformationState createState() => _BilletInformationState();
}

class _BilletInformationState extends State<BilletInformation> {
  int _activeTab = BilletTabs.emDia.index;
  late final Boleto _boleto;

  @override
  void initState() {
    super.initState();
    _boleto = widget.boleto;
  }

  void setActiveTab(int value) {
    setState(() {
      _activeTab = value.clamp(1, BilletTabs.values.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    final qtdeParcelasPagas =
        _boleto.parcelas.where((parcela) => parcela.status == "PAGO").length;
    final qtdeTotalParcelas = _boleto.parcelas.length;
    final valorDecimalParcelasPagas =
        (qtdeParcelasPagas / qtdeTotalParcelas).clamp(0.01, 1.0);

    return Scaffold(
      key: const Key('boleto'),
      body: Column(
        children: [
          PravalerProgressIndicator(
            parcelasPagas: qtdeParcelasPagas,
            totalParcelas: qtdeTotalParcelas,
            porcentagemPreenchida: valorDecimalParcelasPagas,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: TextButton(
                    onPressed: () {
                      setActiveTab(1);
                    },
                    child: _TabPayment('Atual', BilletTabs.emDia.index),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  child: TextButton(
                    onPressed: () {
                      setActiveTab(2);
                    },
                    child: _TabPayment('Em atraso', BilletTabs.emAtraso.index),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  child: TextButton(
                    onPressed: () {
                      setActiveTab(3);
                    },
                    child: _TabPayment('Todos', BilletTabs.todos.index),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 0),
              child: Column(
                children: [
                  if (_activeTab == BilletTabs.emDia.index)
                    Container(
                      height: MediaQuery.of(context).size.height - 160,
                      color: Colors.transparent,
                      child: SingleChildScrollView(
                        child: ConteudoBoletoEmDia(
                          boleto: _boleto,
                        ),
                      ),
                    ),
                  if (_activeTab == BilletTabs.emAtraso.index)
                    Container(
                      height: MediaQuery.of(context).size.height - 170,
                      color: Colors.transparent,
                      child: const Center(
                        child: Text('Conteúdo da aba "Em atraso"'),
                      ),
                    ),
                  if (_activeTab == BilletTabs.todos.index)
                    Container(
                      height: MediaQuery.of(context).size.height - 170,
                      color: Colors.transparent,
                      child: const Center(
                        child: Text('Conteúdo da aba "Todos"'),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _TabPayment(String label, int tab) {
    return Container(
      alignment: Alignment.center,
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: _activeTab == tab
                ? const Color.fromRGBO(255, 99, 91, 1)
                : Colors.transparent,
            width: 3,
          ),
        ),
      ),
      child: Text(
        label,
        style: _activeTab == tab
            ? const TextStyle(
                color: Color.fromRGBO(255, 99, 91, 1),
                fontWeight: FontWeight.bold,
              )
            : const TextStyle(
                color: Colors.black54,
              ),
      ),
    );
  }
}

class ConteudoBoletoEmDia extends StatefulWidget {
  final Boleto boleto;

  const ConteudoBoletoEmDia({Key? key, required this.boleto}) : super(key: key);

  @override
  State<ConteudoBoletoEmDia> createState() => _ConteudoBoletoEmDiaState();
}

class _ConteudoBoletoEmDiaState extends State<ConteudoBoletoEmDia> {
  @override
  Widget build(BuildContext context) {
    final boletoFormatado = Boleto.formatBoletoInfo(widget.boleto);

    return widget.boleto.parcelas.isEmpty
        ? const Text('Ocorreu um erro inesperado')
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Seu boleto vence em breve!\nCopie o código de barras abaixo para pagar',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Valor do boleto',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            boletoFormatado['valorParcela']!,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            'Data de vencimento',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            boletoFormatado['dataUltimoVencimento']!,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nº da parcela:',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            boletoFormatado['parcelaAtual']!,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            'Data contratação',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            boletoFormatado['dataContratacao']!,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  readOnly: true,
                  maxLines: 2,
                  onTap: () {
                    /// implementar função de copiar o código de barras
                    /// ao clicar no input seleciona tudo
                  },
                  controller: TextEditingController(
                    text: boletoFormatado['codigoDeBarras']!,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: '',
                    labelText: 'Código de barras do boleto:',
                    labelStyle: TextStyle(
                      backgroundColor: Colors.transparent,
                      color: Colors.grey[600],
                      height: 2,
                      fontSize: 18,
                    ),
                    alignLabelWithHint: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    letterSpacing: 1.5,
                    color: Colors.grey[600],
                  ),
                  autofocus: true,
                  enableInteractiveSelection: true,
                  textAlign: TextAlign.center,
                ),
              ),
              CopiarCodigoBoleto(boletoFormatado: boletoFormatado)
            ],
          );
  }
}

class CopiarCodigoBoleto extends StatelessWidget {
  const CopiarCodigoBoleto({
    Key? key,
    required this.boletoFormatado,
  }) : super(key: key);

  final Map<dynamic, String> boletoFormatado;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(255, 99, 91, 1),
          minimumSize: const Size(double.infinity, 60),
        ),
        onPressed: () {
          Clipboard.setData(
                  ClipboardData(text: boletoFormatado['codigoDeBarras']!))
              .then(
            (value) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text('Código de barras copiado!'),
                ),
              ),
            ),
          );
        },
        child: const Text(
          'Copiar código do boleto',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
