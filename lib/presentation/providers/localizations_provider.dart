import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:invoice/domain/models/localization.dart';

// final localizationListProvider = Provider((ref) => Localization(id, locale));

class LocalizationDetailsNotifier extends StateNotifier<Localization> {
  LocalizationDetailsNotifier(super.state);

  String getLocalization()  {
    return state.locale;
  }
  void changeLocale(Localization newLocale) {
    state = newLocale;
  }
}

final localizationProvider = StateNotifierProvider<LocalizationDetailsNotifier, Localization>(
        (ref) => LocalizationDetailsNotifier(localizations[0]));
