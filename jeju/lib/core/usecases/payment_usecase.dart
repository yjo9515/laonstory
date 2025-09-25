class PaymentUseCase {
  static PaymentUseCase get to => PaymentUseCase();
}

extension UriExtension on Uri {
  static Uri androidIntentUrlOrigin(String uriString) {
    Uri uri = Uri.parse(uriString);
    if (uri.scheme == 'intent') {
      var firstSplits = uriString.split("#Intent;");
      if (firstSplits[1].contains('scheme')) {
        var secondSplits = (firstSplits[1]).split(";");
        var scheme = secondSplits.where((e) => e.contains('scheme')).toList()[0].split("=")[1];
        var authority = uri.authority;
        uri = Uri.parse("$scheme://$authority?${uri.query}");
      } else {
        var tempUri = Uri.parse(uri.path);
        var newUri = Uri.parse("$tempUri?${uri.query}");
        uri = newUri;
      }
    }
    return uri;
  }
}
