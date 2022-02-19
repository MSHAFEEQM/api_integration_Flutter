import 'package:http/http.dart' as http;
Future<void> getUserDetails() async{

  final _response = await  http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
  print(_response.body);
}