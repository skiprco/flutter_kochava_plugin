// reference: https://support.kochava.com/reference-information/post-install-event-examples/
import 'package:meta/meta.dart';

abstract class KochavaEvent {
  Map<String, dynamic> toDict();
}

class KochavaCustomEvent extends KochavaEvent {
  final String nameString;
  Map<String, dynamic> infoDictionary;

  KochavaCustomEvent({@required this.nameString, this.infoDictionary})
      : assert(nameString != null);

  Map<String, dynamic> toDict() {
    var dict = Map<String, dynamic>();
    dict["type"] = "customEvent";
    dict["nameString"] = nameString;
    if (infoDictionary != null) {
      dict["infoDictionary"] = infoDictionary;
    }
    return dict;
  }
}

class KochavaSearchEvent extends KochavaEvent {
  String uri;
  String results;

  KochavaSearchEvent({this.uri, this.results});

  Map<String, dynamic> toDict() {
    var dict = Map<String, dynamic>();
    dict["type"] = "searchEvent";
    if (uri != null) {
      dict["uri"] = uri;
    }
    if (results != null) {
      dict["results"] = results;
    }
    return dict;
  }
}
