import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_counter/dto/CounterElement.dart';
import 'package:flutter_counter/main.dart';
import 'package:flutter_counter/screens/CounterPageImpl.dart';

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  CounterPageImpl _cpi = new CounterPageImpl();
  TextEditingController _nameTec = new TextEditingController();
  TextEditingController _valueTec = new TextEditingController();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<CounterElement> list;

  void saveChanges(CounterElement counterElement) {
    if (counterElement.id == -1) {
      _cpi.addElement(counterElement);
    } else {
      _cpi.updateElement(counterElement);
    }
    setState(() {
      list = _cpi.getCounterList();
    });
  }

  void deleteElement(CounterElement counterElement) {
    _cpi.deleteElement(counterElement);
    setState(() {
      list = _cpi.getCounterList();
    });
  }

  void addEditPopup({CounterElement counterElement}) {
    String title = "Add";
    _nameTec.text = "";
    _valueTec.text = "0";
    if(counterElement != null) {
      _nameTec.text = counterElement.name;
      _valueTec.text = counterElement.value.toString();
      title = "Edit";
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: new Text(title),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          titlePadding: EdgeInsets.only(left: 20, top: 20),
          children: <Widget>[
            Form(
              autovalidate: true,
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      controller: _nameTec,
                      validator: (s){
                        if (s.length == 0) {
                          return "Can't be empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: "Name",
                        contentPadding: EdgeInsets.symmetric(vertical: 2),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 30, right: 30),
                    child: TextFormField(
                      controller: _valueTec,
                      keyboardType: TextInputType.numberWithOptions(),
                      autocorrect: true,
                      toolbarOptions: ToolbarOptions(paste: false),
                      validator: (s){
                        if (s.length == 0) {
                          return "Can't be empty";
                        }
                        try{
                          int.parse(s);
                        } catch (e) {
                          return "Incorrect value";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: "Value",
                        contentPadding: EdgeInsets.symmetric(vertical: 2),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new FlatButton(
                        child: new Text("Delete"),
                        onPressed: counterElement != null ? () {
                          deletePopup(counterElement);
                        } : null,
                      ),
                      new FlatButton(
                        child: new Text("Close"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      new FlatButton(
                        child: new Text("Save"),
                          onPressed: () {
                            if(_formKey.currentState.validate()) {
                              CounterElement ce = new CounterElement(counterElement != null ? counterElement.id : -1, _nameTec.text, value : int.parse(_valueTec.text));
                              saveChanges(ce);
                              Navigator.of(context).pop();
                            }
                          },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  void deletePopup(CounterElement counterElement) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Center(child: new Text("Delete this item?")),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          titlePadding: EdgeInsets.only(top: 20),
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new FlatButton(
                      child: new Text("No"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    new FlatButton(
                      child: new Text("Yes"),
                      onPressed: () {
                        deleteElement(counterElement);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Widget getElement(CounterElement ce) {
    return GestureDetector(
      onLongPress: () => addEditPopup(counterElement: ce),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Card(
          color: Colors.white,
          margin: EdgeInsets.all(0),
          borderOnForeground: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 0),
            leading: Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1, color: Colors.black),
                ),
              ),
              child: IconButton(
                icon: Icon(Icons.remove),
                onPressed: (){
                  setState(() {
                     ce.value--;
                  });
                  saveChanges(ce);
                },
              ),
            ),
            trailing: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(width: 1, color: Colors.black),
                ),
              ),
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: (){
                  setState(() {
                    ce.value++;
                  });
                },
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(ce.name + ": "),
                Text(ce.value.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    list = _cpi.getCounterList();
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.appName),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addEditPopup(),
        child: Icon(Icons.add),
        mini: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 64),
        itemCount: list.length,
        itemBuilder: (BuildContext ctx, int index) {
          return getElement(list[index]);
        },
      ),
    );
  }
}
