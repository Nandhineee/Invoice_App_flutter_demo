import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice/domain/models/localization.dart';

import 'package:invoice/presentation/pages/sign_in/login.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:invoice/presentation/providers/localizations_provider.dart';



class MyApp extends  ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {



  @override
  Widget build(BuildContext context) {
     // ref.watch(localizationProvider).locale;
    final Localization appLocale = ref.watch(localizationProvider);
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale(appLocale.locale),

      home: const Login(),
    );


  }

}




