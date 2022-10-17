import '../models/contest.dart';
import 'package:http/http.dart' as http;

class Remote {
  Future<List<Contest>?> getPosts() async {
    var client = http.Client();
    var uri = Uri.parse('https://kontests.net/api/v1/all');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return contestFromJson(json);
    }
    return null;
  }
}
