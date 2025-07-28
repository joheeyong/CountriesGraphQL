import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CountryListScreen extends StatelessWidget {
  final String query = r'''
    query {
      countries {
        code
        name
        emoji
      }
    }
  ''';

  const CountryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Countries')),
      body: Query(
        options: QueryOptions(
          document: gql(query),
        ),
        builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
          if (result.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (result.hasException) {
            return Center(child: Text(result.exception.toString()));
          }

          final List countries = result.data?['countries'] ?? [];

          return ListView.builder(
            itemCount: countries.length,
            itemBuilder: (context, index) {
              final country = countries[index];
              return ListTile(
                leading: Text(country['emoji']),
                title: Text(country['name']),
                subtitle: Text(country['code']),
              );
            },
          );
        },
      ),
    );
  }
}
