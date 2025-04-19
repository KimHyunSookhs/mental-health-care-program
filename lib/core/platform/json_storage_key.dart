enum JsonStorageKey { haru }

extension JsonStorageKeyExt on JsonStorageKey {
  String get fileName => '${name}.json'; //예 : haru.json
  String get key => name;
}
