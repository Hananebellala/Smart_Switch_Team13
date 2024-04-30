import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../widgets/box_lampe.dart';
import '../widgets/box_tv.dart';
import '../widgets/boutton/add_scence.dart';
import 'dart:async';
import '../screens/scencepage.dart';

class Box {
  final int boxNumber;
  final String deviceType;
  final String deviceName;
  final String pairedDevice;
  Box(this.boxNumber, this.deviceType, this.deviceName, this.pairedDevice);
}

class ColumnEvent {}

class AddBoxEvent extends ColumnEvent {
  final int newBoxNumber;
  final String deviceType;
  final String deviceName;
  final String pairedDevice;
  AddBoxEvent(
      this.newBoxNumber, this.deviceType, this.deviceName, this.pairedDevice);
}

class DeleteBoxEvent extends ColumnEvent {
  final int boxNumber;
  DeleteBoxEvent(this.boxNumber);
}

class LoadInitialDataEvent extends ColumnEvent {}

class ColumnState {
  final List<Box> firstColumnData;
  final List<Box> secondColumnData;

  ColumnState(this.firstColumnData, this.secondColumnData);
}

class ColumnBloc extends Bloc<ColumnEvent, ColumnState> {
  late Database _database;

  ColumnBloc() : super(ColumnState([], [])) {
    _openDatabaseAndLoadInitialData();
    on<AddBoxEvent>(_mapAddBoxEventToState);
    on<LoadInitialDataEvent>(_mapLoadInitialDataEventToState);
    on<DeleteBoxEvent>(_mapDeleteBoxEventToState);
  }

  void addBox(int newBoxNumber, String deviceType, String deviceName,
      String pairedDevice) {
    add(AddBoxEvent(newBoxNumber, deviceType, deviceName, pairedDevice));
  }

  void deleteBox(int boxNumber) {
    add(DeleteBoxEvent(boxNumber));
  }

  Future<void> _openDatabaseAndLoadInitialData() async {
    _database = await _initializeDatabase();
    add(LoadInitialDataEvent());
  }

  Future<Database> _initializeDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE columns(id INTEGER PRIMARY KEY AUTOINCREMENT, columnNumber INTEGER, boxNumber INTEGER, deviceType TEXT, deviceName TEXT, pairedDevice TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> _mapAddBoxEventToState(
      AddBoxEvent event, Emitter<ColumnState> emit) async {
    final List<Map<String, dynamic>> rows = await _database.query('columns');
    final List<Box> boxes = rows.map((row) {
      final int boxNumber = row['boxNumber'];
      final String deviceType = row['deviceType'];
      final String? deviceName = row['deviceName'];
      final String? pairedDevice = row['pairedDevice'];
      return Box(boxNumber, deviceType, deviceName ?? '', pairedDevice ?? '');
    }).toList();

    final int newColumnNumber = boxes.length % 2 == 0 ? 1 : 2;

    await _database.insert(
      'columns',
      {
        'columnNumber': newColumnNumber,
        'boxNumber': event.newBoxNumber,
        'deviceType': event.deviceType,
        'deviceName': event.deviceName,
        'pairedDevice': event.pairedDevice
      },
    );

    emit(_getColumnState(boxes));
  }

  Future<void> _mapLoadInitialDataEventToState(
      LoadInitialDataEvent event, Emitter<ColumnState> emit) async {
    final List<Map<String, dynamic>> rows = await _database.query('columns');
    final List<Box> boxes = rows.map((row) {
      final int columnNumber = row['columnNumber'];
      final int boxNumber = row['boxNumber'];
      final String deviceType = row['deviceType'];
      final String? pairedDevice = row['pairedDevice'];
      final String? deviceName = row['deviceName'];
      return Box(boxNumber, deviceType, deviceName ?? '', pairedDevice ?? '');
    }).toList();

    emit(_getColumnState(boxes));
  }

  Future<void> _mapDeleteBoxEventToState(
      DeleteBoxEvent event, Emitter<ColumnState> emit) async {
    await _database.delete('columns',
        where: 'boxNumber = ?', whereArgs: [event.boxNumber]);

    final List<Map<String, dynamic>> rows = await _database.query('columns');
    final List<Box> boxes = rows.map((row) {
      final int boxNumber = row['boxNumber'];
      final String deviceType = row['deviceType'];
      final String? deviceName = row['deviceName'];
      final String? pairedDevice = row['pairedDevice'];
      return Box(boxNumber, deviceType, deviceName ?? '', pairedDevice ?? '');
    }).toList();

    emit(_getColumnState(boxes));
  }

  ColumnState _getColumnState(List<Box> boxes) {
    final List<Box> firstColumnData = [];
    final List<Box> secondColumnData = [];

    for (int i = 0; i < boxes.length; i++) {
      if (i % 2 == 0) {
        firstColumnData.add(boxes[i]);
      } else {
        secondColumnData.add(boxes[i]);
      }
    }

    return ColumnState(firstColumnData, secondColumnData);
  }

  List<Box> get boxes => state.firstColumnData + state.secondColumnData;

  List<Box> getFirstThreeBoxes() {
    List<Box> firstThreeBoxes = boxes.take(3).toList();
    print('Les trois premières boîtes sont : $firstThreeBoxes');
    return firstThreeBoxes;
  }

  int countBoxes() {
    return boxes.length;
  }
}

class MyWidgetContent extends StatelessWidget {
  final String deviceName;
  final String pairedDevice;
  final String deviceType;
  final Function(String) updateDeviceName;
  final Function(String) updatePairedDevice;
  final Function(String) updateDeviceType;
  final bool showButtons;
  final int maxBoxesToShow;
  final int maxBoxesPerColumn1; // Nombre maximum de boîtes par colonne 1
  final int maxBoxesPerColumn2; // Nombre maximum de boîtes par colonne 2

