import 'dart:convert';
import 'package:http/http.dart';

import '../Model_Class/Stock_List_Model.dart';
import 'api_client.dart';





class StockListApi {
  ApiClient apiClient = ApiClient();

  Future<List<StockListModel>> getlist() async {
    String trendingPath = "https://real-time-stock-finance-quote.p.rapidapi.com/stock/list";
    Response response = await apiClient.invokeAPI(trendingPath, "GET", null);
    print(response.body);

    List<dynamic> jsonList = json.decode(response.body);
    List<StockListModel> stockList = jsonList.map((json) => StockListModel.fromJson(json)).toList();
    return stockList;
  }

}