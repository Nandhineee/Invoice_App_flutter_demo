import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice/domain/models/localization.dart';
import 'package:invoice/presentation/pages/sign_in/login.dart';
import 'package:invoice/presentation/pages/tabs/all_invoice.dart';
import 'package:invoice/presentation/pages/tabs/paid_invoice.dart';
import 'package:invoice/presentation/pages/tabs/unpaid_invoice.dart';
import 'package:invoice/presentation/providers/localizations_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import 'create_invoice.dart';


class HomePage extends ConsumerStatefulWidget {
  const HomePage(

      {super.key});



  @override
  ConsumerState<HomePage> createState() => _HomePage();
}

class _HomePage extends ConsumerState<HomePage> with SingleTickerProviderStateMixin {


  late TabController _tabController;
  late Localization _selectedLocalization = localizations.first;


  @override
  void initState() {
    _tabController= TabController(length: 3, vsync: this,initialIndex: 0,);

    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    ref.watch(localizationProvider);
    return Scaffold(
      appBar: AppBar(


        leading: IconButton(
          icon: const Text('<', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Login()),
            );
          },
        ),
        title:   Center(

            child: Text(AppLocalizations.of(context)!.title_message,
              style: const TextStyle(fontSize: 30.0,color:Colors.black ),
            )
        ),

        actions: <Widget>[
          // Use a Row to provide enough space for the DropdownButton
          Row(
            children: [
              DropdownButton<Localization>(
                value:_selectedLocalization,
                icon: const Icon(Icons.language),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                // underline: Container(
                //   height: 2,
                //   color: Colors.deepPurpleAccent,
                // ),
                onChanged: (Localization? newLocale) {
                  setState(() {
                    _selectedLocalization = newLocale!;

                  });
                  if (newLocale != null) {
                    ref.read(localizationProvider.notifier).changeLocale(_selectedLocalization);

                  }
                },
                items: localizations.map<DropdownMenuItem<Localization>>((Localization localization) {
                  return DropdownMenuItem<Localization>(
                    value: localization,
                    child: Text(localization.locale),
                  );
                }).toList(),

              ),
            ],
          ),
        ],


        bottom: TabBar(
          indicatorColor: Colors.blue[900],
          controller: _tabController,
          tabs: <Widget>[
            Tab(text: AppLocalizations.of(context)!.all),
            Tab(text: AppLocalizations.of(context)!.paid),
            Tab(text: AppLocalizations.of(context)!.unpaid),
          ],

        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            AllInvoice(),
            Paid(),
            Unpaid(),
          ]
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateScreen()),
          ).then((value) => setState(() {print("homepage");
          }));

        },
        backgroundColor: Colors.blue[900], // Background color of the button
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white, // Set the icon color to white
        ),
      ),

    );

  }
}
