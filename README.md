### Teste pravaler 

## Screens

 A aplicação é composta por quatro telas: `Splash Screen`, `Home`, `Login Form` e `Boleto`.

1. `Splash Screen`: A Splash Screen é a primeira tela que é exibida na aplicação, sendo composta por uma imagem que é animada em fade-in. Após a animação, a tela redireciona para a Home.

2. `Home`: A Home é a tela que apresenta opções para o usuário cadastrar e as mensagens de marketing.

Apenas o botão "Já sou cliente. Entre" está ativo e redirecionando para a tela de login, os demais elementos visuais são apenas ilustrativos para este teste.

Uma lista de textos do marketing é recuperada do main.dart usando Consumer<Disclaimers> que é um Provider. Houve apenas esta utilização para demostrar o conhecimento em gerenciamento de estados.

3. `LoginForm`: A tela de Login Form é responsável pelo preenchimento dos dados de login (CPF e senha), um botão de submit e um link 'Esqueci minha senha' porém, nessa versão, a lógica de autenticação ainda não foi implementada pois necessita do Firebase ou backend.

4. `Boleto`: A tela Boleto apresenta informações sobre um boleto e suas parcelas, como informações de pagamento e valores. Os valores do boleto são consumidos de um JSON local usando Future, simulando um JSON na web.


## Modelos
O app utiliza 2 modelos: `Boleto` e `BoletoParcela`, que são responsáveis por representar o boleto e suas parcelas. O JSON utilizado na aplicação é simples e pode ser encontrado em `assets/mocks/financiamento.json`. 
A formatação dos dados em valores monetários fica no próprio modelo Boleto em um método estático.


## Referencia de layout:
1. SplashScreen, Home e Login foi inspirado conforme a própria aplicação disponibilizada na Loja.
2. Tela do boleto - https://is4-ssl.mzstatic.com/image/thumb/PurpleSource112/v4/29/c0/65/29c06522-16ef-0de4-1adb-fddef3297349/a49bd2e5-a2d5-45c0-8f54-4cc50de14ba6_boletos.png/313x0w.webp


## Como Executar
- flutter pub get

Para rodar a aplicação na web:
- flutter run -d Chrome

