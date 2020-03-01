class CounterElement {
  int id;
  String name;
  int value;

  CounterElement(this.id, this.name, {value}){
    if(value == null) {
      value = 0;
    }
    this.value = value;
  }
}