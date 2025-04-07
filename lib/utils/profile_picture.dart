import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ProfilePicture {
  static Uint8List _profilePicture = Uint8List(0);

  static changeProfilePicture() async {
    // _profilePicture = await ProfilePicture._fetchProfilePicture();
    _profilePicture = Uint8List(0);
  }

  static Future<Uint8List> getProfilePicture() async {
    if (_profilePicture.isEmpty) {
      _profilePicture = await ProfilePicture._fetchProfilePicture();
    }
    return _profilePicture;
  }

  static Future<Uint8List> _fetchProfilePicture() async {
    final response = await http.get(Uri.parse('https://avatar.iran.liara.run/public'));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }

}