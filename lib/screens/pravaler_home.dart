import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/disclaimers.dart';

class HomeLogin extends StatefulWidget {
  const HomeLogin({Key? key}) : super(key: key);

  @override
  _HomeLoginState createState() => _HomeLoginState();
}

class _HomeLoginState extends State<HomeLogin> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;
  Map<String, String>? values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(166, 97, 247, 1),
      body: Consumer<Disclaimers>(
        builder: (BuildContext context, Disclaimers provider, Widget? child) {
          values = provider.disclaimer;

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Semantics(
                      // Semantics - tecnica de acessibilidade das imagens
                      label: 'Logo da Pravaler',
                      child: Image.asset(
                        'assets/images/pravaler_header.png',
                        width: 150,
                        height: 56,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 240,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPageIndex = index;
                      });
                    },
                    children: [
                      _buildPageViewContainer(
                          values!.keys.toList()[0], values!.values.toList()[0]),
                      _buildPageViewContainer(
                          values!.keys.toList()[1], values!.values.toList()[1]),
                      _buildPageViewContainer(
                          values!.keys.toList()[2], values!.values.toList()[2]),
                      _buildPageViewContainer(
                          values!.keys.toList()[3], values!.values.toList()[3]),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      _buildPageViewIndicator(values!.keys.toList().length),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      /// Precisa implementar a ação do botão
                    },
                    child: const Text(
                      'Simule e cadastre',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(255, 99, 91, 1),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      'Já sou aluno. Entrar',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const PrivacyPolicyLink()
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPageViewContainer(String title, String description) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.5),
            maxLines: 2,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            description,
            style:
                const TextStyle(fontSize: 15, color: Colors.white, height: 2),
          ),
        ],
      ),
    );
  }

  /// as bolinhas no rodapé do PageView
  List<Widget> _buildPageViewIndicator(int sizeList) {
    List<Widget> indicators = [];
    for (int i = 0; i < sizeList; i++) {
      indicators.add(GestureDetector(
        onTap: () {
          _pageController.animateToPage(
            i,
            duration: const Duration(milliseconds: 750),
            curve: Curves.easeInOutCirc,
          );
          setState(() {
            _currentPageIndex = i;
          });
        },
        child: Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPageIndex == i
                ? const Color.fromRGBO(255, 99, 91, 1)
                : Colors.white,
          ),
        ),
      ));
    }
    return indicators;
  }
}

class PrivacyPolicyLink extends StatelessWidget {
  const PrivacyPolicyLink({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var url = Uri.parse(
            'https://www.pravaler.com.br/wp-content/uploads/2020/03/Termos-e-Condi%C3%A7%C3%B5es-de-Uso-PRAVALER.pdf');
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'Não foi possível abrir $url';
        }
      },
      child: const MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Center(
          child: Text(
            'TERMOS DE PRIVACIDADE E UTILIZAÇÃO DE DADOS',
            style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }
}