  MyWidgetContent({
    required this.deviceName,
    required this.pairedDevice,
    required this.deviceType,
    required this.updateDeviceName,
    required this.updatePairedDevice,
    required this.updateDeviceType,
    required this.showButtons,
    required this.maxBoxesToShow,
    required this.maxBoxesPerColumn1,
    required this.maxBoxesPerColumn2,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColumnBloc, ColumnState>(
      builder: (context, state) {
        final firstColumnBoxes = state.firstColumnData.take(maxBoxesPerColumn1).toList();
        final secondColumnBoxes = state.secondColumnData.take(maxBoxesPerColumn2).toList();

        return Column(
          children: [
            if (showButtons)
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<ColumnBloc>(context).add(LoadInitialDataEvent());
                },
                child: Text('Actualiser'),
              ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.065),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: firstColumnBoxes
                      .map<Widget>((box) {
                        if (box.deviceType == 'Lampe') {
                          return Box_lampe(
                            name: box.deviceName,
                            Xcode: box.pairedDevice,
                            onDelete: () {
                              BlocProvider.of<ColumnBloc>(context).deleteBox(box.boxNumber);
                            },
                          );
                        } else {
                          return Box_tv(
                            name: box.deviceName,
                            Xcode: box.pairedDevice,
                            onDelete: () {
                              BlocProvider.of<ColumnBloc>(context).deleteBox(box.boxNumber);
                            },
                          );
                        }
                      })
                      .toList(),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.07),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: secondColumnBoxes
                      .map<Widget>((box) {
                        if (box.deviceType == 'Lampe') {
                          return Box_lampe(
                            name: box.deviceName,
                            Xcode: box.pairedDevice,
                            onDelete: () {
                              BlocProvider.of<ColumnBloc>(context).deleteBox(box.boxNumber);
                            },
                          );
                        } else {
                          return Box_tv(
                            name: box.deviceName,
                            Xcode: box.pairedDevice,
                            onDelete: () {
                              BlocProvider.of<ColumnBloc>(context).deleteBox(box.boxNumber);
                            },
                          );
                        }
                      })
                      .toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (showButtons)
              AddScence(
                updateDeviceName: updateDeviceName,
                updatePairedDevice: updatePairedDevice,
                updateDeviceType: updateDeviceType,
                firstColumnData: state.firstColumnData,
                secondColumnData: state.secondColumnData,
                onPressed: (newBoxNumber, deviceType, deviceName, pairedDevice) {
                  BlocProvider.of<ColumnBloc>(context).add(AddBoxEvent(
                      newBoxNumber, deviceType, deviceName, pairedDevice));
                  BlocProvider.of<ColumnBloc>(context).add(LoadInitialDataEvent());
                },
              ),
            const SizedBox(height: 200),
          ],
        );
      },
    );
  }
}

