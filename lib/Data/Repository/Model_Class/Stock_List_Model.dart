import 'dart:convert';
/// MSFT : "Microsoft Corporation"

StockListModel stockListModelFromJson(String str) => StockListModel.fromJson(json.decode(str));
String stockListModelToJson(StockListModel data) => json.encode(data.toJson());
class StockListModel {
  StockListModel({
      String? msft,}){
    _msft = msft;
}

  StockListModel.fromJson(dynamic json) {
    _msft = json['MSFT'];
  }
  String? _msft;
StockListModel copyWith({  String? msft,
}) => StockListModel(  msft: msft ?? _msft,
);
  String? get msft => _msft;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['MSFT'] = _msft;
    return map;
  }

}