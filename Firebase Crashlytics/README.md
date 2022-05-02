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

  ### Aula 03 - Rastreamento de usuário

- Identificação de usuários
  - Aprendemos a registrar no relatório de erros quem é o usuário que vivenciou a exceção, com isso, é possível futuramente pensar em maneiras de rastrear o erro e tomar decisões de correção assertivas com base em casos específicos.
- Dashboard do Crashlytics
  - Aprendemos a realizar a correta visualização de dados para entender e explorar ao máximo os recursos que o Crashlytics traz para nós. Visualizamos filtros, opções de busca, detalhamento de erros, chaves, dispositivo e disponibilidade de hardware e afins.
- Configuração de debug
  - Vimos como configurar as chamadas do Crashlytics assim como a configuração inicial para que ele somente registre os relatórios de erro em ocasiões necessárias visando não poluir o dashboard com dados não relevantes ao analista de erros.

  ### Aula 04 - Mensagem de erro

- Definição das zonas de erro
  - Aprendemos a definir zonas de erro que garantem que nada passe despercebido pelo monitoramento de exceções caso algo ocorra algo de errado e o Flutter não seja capaz de perceber o ocorrido.
- Implementação do SnackBar
  - Aprendemos a realizar a implementação do widget SnackBar na nossa aplicação e entendemos como ele pode ser uma alternativa discreta e que oferece uma funcionalidade para darmos ao usuário como um botão na mensagem, por exemplo.
- Implementação do Toast
  - Vimos como podemos utilizar a extensão do Toast para exibir mensagens extremamente minimalistas e simples aos usuários de maneira objetiva e rápida.
- Dark Patterns
  - Vimos o que são dark patterns e abrimos caminho para estudar mais a fundo o tema.