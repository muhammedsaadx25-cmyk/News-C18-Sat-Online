import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/core/resources/colors_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../apis/articlesResponse/Article.dart';

class ArticleBottomSheet extends StatelessWidget {
  final Article article;
  const ArticleBottomSheet({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ColorsManager.black,
            borderRadius: BorderRadius.circular(16)
          ),
          child: Column(
            spacing: 8,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                    imageUrl: article.urlToImage ?? '',
                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Text(article.description ?? '' ,
                style: TextStyle(
                  fontSize: 14,
                  color: ColorsManager.white,
                  fontWeight: FontWeight.w500
                ),
              ),
              ElevatedButton(onPressed: () async{
                final Uri url = Uri.parse(article.url ?? '');
                await launchUrl(url , mode: LaunchMode.inAppBrowserView);
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.white,
                    foregroundColor: ColorsManager.black,
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                    ),
                    minimumSize: Size.fromHeight(56),
                  ),
                  child: Text('View Full Article',
                    style: TextStyle(
                        color: ColorsManager.black,
                    fontSize: 16),
                  ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
