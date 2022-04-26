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

  ### Aula 02 - Tipos de exceções

- O que é uma exceção de app
  - Aprendemos o que é uma exceção de app e quais são os momentos em que ela pode ocorrer. - Consideramos exceções de app tudo o que está diretamente ligado ao ambiente em que o - aplicativo está em contato (sistema operacional, permissões, espaço em disco e memória e - afins)
- O que é uma exceção web
  - Aprendemos o que é uma exceção web, erros mais comuns que encontraremos e por quais motivos apesar de serem comportamentos excepcionais as exceções web não são necessariamente um erro e sim um comportamento fora do desejado.
- Chaves no Crashlytics
  - Aprendemos como utilizar as chaves para passar o máximo de informações possíveis sobre o - momento em que a exceção foi registrada para facilitar o processo analítico e a tomada de - decisão com relação ao ocorrido para a aplicação de futuras correções.
- Cadastro de exceções não detectadas
  - Como vimos, nem tudo são erros. Também existem comportamentos não desejados que consideramos errôneos. Logo, podemos considerar como uma exceção não detectada automaticamente pelo Crashlytics no Flutter e precisamos informar manualmente ao Crashlytics de que queremos que ele registre esta falha através do comando `recordError`.