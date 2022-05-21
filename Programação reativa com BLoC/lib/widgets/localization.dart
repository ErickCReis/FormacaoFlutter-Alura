import 'package:bytebank/widgets/bloc_container.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalizationContainer extends BlocContainer {
  final Widget child;

  const LocalizationContainer({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentLocaleCubit>(
      create: (_) => CurrentLocaleCubit(),
      child: child,
    );
  }
}

class CurrentLocaleCubit extends Cubit<String> {
  CurrentLocaleCubit() : super('pt-br');
}

class ViewI18N {
  late String _language;

  ViewI18N(BuildContext context) {
    _language = context.read<CurrentLocaleCubit>().state;
  }

  String localize(Map<String, String> map) {
    assert(map.isNotEmpty);
    return map[_language] ?? map.values.first;
  }
}
