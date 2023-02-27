import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _cpfController = TextEditingController();
  final _senhaController = TextEditingController();

  bool _showPassword = false;
  bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    _cpfController.addListener(_validateForm);
    _senhaController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _cpfController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final _cpf = _cpfController.text.replaceAll(RegExp(r'[^\d]'), '');
    String _senha = _senhaController.text;

    setState(() {
      _isButtonDisabled = !(_cpf.length == 11 && _senha.length >= 6);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Digite seus dados",
          style: TextStyle(
            decoration: TextDecoration.none,
            color: Color.fromRGBO(255, 99, 91, 1),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color.fromRGBO(255, 99, 91, 1)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  maxLength: 11,
                  controller: _cpfController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: 'Informe seu CPF',
                    hintText: '00000000000',
                    labelStyle: TextStyle(
                      color: _cpfController.text.isEmpty
                          ? Colors.grey
                          : const Color.fromRGBO(255, 99, 91, 1),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(255, 99, 91, 1),
                      ),
                    ),
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Por favor, informe o seu CPF';
                    }
                    if (value!.replaceAll(RegExp(r'[^\d]'), '').length != 11) {
                      return 'O CPF deve conter 11 dígitos';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _senhaController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    labelText: 'Digite sua senha',
                    labelStyle: TextStyle(
                      color: _senhaController.text.isEmpty
                          ? Colors.grey
                          : const Color.fromRGBO(255, 99, 91, 1),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(255, 99, 91, 1),
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Semantics(
                        label:
                            _showPassword ? 'Esconder senha' : 'Exibir senha',
                        child: Icon(
                          _showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                  validator: (String? value) {
                    if ((value?.isEmpty ?? true) || (value!.length < 6)) {
                      return 'Por favor, informe sua senha';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: _isButtonDisabled
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              // final cpf = _cpfController.text;
                              // final senha = _senhaController.text;

                              // login não implementado
                              Navigator.pushReplacementNamed(
                                  context, '/payments');
                            }
                          },
                    child: const Text('Entrar'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => _isButtonDisabled
                              ? Colors.grey
                              : const Color.fromRGBO(255, 99, 91, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: TextButton(
                    onPressed: () {
                      // implementar ação do link
                    },
                    child: const Text(
                      'Esqueci minha senha',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color.fromRGBO(255, 99, 91, 1),
                      ),
                    ),
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      foregroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(255, 99, 91, 1)),
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
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
