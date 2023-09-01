class BusModel {
  int? _busId;
  String? _busName;
  String? _fromCity;
  String? _toCity;
  String? _date;

  BusModel(
      {int? busId,
      String? busName,
      String? fromCity,
      String? toCity,
      String? date}) {
    if (busId != null) {
      this._busId = busId;
    }
    if (busName != null) {
      this._busName = busName;
    }
    if (fromCity != null) {
      this._fromCity = fromCity;
    }
    if (toCity != null) {
      this._toCity = toCity;
    }
    if (date != null) {
      this._date = date;
    }
  }

  int? get busId => _busId;
  set busId(int? busId) => _busId = busId;
  String? get busName => _busName;
  set busName(String? busName) => _busName = busName;
  String? get fromCity => _fromCity;
  set fromCity(String? fromCity) => _fromCity = fromCity;
  String? get toCity => _toCity;
  set toCity(String? toCity) => _toCity = toCity;
  String? get date => _date;
  set date(String? date) => _date = date;

  BusModel.fromJson(Map<String, dynamic> json) {
    _busId = json['busId'];
    _busName = json['busName'];
    _fromCity = json['fromCity'];
    _toCity = json['toCity'];
    _date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['busId'] = this._busId;
    data['busName'] = this._busName;
    data['fromCity'] = this._fromCity;
    data['toCity'] = this._toCity;
    data['date'] = this._date;
    return data;
  }
}
