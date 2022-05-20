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
- Usamos um componente de i18n por tela, que encapsula a recuperação das mensagens
