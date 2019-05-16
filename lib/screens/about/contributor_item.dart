import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fogosmobile/models/contributor.dart';
import 'package:fogosmobile/screens/utils/uri_utils.dart';

class ContributorItem extends StatelessWidget {
  ContributorItem({this.contributor});

  final Contributor contributor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        elevation: 0.2,
        child: InkWell(
          onTap: () => launchURL('https://github.com/${contributor.login}'),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: new BorderRadius.circular(8.0),
                  child: Stack(
                    alignment: const Alignment(0.0, 1.0),
                    children: [
                      CachedNetworkImage(
                        width: 100,
                        height: double.infinity,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => new CircularProgressIndicator(),
                        errorWidget: (context, url, error) => new Icon(Icons.account_box),
                        imageUrl: contributor.avatarUrl,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black45,
                        ),
                        child: Center(
                          heightFactor: 1,
                          child: Text(
                            contributor.login,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if(contributor.name != null && contributor.name.isNotEmpty)
                          Text('${contributor.name}'),
                        if(contributor.location != null && contributor.location.isNotEmpty)
                          Text('${contributor.location}'),
                        if(contributor.bio != null && contributor.bio.isNotEmpty)
                          Text('${contributor.bio}', maxLines: 5, overflow: TextOverflow.ellipsis,),
                        if(contributor.websiteUrl != null && contributor.websiteUrl.isNotEmpty)
                          RichText(
                            text: new TextSpan(
                              text: '${contributor.websiteUrl}',
                              style: new TextStyle(color: Colors.blue),
                              recognizer: new TapGestureRecognizer()..onTap = () => launchURL(contributor.websiteUrl),
                            ),
                          ),
                      ],
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}