import 'dart:convert';
import 'dart:convert' show utf8;
import 'package:flutter/gestures.dart';
import 'package:fogosmobile/constants/queries.dart';
import 'package:fogosmobile/models/contributor.dart';
import 'package:fogosmobile/screens/about/contributor_item.dart';
import 'package:fogosmobile/screens/utils/uri_utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:fogosmobile/constants/endpoints.dart';


class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {

  static HttpLink httpLink = HttpLink(
    uri: Endpoints.gitHubApi,
  );
  static AuthLink authLink = AuthLink(
    getToken: () => 'bearer fe33789c106442ad5c1126fe63807c0e91b9f13d',
  );

  static Link link =  authLink.concat(httpLink as Link);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: link,
    ),
  );


  @override
  initState() {
    super.initState();
  }

  getLocations() async {
    String url = Endpoints.getLocations;
    final response = await http.get(url);
    final data = json.decode(utf8.decode(response.bodyBytes));
    return data['rows'];
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: new Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.redAccent,
              iconTheme: new IconThemeData(color: Colors.white),
              title: new Text('Sobre', style: new TextStyle(color: Colors.white),),
            ),
            body: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: RichText(
                        text: new TextSpan(
                          children: [
                            new TextSpan(
                              text: 'Registos retirados da ',
                              style: new TextStyle(color: Colors.black),
                            ),
                            new TextSpan(
                              text: 'Página da Protecção Civil Portuguesa.',
                              style: new TextStyle(color: Colors.blue),
                              recognizer: new TapGestureRecognizer()..onTap = () => launchURL('http://www.prociv.pt/'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text('Actualizações de 2 em 2 minutos.'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text('Localização aproximada.'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: RichText(
                        text: new TextSpan(
                          children: [
                            new TextSpan(
                              text: 'Sugestões / Bugs - ',
                              style: new TextStyle(color: Colors.black),
                            ),
                            new TextSpan(
                              text: 'mail@fogos.pt.',
                              style: new TextStyle(color: Colors.blue),
                              recognizer: new TapGestureRecognizer()..onTap = () => launchURL('mailto:mail@fogos.pt'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text('Made with ♥ by:'),
                    ),
                    Flexible(
                      child: Query(
                        options: QueryOptions(document: Queries.getContributorsInformation),
                        builder: (QueryResult result, {VoidCallback refetch}) {
                          if (result.errors != null) {
                            return Text(result.errors.toString());
                          }
                          if (result.loading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          List<Contributor> constributors = Contributor.fromList(result.data['repository']["collaborators"]["nodes"]);
                          return ListView.builder(
                            padding: EdgeInsets.only(bottom: 8.0),
                            itemBuilder: (_, int i) => ContributorItem(contributor: constributors[i]),
                            itemCount: constributors.length,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}
