import 'package:get/get.dart';

import 'langs/en_lang.dart';
import 'langs/cn_lang.dart';
import 'langs/kh_lang.dart';
import 'utils/constants.dart';

class CoreTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    LanguageConstants.ENGLISH: enLanguage,
    LanguageConstants.CHINESE: cnLanguage,
    LanguageConstants.KHMER: khLanguage,
  };
}

