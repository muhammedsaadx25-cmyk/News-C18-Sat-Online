import 'source.dart';

class SourcesResponse {
  SourcesResponse({
       this.status,
      this.sources,
      this.code,
      this.message,
  });

  SourcesResponse.fromJson(dynamic json) {
    status = json['status']; /// error
    code = json['code'];
    message = json['message'];
    if (json['sources'] != null) {
      sources = [];
      json['sources'].forEach((v) {
        sources?.add(Source.fromJson(v));
      });
    }
  }


   String? status;
  String? code;
  String? message;
  List<Source>? sources;



}