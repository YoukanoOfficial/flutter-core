import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../storage/local_storage.dart';
import '../../storage/local_storage_constants.dart';
import '../langs/cn_lang.dart';
import '../langs/en_lang.dart';
import '../langs/kh_lang.dart';
import 'constants.dart';

String translate(String key, {
  Map<String, String>? params
}) {
  if(params != null){
    return key.trParams(params);
  }
  return key.tr;
}

void addTranslate(String language, Map<String, String> languages){
  switch(language){
    case LanguageConstants.KHMER:
      khLanguage.addAll(languages);
      break;
    case LanguageConstants.ENGLISH:
      enLanguage.addAll(languages);
      break;
    case LanguageConstants.CHINESE:
      cnLanguage.addAll(languages);
      break;
  }
}

void setLocale(Locale locale) {
  Get.updateLocale(locale);
  CoreLocalStorage.save(CoreLocalStorageConstants.lang, locale.languageCode);
}