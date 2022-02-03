class BackupInfo {
  String? appId;
  String? version;
  String? date;
  List<Rules>? rules;

  BackupInfo({this.appId, this.version, this.date, this.rules});

  BackupInfo.fromJson(Map<String, dynamic> json) {
    appId = json['appId'];
    version = json['version'];
    date = json['date'];
    if (json['rules'] != null) {
      rules = <Rules>[];
      json['rules'].forEach((v) {
        rules!.add(Rules.fromJson(v));
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

class Rules {
  String? destinationId;
  String? destinationName;
  List<Sources>? sources;

  Rules({this.destinationId, this.destinationName, this.sources});

  Rules.fromJson(Map<String, dynamic> json) {
    destinationId = json['destinationId'];
    destinationName = json['destinationName'];
    if (json['sources'] != null) {
      sources = <Sources>[];
      json['sources'].forEach((v) {
        sources!.add(Sources.fromJson(v));
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

class Sources {
  String? id;
  String? name;
  String? owner;

  Sources({this.id, this.name, this.owner});

  Sources.fromJson(Map<String, dynamic> json) {
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
