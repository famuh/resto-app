import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:resto_app/data/model/search_restaurant.dart';
import 'parsing_json_test.mocks.dart';

Future<SearchResto> fetchResto(http.Client client) async {
  final response = await client.get(
      Uri.parse('https://restaurant-api.dicoding.dev/search?q=Melting Pot'));

  if (response.statusCode == 200) {
    return SearchResto.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load resto search');
  }
}

@GenerateMocks([http.Client])
void main() {
  group('SearchResto testing', () {
    // if has no error
    test('returns a SearchResto Type', () async {
      final client = MockClient();

      when(client.get(Uri.parse(
              'https://restaurant-api.dicoding.dev/search?q=Melting Pot')))
          .thenAnswer((_) async => http.Response(
              '{"error": false,"founded":1,"restaurants": [{"id":"rqdv5juczeskfw1e867","name":"Melting Pot","description":"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.","pictureId":"14","city":"Medan","rating":4.2}]}',
              200));
      expect(await fetchResto(client), isA<SearchResto>());
    });

    // if has error
    test('throws an exception', () {
      final client = MockClient();
      when(client.get(Uri.parse(
              'https://restaurant-api.dicoding.dev/search?q=Melting Pot')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      expect(fetchResto(client), throwsException);
    });
  });
}
