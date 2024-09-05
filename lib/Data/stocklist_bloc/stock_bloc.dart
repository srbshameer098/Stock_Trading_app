import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Repository/Api/Stock_List_Api.dart';
import '../Repository/Model_Class/Stock_List_Model.dart';

part 'stock_event.dart';

part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final StockListApi stocklistApi = StockListApi(); //
  StockBloc() : super(StockInitial()) {
    on<StockEvent>((event, emit) async {
      emit(StockBlocLoading());

      try {
        // Fetch the data
        List<StockListModel> stocklistModel = await stocklistApi.getlist();
        print('Loading.....');
        emit(StockBlocLoaded(stocklistModel));
        print('Loaded.....');
      } catch (e) {
        print(e);
        emit(StockBlocError());
        print('Error.....');
      }
      // TODO: implement event handler
    });
  }
}