class Insert extends StatefulWidget {
  final bool showButtons;
  final int maxBoxesToShow;
  final int maxBoxesPerColumn1;
  final int maxBoxesPerColumn2;

  Insert({
    Key? key,
    this.showButtons = true,
    this.maxBoxesToShow = 999,
    this.maxBoxesPerColumn1 = 9999,
    this.maxBoxesPerColumn2 = 9999,
  }) : super(key: key);

  @override
  _InsertState createState() => _InsertState();
}

class _InsertState extends State<Insert> {
  String deviceName = 'malak';
  String pairedDevice = '';
  String deviceType = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ColumnBloc(),
      child: MyWidgetContent(
        deviceName: deviceName,
        pairedDevice: pairedDevice,
        deviceType: deviceType,
        updateDeviceName: (newValue) {
          setState(() {
            deviceName = newValue;
          });
        },
        updatePairedDevice: (newValue) {
          setState(() {
            pairedDevice = newValue;
          });
        },
        updateDeviceType: (newValue) {
          setState(() {
            deviceType = newValue;
          });
        },
        showButtons: widget.showButtons,
        maxBoxesToShow: widget.maxBoxesToShow,
        maxBoxesPerColumn1: widget.maxBoxesPerColumn1,
        maxBoxesPerColumn2: widget.maxBoxesPerColumn2,
      ),
    );
  }
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../widgets/box_lampe.dart';
import '../widgets/box_tv.dart';
import '../widgets/boutton/add_scence.dart';
import '../widgets/boutton/sceneDevice.dart';
import 'dart:async';
import '../screens/scencepage.dart';
/*
class Case {
  final int Number;
  final String type;
  final String name;
  final String etat;
  Case(this.Number, this.type, this.name, this.etat);
}

class ColumnEvent2 {}

class AddCaseEvent extends ColumnEvent2 {
  final int newNumber;
  final String type;
  final String name;
  final String etat;
  AddCaseEvent(
      this.newNumber, this.type, this.name, this.etat);
}

class DeleteCaseEvent extends ColumnEvent2 {
  final int Number;
  DeleteCaseEvent(this.Number);
}

class LoadInitialDataEvent2 extends ColumnEvent2 {}

class ColumnState2 {
  final List<Case> firstColumnData2;
  final List<Case> secondColumnData2;

  ColumnState2(this.firstColumnData2, this.secondColumnData2);
}

class ColumnBloc2 extends Bloc<ColumnEvent2, ColumnState2> {
  late Database _database;

  ColumnBloc2() : super(ColumnState2([], [])) {
    _openDatabaseAndLoadInitialData();
    on<AddCaseEvent>(_mapAddCaseEventToState);
    on<LoadInitialDataEvent2>(_mapLoadInitialDataEvent2ToState);
    on<DeleteCaseEvent>(_mapDeleteCaseEventToState);
  }

  void addCase(int newNumber, String type, String name,
      String etat) {
    add(AddCaseEvent(newNumber, type, name, etat));
  }

  void deleteCase(int Number) {
    add(DeleteCaseEvent(Number));
  }

  Future<void> _openDatabaseAndLoadInitialData() async {
    _database = await _initializeDatabase();
    add(LoadInitialDataEvent2());
  }

  Future<Database> _initializeDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE columns(id INTEGER PRIMARY KEY AUTOINCREMENT, columnNumber2 INTEGER,Number INTEGER, type TEXT, name TEXT, etat TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> _mapAddCaseEventToState(
      AddCaseEvent event, Emitter<ColumnState2> emit) async {
    final List<Map<String, dynamic>> rows = await _database.query('columns');
    final List<Case> cases = rows.map((row) {
      final int Number = row['Number'];
      final String type = row['type'];
      final String? name = row['name'];
      final String? etat = row['etat'];
      return Case(Number, type, name ?? '', etat ?? '');
    }).toList();

    final int newColumnNumber2 = cases.length % 2 == 0 ? 1 : 2;

    await _database.insert(
      'columns',
      {
        'columnNumber2': newColumnNumber2,
        'Number': event.newNumber,
        'type': event.type,
        'name': event.name,
        'etat': event.etat
      },
    );

    emit(_getColumnState2(cases));
  }

  Future<void> _mapLoadInitialDataEvent2ToState(
      LoadInitialDataEvent2 event, Emitter<ColumnState2> emit) async {
    final List<Map<String, dynamic>> rows = await _database.query('columns');
    final List<Case> cases = rows.map((row) {
      final int columnNumber2 = row['columnNumber2'];
      final int Number = row['Number'];
      final String type = row['type'];
      final String? etat = row['etat'];
      final String? name = row['name'];
      return Case(Number, type, name ?? '', etat ?? '');
    }).toList();

    emit(_getColumnState2(cases));
  }

  Future<void> _mapDeleteCaseEventToState(
      DeleteCaseEvent event, Emitter<ColumnState2> emit) async {
    await _database.delete('columns',
        where: 'Number = ?', whereArgs: [event.Number]);

    final List<Map<String, dynamic>> rows = await _database.query('columns');
    final List<Case> cases = rows.map((row) {
     final int columnNumber2 = row['columnNumber2'];
      final int Number = row['Number'];
      final String type = row['type'];
      final String? etat = row['etat'];
      final String? name = row['name'];
      return Case(Number, type, name ?? '', etat ?? '');
       }).toList();

    emit(_getColumnState2(cases));
  }

  ColumnState2 _getColumnState2(List<Case> cases) {
    final List<Case> firstColumnData2 = [];
    final List<Case> secondColumnData2 = [];

    for (int i = 0; i < cases.length; i++) {
      if (i % 2 == 0) {
        firstColumnData2.add(cases[i]);
      } else {
        secondColumnData2.add(cases[i]);
      }
    }

    return ColumnState2(firstColumnData2, secondColumnData2);
  }

  List<Case> get cases => state.firstColumnData2 + state.secondColumnData2;

  

  int countCases() {
    return cases.length;
  }
}


class MyWidget extends StatelessWidget {
  final bool showButtons;
  final int maxCasesPerColumn1;
  final int maxCasesPerColumn2;

  MyWidget({
    Key? key,
    this.showButtons = true,
    this.maxCasesPerColumn1 = 999,
    this.maxCasesPerColumn2 = 999,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ColumnBloc2(),
      child: BlocBuilder<ColumnBloc2, ColumnState2>(
        builder: (context, state) {
          final firstColumnCase = state.firstColumnData2;
          final secondColumnCase = state.secondColumnData2;

          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.065),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: firstColumnCase
                        .map<Widget>((cases) {
                      if (cases.type == 'Lampe') {
                        return Container(height:100,width:100,color:Colors.blue);
                      
                      } else {
                        return Container(height:100,width:100,color:Colors.blue)
                        ;
                      }
                    })
                        .toList(),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.07),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: secondColumnCase
                        .map<Widget>((cases) {
                      if (cases.type == 'Lampe') {
                        return Container(height:100,width:100,color:Colors.blue)
                        ;
                      } else {
                        return Container(height:100,width:100,color:Colors.blue);
                      }
                    })
                        .toList(),
                  ),
                ],
              ),
              if (showButtons)
               ElevatedButton(
  onPressed: () {
    final columnBloc = BlocProvider.of<ColumnBloc2>(context);
    columnBloc.add(AddCaseEvent(1, 'malk', 'tv', 'on'));
    columnBloc.add(LoadInitialDataEvent2()); // Rafraîchir les données après l'ajout
  },
  child: Text('Ajouter une case'),
),

            ],
          );
        },
      ),
    );
  }
}*/
class Box {
  final int boxNumber;
  final String deviceType;
  final String deviceName;
  final String pairedDevice;
  Box(this.boxNumber, this.deviceType, this.deviceName, this.pairedDevice);
}

