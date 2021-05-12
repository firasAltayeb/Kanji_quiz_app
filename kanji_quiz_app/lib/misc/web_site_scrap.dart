// import '../model/aozora_sites.dart';
// import 'package:http/http.dart';
// import 'dart:convert';

// void _webScraperScrap() async {
//   var novelSubPage = "";
//   final rawUrl = aozoraBunkoSites[0];
//   final webScraper = WebScraper('https://www.aozora.gr.jp');
//   final endpoint = rawUrl.replaceAll('https://www.aozora.gr.jp', '');
//   print("endpoint is $endpoint");
//   if (await webScraper.loadWebPage(endpoint)) {
//     final pageContent = webScraper.getPageContent();
//     final queriedStartIndex = pageContent.indexOf("/files/");
//     novelSubPage =
//         pageContent.substring(queriedStartIndex, queriedStartIndex + 23);
//     print(novelSubPage);
//   }
//   final newEndPoint =
//       endpoint.replaceAll(RegExp('/card[0-9]*.html'), novelSubPage);
//   print("newEndPoint is $newEndPoint");
//   if (await webScraper.loadWebPage(newEndPoint)) {
//     final pageContent = webScraper.getPageContent();
//     print(pageContent);
//   }
// }

// void _manualSiteScrap() async {
//   var client = Client();
//   var novelSubPage = "";
//   final rawUrl = aozoraBunkoSites[0];
//   Response response = await client.get(rawUrl);
//   print(utf8.decode(response.bodyBytes));
//   final queriedStartIndex = response.body.indexOf("/files/");
//   novelSubPage =
//       response.body.substring(queriedStartIndex, queriedStartIndex + 23);
//   final newUrl = rawUrl.replaceAll(RegExp('/card[0-9]*.html'), novelSubPage);
//   print("newUrl is $newUrl");
//   Response newResponse = await client.get(newUrl);
//   print(newResponse.body);
//   print(utf8.decode(newResponse.bodyBytes, allowMalformed: true));
// }
