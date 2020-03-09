import 'package:flutter_counter/db/Database.dart';
import 'package:flutter_counter/dto/CounterElement.dart';

class CounterPageImpl {
  List<CounterElement> countList = [];

  Future<List<CounterElement>> getCounterList() async {
    return await DBProvider.db.getAll();
  }

  void addElement(CounterElement ce) {
    DBProvider.db.insertElement(ce);
  }

  void updateElement(CounterElement ce) {
    DBProvider.db.updateElement(ce);
  }

  void deleteElement(CounterElement counterElement) {
    DBProvider.db.deleteElement(counterElement);
  }
}