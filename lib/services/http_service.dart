import 'package:dm_mobile/utils/constants.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final String endpoint;
  final String body;

  const HttpService({
    required this.endpoint,
    required this.body,
  });

  Future<void> post() async {
    final url = Uri.https(apiHost, endpoint);
    final response = await http.post(url, body: body);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
