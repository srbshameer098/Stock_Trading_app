part of 'stock_bloc.dart';

@immutable
sealed class StockState {}

final class StockInitial extends StockState {}
class StockBlocLoading extends StockState {}

class StockBlocLoaded extends StockState {
  final List<StockListModel> stocklistModel;

  StockBlocLoaded(this.stocklistModel);
}

class StockBlocError extends StockState {}