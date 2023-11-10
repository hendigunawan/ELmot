class Broker {
  int? arrayL;
  List<BrokerList>? array;

  Broker({this.arrayL, this.array});

  Broker.fromJson(Map<String, dynamic> json) {
    arrayL = json['arrayL'];
    array = json['array'];
    if (json['array'] != null) {
      array = <BrokerList>[];
      json['array'].forEach((v) {
        array!.add(BrokerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['arrayL'] = arrayL;
    data['array'] = array;
    if (array != null) {
      data['array'] = array!.map((e) => e.toJson()).toList();
    }
    print("DATA Broker: $data");
    return data;
  }
}

class BrokerList {
  int? brokerCodeL;
  String? brokerCode;
  int? brokerNameL;
  String? brokerName;
  int? nationality;

  BrokerList({
    this.brokerCodeL,
    this.brokerCode,
    this.brokerNameL,
    this.brokerName,
    this.nationality,
  });

  BrokerList.fromJson(Map<String, dynamic> json) {
    brokerCodeL = json['brokerCodeL'];
    brokerCode = json['brokerCode'];
    brokerNameL = json['brokerNameL'];
    brokerName = json['brokerName'];
    nationality = json['nationality'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['brokerCodeL'] = brokerCodeL;
    data['brokerCode'] = brokerCode;
    data['brokerNameL'] = brokerNameL;
    data['brokerName'] = brokerName;
    data['nationality'] = nationality;
    return data;
  }
}
