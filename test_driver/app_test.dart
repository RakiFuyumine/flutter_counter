import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;
  final String elementName = "counter";
  final floatingAddButton = find.byValueKey("floatingAddButton");

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  test('try create element with empty name', () async {
    await driver.tap(floatingAddButton);
    await driver.waitFor(find.text("Add"));
    await driver.tap(find.byValueKey("saveButton"));
    expect(driver.getText(find.text("Can't be empty")), completes);
  });

  test('create element', () async {
    await driver.tap(find.byValueKey("nameField"));
    await driver.enterText(elementName);
    await driver.tap(find.byValueKey("saveButton"));
    expect(driver.waitFor(find.text(elementName + ": ")), completes);
  });

  test('increase counter', () async {
    var element = find.byValueKey("incButton_0");
    await driver.tap(element);
    expect(driver.waitFor(find.text("1")), completes);
  });

  test('decrease counter', () async {
    var element = find.byValueKey("decButton_0");
    await driver.tap(element);
    expect(driver.waitFor(find.text("0")), completes);
  });

  test('Try edit element with both field empty', () async {
    await driver.scroll(find.byValueKey("element_0"), 0, 0, Duration(milliseconds: 1000));
    await driver.waitFor(find.text("Edit"));
    await driver.tap(find.byValueKey("nameField"));
    await driver.enterText("");
    await driver.tap(find.byValueKey("valueField"));
    await driver.enterText("");
    await driver.tap(find.byValueKey("saveButton"));
    expect(driver.waitFor(find.text("Can't be empty")), completes);
  });

  test('Try edit element with both name empty', () async {
    await driver.tap(find.byValueKey("valueField"));
    await driver.enterText("10");
    await driver.tap(find.byValueKey("saveButton"));
    expect(driver.getText(find.text("Can't be empty")), completes);
  });

  test('Try edit element with both value empty', () async {
    await driver.tap(find.byValueKey("valueField"));
    await driver.enterText("");
    await driver.tap(find.byValueKey("nameField"));
    await driver.enterText("new " + elementName);
    await driver.tap(find.byValueKey("saveButton"));
    expect(driver.getText(find.text("Can't be empty")), completes);
  });

  test('Edit element', () async {
    await driver.tap(find.byValueKey("valueField"));
    await driver.enterText("20");
    await driver.tap(find.byValueKey("nameField"));
    await driver.enterText("new " + elementName);
    await driver.tap(find.byValueKey("saveButton"));
    expect(driver.getText(find.text("new " + elementName + ": ")), completes);
    expect(driver.getText(find.text("20")), completes);
  });

  test('Delete element', () async {
    await driver.scroll(find.byValueKey("element_0"), 0, 0, Duration(milliseconds: 1000));
    await driver.waitFor(find.text("Edit"));
    await driver.tap(find.byValueKey("deleteButton"));
    await driver.waitFor(find.byValueKey("deletePopup"));
    await driver.tap(find.byValueKey("yesButton"));
    expect(driver.waitForAbsent(find.byValueKey("element_0")), completes);
  });
}
