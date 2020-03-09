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

  static CounterElement parse(Map<String, dynamic> record) {
    return CounterElement(
        record["id"],
        record["name"],
        value: record["value"]
    );
  }
}