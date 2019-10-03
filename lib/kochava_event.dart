// reference: https://support.kochava.com/reference-information/post-install-event-examples/
import 'package:meta/meta.dart';

abstract class KochavaEvent {
  Map<String, dynamic> toDict();
}

class KochavaCustomEvent extends KochavaEvent {
  final String nameString;
  Map<String, dynamic> infoDictionary;
  String userId;

  KochavaCustomEvent(
      {@required this.nameString, this.infoDictionary, this.userId})
      : assert(nameString != null);

  Map<String, dynamic> toDict() {
    var dict = Map<String, dynamic>();
    dict["type"] = "customEvent";
    dict["nameString"] = nameString;
    if (userId != null) {
      dict["userIdString"] = userId;
    }
    if (infoDictionary != null) {
      dict["infoDictionary"] = infoDictionary;
    }
    return dict;
  }
}

class KochavaSearchEvent extends KochavaEvent {
  String uri;
  String results;
  String userId;

  KochavaSearchEvent({this.uri, this.results, this.userId});

  Map<String, dynamic> toDict() {
    var dict = Map<String, dynamic>();
    dict["type"] = "searchEvent";
    if (userId != null) {
      dict["userIdString"] = userId;
    }
    if (uri != null) {
      dict["uri"] = uri;
    }
    if (results != null) {
      dict["results"] = results;
    }
    return dict;
  }
}
