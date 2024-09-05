part of 'stock_bloc.dart';

@immutable
sealed class StockEvent {}
class FetchStock extends StockEvent {}