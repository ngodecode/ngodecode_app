class LinkMarkdown {
  late final String link;
  late final String preview;

  LinkMarkdown(String source) {
    final regex = RegExp(r'\[([^\[]+)\]\((.*)\)$');
    if (regex.hasMatch(source)) {
      final match = regex.firstMatch(source);
      preview = match?.group(1) ?? "";
      link = match?.group(2) ?? "";
    }
    else {
      link = source;
      preview = source;
    }
  }

}