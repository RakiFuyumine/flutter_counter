import 'package:flutter_counter/dto/CounterElement.dart';

class CounterPageImpl {
  List<CounterElement> countList = [];

  List<CounterElement> getCounterList() {
    return countList;
  }

  void addElement(CounterElement ce) {
    ce.id = countList.length;
    countList.add(ce);
  }

  void updateElement(CounterElement ce) {
    countList[ce.id] = ce;
  }

  void deleteElement(CounterElement counterElement) {
    countList.removeAt(counterElement.id);
  }
}