class ColumnEvent {}

class AddBoxEvent extends ColumnEvent {
  final int newBoxNumber;
  final String deviceType;
  final String deviceName;
  final String pairedDevice;
  AddBoxEvent(
      this.newBoxNumber, this.deviceType, this.deviceName, this.pairedDevice);
}

class DeleteBoxEvent extends ColumnEvent {
  final int boxNumber;
  DeleteBoxEvent(this.boxNumber);
}

class LoadInitialDataEvent extends ColumnEvent {}

class ColumnState {
  final List<Box> firstColumnData;
  final List<Box> secondColumnData;

  ColumnState(this.firstColumnData, this.secondColumnData);
}

class ColumnBloc extends Bloc<ColumnEvent, ColumnState> {
  late Database _database;

  ColumnBloc() : super(ColumnState([], [])) {
    _openDatabaseAndLoadInitialData();
    on<AddBoxEvent>(_mapAddBoxEventToState);
    on<LoadInitialDataEvent>(_mapLoadInitialDataEventToState);
    on<DeleteBoxEvent>(_mapDeleteBoxEventToState);
  }

  void addBox(int newBoxNumber, String deviceType, String deviceName,
      String pairedDevice) {
    add(AddBoxEvent(newBoxNumber, deviceType, deviceName, pairedDevice));
  }

