import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:bytebank/widgets/bloc_container.dart';
import 'package:bytebank/widgets/centered_message.dart';
import 'package:bytebank/widgets/contact_item.dart';
import 'package:bytebank/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
abstract class ContactsListState {
  const ContactsListState();
}

@immutable
class InitContactsListState extends ContactsListState {
  const InitContactsListState();
}

@immutable
class LoadingContactsListState extends ContactsListState {
  const LoadingContactsListState();
}

@immutable
class LoadedContactsListState extends ContactsListState {
  final List<Contact> _contacts;

  const LoadedContactsListState(this._contacts);
}

@immutable
class EmptyContactsListState extends ContactsListState {
  const EmptyContactsListState();
}

@immutable
class FatalErrorContactsListState extends ContactsListState {
  const FatalErrorContactsListState();
}

class ContactsListCubit extends Cubit<ContactsListState> {
  ContactsListCubit() : super(const InitContactsListState());

  void reload(ContactDao dao) async {
    emit(const LoadingContactsListState());

    try {
      final contacts = await dao.findAll();

      if (contacts.isEmpty) {
        emit(const EmptyContactsListState());
      } else {
        emit(LoadedContactsListState(contacts));
      }
    } catch (e) {
      emit(const FatalErrorContactsListState());
    }
  }
}

class ContactsListContainer extends BlocContainer {
  const ContactsListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ContactDao _dao = ContactDao();
    return BlocProvider<ContactsListCubit>(
      create: (_) {
        final cubit = ContactsListCubit();
        cubit.reload(_dao);

        return cubit;
      },
      child: ContactsListView(_dao),
    );
  }
}

class ContactsListView extends StatelessWidget {
  final ContactDao _dao;

  const ContactsListView(this._dao, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
      ),
      body: BlocBuilder<ContactsListCubit, ContactsListState>(
        builder: (_, state) {
          if (state is InitContactsListState ||
              state is LoadingContactsListState) {
            return const Progress();
          }

          if (state is EmptyContactsListState) {
            return const CenteredMessage(
              'No contacts found',
              icon: Icons.warning,
            );
          }

          if (state is LoadedContactsListState) {
            final contacts = state._contacts;

            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final Contact contact = contacts[index];
                return ContactItem(
                  contact,
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TransactionForm(contact),
                      ),
                    );
                  },
                );
              },
            );
          }

          return const CenteredMessage('Unknown error');
        },
      ),
      floatingActionButton: buildAddContactButton(context),
    );
  }

  FloatingActionButton buildAddContactButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const ContactForm(),
          ),
        );

        update(context);
      },
      child: const Icon(
        Icons.add,
      ),
    );
  }

  void update(BuildContext context) {
    context.read<ContactsListCubit>().reload(_dao);
  }
}
