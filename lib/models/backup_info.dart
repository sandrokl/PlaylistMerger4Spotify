class BackupInfo {
  String? appId;
  String? version;
  String? date;
  List<Rule>? rules;

  BackupInfo({this.appId, this.version, this.date, this.rules});

  BackupInfo.fromJson(Map<String, dynamic> json) {
    appId = json['appId'];
    version = json['version'];
    date = json['date'];
    if (json['rules'] != null) {
      rules = <Rule>[];
      json['rules'].forEach((v) {
        rules!.add(Rule.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appId'] = appId;
    data['version'] = version;
    data['date'] = date;
    if (rules != null) {
      data['rules'] = rules!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rule {
  String? destinationId;
  String? destinationName;
  List<Source>? sources;

  Rule({this.destinationId, this.destinationName, this.sources});

  Rule.fromJson(Map<String, dynamic> json) {
    destinationId = json['destinationId'];
    destinationName = json['destinationName'];
    if (json['sources'] != null) {
      sources = <Source>[];
      json['sources'].forEach((v) {
        sources!.add(Source.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['destinationId'] = destinationId;
    data['destinationName'] = destinationName;
    if (sources != null) {
      data['sources'] = sources!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Source {
  String? id;
  String? name;
  String? owner;

  Source({this.id, this.name, this.owner});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    owner = json['owner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['owner'] = owner;
    return data;
  }
}