  void deleteBox(int boxNumber) {
    add(DeleteBoxEvent(boxNumber));
  }

  Future<void> _openDatabaseAndLoadInitialData() async {
    _database = await _initializeDatabase();
    add(LoadInitialDataEvent());
  }

  Future<Database> _initializeDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE columns(id INTEGER PRIMARY KEY AUTOINCREMENT, columnNumber INTEGER, boxNumber INTEGER, deviceType TEXT, deviceName TEXT, pairedDevice TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> _mapAddBoxEventToState(
      AddBoxEvent event, Emitter<ColumnState> emit) async {
    final List<Map<String, dynamic>> rows = await _database.query('columns');
    final List<Box> boxes = rows.map((row) {
      final int boxNumber = row['boxNumber'];
      final String deviceType = row['deviceType'];
      final String? deviceName = row['deviceName'];
      final String? pairedDevice = row['pairedDevice'];
      return Box(boxNumber, deviceType, deviceName ?? '', pairedDevice ?? '');
    }).toList();

    final int newColumnNumber = boxes.length % 2 == 0 ? 1 : 2;

    await _database.insert(
      'columns',
      {
        'columnNumber': newColumnNumber,
        'boxNumber': event.newBoxNumber,
        'deviceType': event.deviceType,
        'deviceName': event.deviceName,
        'pairedDevice': event.pairedDevice
      },
    );

    emit(_getColumnState(boxes));
  }

  Future<void> _mapLoadInitialDataEventToState(
      LoadInitialDataEvent event, Emitter<ColumnState> emit) async {
    final List<Map<String, dynamic>> rows = await _database.query('columns');
    final List<Box> boxes = rows.map((row) {
      final int columnNumber = row['columnNumber'];
      final int boxNumber = row['boxNumber'];
      final String deviceType = row['deviceType'];
      final String? pairedDevice = row['pairedDevice'];
      final String? deviceName = row['deviceName'];
      return Box(boxNumber, deviceType, deviceName ?? '', pairedDevice ?? '');
    }).toList();

    emit(_getColumnState(boxes));
  }

  Future<void> _mapDeleteBoxEventToState(
      DeleteBoxEvent event, Emitter<ColumnState> emit) async {
    await _database.delete('columns',
        where: 'boxNumber = ?', whereArgs: [event.boxNumber]);

    final List<Map<String, dynamic>> rows = await _database.query('columns');
    final List<Box> boxes = rows.map((row) {
      final int boxNumber = row['boxNumber'];
      final String deviceType = row['deviceType'];
      final String? deviceName = row['deviceName'];
      final String? pairedDevice = row['pairedDevice'];
      return Box(boxNumber, deviceType, deviceName ?? '', pairedDevice ?? '');
    }).toList();

    emit(_getColumnState(boxes));
  }

  ColumnState _getColumnState(List<Box> boxes) {
    final List<Box> firstColumnData = [];
    final List<Box> secondColumnData = [];

    for (int i = 0; i < boxes.length; i++) {
      if (i % 2 == 0) {
        firstColumnData.add(boxes[i]);
      } else {
        secondColumnData.add(boxes[i]);
      }
    }

    return ColumnState(firstColumnData, secondColumnData);
  }

  List<Box> get boxes => state.firstColumnData + state.secondColumnData;

  List<Box> getFirstThreeBoxes() {
    List<Box> firstThreeBoxes = boxes.take(3).toList();
    print('Les trois premières boîtes sont : $firstThreeBoxes');
    return firstThreeBoxes;
  }

  int countBoxes() {
    return boxes.length;
  }
}

class MyWidgetContent extends StatelessWidget {
  final bool showButtons;
  final int maxBoxesToShow;
  final int maxBoxesPerColumn1;
  final int maxBoxesPerColumn2;
  final Function(String) updateDeviceName;
  final Function(String) updatePairedDevice;
  final Function(String) updateDeviceType;

