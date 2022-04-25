## Flutter: Firebase Crashlytics, gere relatórios de erro em tempo real

---

### Aula 01 - Exceções e Crashlytics

- O que é o Firebase e Crashlytics
  - Firebase é uma suíte de soluções mantida pela Google e que entrega uma série de funcionalidades para facilitar a vida de desenvolvedores e desenvolvedoras. Uma dessas funcionalidades é o Crashlytics que nos permite registrar em nuvem erros ocorridos em apps.
- Como configurar o Firebase e o Crashlytics em um projeto nativo Android
  - Como o Crashlytics é uma funcionalidade do Firebase, automaticamente ele tem como dependência o próprio. Então, configuramos nativamente importando o Firebase para posteriormente importar o Crashlytics.
- Crashlytics e Firebase unidos ao Flutter
  - Para comunicar erros ocorridos no Flutter ao Crashlytics através da configuração criada no código nativo, instalamos as extensões necessárias no Flutter e através de uma instância do plugin do Crashlytics para Flutter simulamos o primeiro erro fatal no aplicativo.
- Console Firebase
  - O Console Firebase é o responsável por gerar uma forma intuitiva de configurarmos as soluções oferecidas e ver relatórios de uso e registros de erros e gerar comunicação entre aplicativo e Firebase.
- Exceções
  - Aprendemos mais sobre o termo exceção, como podemos gerar e capturar exceções geradas por algum ocorrido inesperado.