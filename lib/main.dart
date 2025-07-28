import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphqlcountries/country_list_screen.dart';

void main() async {
  await initHiveForFlutter(); // 캐시 저장소 초기화
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key}); // 예제 GraphQL API

  final HttpLink httpLink = HttpLink('https://countries.trevorblades.com/');

  @override
  Widget build(BuildContext context) {
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: HiveStore()),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        home: CountryListScreen(),
      ),
    );
  }
}
