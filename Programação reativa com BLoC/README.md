## Flutter: Streams de programação reativa com BLoC

---

### Aula 01 - Bloc e flutter bloc

- Criando seus blocs e cubit;
- BlocProvider, BlocConsumer, BlocBuilder;
- Cubit;
- Gerenciando seu estado;
- Primitivo e objeto como estado.

### Aula 02 - Integrando telas

- Mais widgets;
- Integrando telas;
- BlocListener.

### Aula 03 - Criando um framework

- Criando um framework pra gerenciamento de estado;
- Separando UI, estado, e eventos;
- Polimorfismo em Dart.

### Aula 04 - Formulários e bloc

- Como lidar com assincronicidade no meio de uma tela;
- Formulários e bloc;
- Envio e sucesso assíncrono;
- Falha assíncrona.

## Flutter i18n: entenda abordagens de internacionalização

---

### Aula 01 - Componentes de internacionalização

- A _localização_ (`l18n`) é relacionada com a formatação de data, moeda, números em geral, etc (o seu app se adapta ao local);
- A _internacionalização_ (`i18n`) é relacionada ao atender vários idiomas;
- Para trabalhar com a _Internacionalização_, usamos o `LocalizationContainer`, que deve estender o `StatelessContainer` (ou `BlocContainer`), que encapsula a linguagem (`Cubit<String>`) e associa ao _context_;
- Usamos um componente de i18n por tela, que encapsula a recuperação das mensagens.

### Aula 02 - Assert e mensagens _eager_

- Como usamos uma _cláusula de guarda_ (`assert`) para validar o argumento;
- Que o `assert` deve ser usado para validar erros de desenvolvimento (que não são de negócio);
- Que o `assert` precisa ser habilitado na compilação;
- Que normalmente usamos o `_` para constantes;
- Por que faz sentido carregar mensagens de maneira lazy.

### Aula 03 - I18n de maneira lazy

- Como construir uma tela para mostrar o carregamento das mensagens (`ProgressView`);
- Que as mensagens são carregados através de um evento (`emit`);
- Que a aplicação usa o `DashboardContainer`, que usa o `I18NLoadingContainer` como `child`, para carregar as mensagens e, quando carregou, chamamos a `DashboardView`;
- Que a `DashboardView` recebe as mensagens que serão carregadas _lazy_.

### Aula 04 - Várias telas e localizações

- Que as mensagens devem estar em um servidor da sua escolha, dentro de um arquivo JSON;
- Como usamos o `HttpClient` para executar a requisição HTTP (não era novidade!);
- Como carregar as mensagens de maneira assíncrona;
- Como dar suporte a várias linguagens, usando URLs diferentes;
- Como carregar as mensagens da aplicação inteira ou tela por tela:
  - Usamos o nome da tela para o arquivo de mensagem;
  - Usando, por exemplo, `dashboard_en.json` ou `dashboard_pt.json`.
