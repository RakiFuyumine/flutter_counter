import 'package:flutter_counter/dto/CounterElement.dart';

class CounterPageImpl {
  List<CounterElement> countList = [
    new CounterElement(0, "teste name 1"),
    new CounterElement(1, "teste name 2"),
  ];

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