  MyWidgetContent({
    Key? key,
    required this.showButtons,
    required this.maxBoxesToShow,
    required this.maxBoxesPerColumn1,
    required this.maxBoxesPerColumn2,
    required this.updateDeviceName,
    required this.updatePairedDevice,
    required this.updateDeviceType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ColumnBloc(),
      child: BlocBuilder<ColumnBloc, ColumnState>(
        builder: (context, state) {
          final firstColumnBoxes = state.firstColumnData;
          final secondColumnBoxes = state.secondColumnData;

          return Column(
            children: [
              if (showButtons)
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<ColumnBloc>(context).add(LoadInitialDataEvent());
                  },
                  child: Text('Actualiser'),
                ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.065),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: firstColumnBoxes
                        .map<Widget>((box) {
                      if (box.deviceType == 'Lampe') {
                        return
                         Box_lampe(
                          name: box.deviceName,
                          Xcode: box.pairedDevice,
                          onDelete: () {
                            BlocProvider.of<ColumnBloc>(context).deleteBox(box.boxNumber);
                          },
                        );
                      } else {
                        return Box_tv(
                          name: box.deviceName,
                          Xcode: box.pairedDevice,
                          onDelete: () {
                            BlocProvider.of<ColumnBloc>(context).deleteBox(box.boxNumber);
                          },
                        );
                      }
                    })
                        .toList(),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.07),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: secondColumnBoxes
                        .map<Widget>((box) {
                      if (box.deviceType == 'Lampe') {
                        return Box_lampe(
                          name: box.deviceName,
                          Xcode: box.pairedDevice,
                          onDelete: () {
                            BlocProvider.of<ColumnBloc>(context).deleteBox(box.boxNumber);
                          },
                        );
                      } else {
                        return Box_tv(
                          name: box.deviceName,
                          Xcode: box.pairedDevice,
                          onDelete: () {
                            BlocProvider.of<ColumnBloc>(context).deleteBox(box.boxNumber);
                          },
                        );
                      }
                    })
                        .toList(),
                  ),
                ],
              ),
              if (showButtons)
                AddScence(
                  updateDeviceName: updateDeviceName,
                  updatePairedDevice: updatePairedDevice,
                  updateDeviceType: updateDeviceType,
                  firstColumnData: state.firstColumnData,
                  secondColumnData: state.secondColumnData,

                  onPressed: (newBoxNumber, deviceType, deviceName, pairedDevice) {
                    BlocProvider.of<ColumnBloc>(context).add(AddBoxEvent(
                        newBoxNumber, deviceType, deviceName, pairedDevice));
                    BlocProvider.of<ColumnBloc>(context).add(LoadInitialDataEvent());
                  },
                ),
              const SizedBox(height: 200),
            ],
          );
        },
      ),
    );
  }
}

class Insert extends StatefulWidget {
  final bool showButtons;
  final int maxBoxesToShow;
  final int maxBoxesPerColumn1;
  final int maxBoxesPerColumn2;

  Insert({
    Key? key,
    this.showButtons = true,
    this.maxBoxesToShow = 999,
    this.maxBoxesPerColumn1 = 9999,
    this.maxBoxesPerColumn2 = 9999,
  }) : super(key: key);

  @override
  _InsertState createState() => _InsertState();
}

class _InsertState extends State<Insert> {
  String deviceName = 'malak';
  String pairedDevice = '';
  String deviceType = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //MyWidget(showButtons: true,),
        MyWidgetContent(
          showButtons: widget.showButtons,
          maxBoxesToShow: widget.maxBoxesToShow,
          maxBoxesPerColumn1: widget.maxBoxesPerColumn1,
          maxBoxesPerColumn2: widget.maxBoxesPerColumn2,
          updateDeviceName: (newValue) {
            setState(() {
              deviceName = newValue;
            });
          },
          updatePairedDevice: (newValue) {
            setState(() {
              pairedDevice = newValue;
            });
          },
          updateDeviceType: (newValue) {
            setState(() {
              deviceType = newValue;
            });
          },
        ),
      ],
    );
  }
}
*/
