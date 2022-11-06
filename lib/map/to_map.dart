import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MapUtils {
  MapUtils._();

  static map(double lat, double long) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    if (await launchUrlString(googleUrl)) {
      await launchUrl(Uri.parse(googleUrl),
          mode: LaunchMode.externalNonBrowserApplication);
    } else {
      throw 'Could not open the map.';
    }
  }
}
