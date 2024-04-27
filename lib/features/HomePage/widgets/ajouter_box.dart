/*import 'package:flutter/material.dart';
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
*/
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
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
   /////////////////////////////////////////////////////////////         
            if (showButtons)
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<ColumnBloc>(context).add(LoadInitialDataEvent());
                },
                child: Text('Actualiser'),
              ),
            const SizedBox(height: 20),
 ////////////////////////////////////////////////////////////////////////:           
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
 ////////////////////////////////////////////////////////////////////////////////           
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: ListView(
                children: state.firstColumnData.map((box) {
                  return ListTile(
                    title: Text(box.deviceName),
                    // Vous pouvez ajouter d'autres informations de la boîte ici si nécessaire
                    onTap: () {
                      // Ajouter la logique de sélection de l'appareil ici
                      // Lorsque l'utilisateur appuie sur un nom d'appareil, vous pouvez ajouter cet appareil à une liste de sélection
                    },
                  );
                }).toList(),
              ),
            ),
  //////////////////////////////////////////////////////////////////////////////////////////////:          
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
}*/
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../widgets/box_lampe.dart';
import '../widgets/box_tv.dart';
import '../widgets/boutton/add_scence.dart';
import 'dart:async';
import '../screens/scencepage.dart';

class DeviceList {
  final String name;
  final bool isOn;

  DeviceList(this.name, {this.isOn = true});
}

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

class ToggleDeviceListPowerEvent extends ColumnEvent {
  final DeviceList deviceList;
  ToggleDeviceListPowerEvent(this.deviceList);
}

class ColumnState {
  final List<Box> firstColumnData;
  final List<Box> secondColumnData;
  final List<DeviceList> deviceLists;

  ColumnState(this.firstColumnData, this.secondColumnData, this.deviceLists);

  ColumnState copyWith({
    List<Box>? firstColumnData,
    List<Box>? secondColumnData,
    List<DeviceList>? deviceLists,
  }) {
    return ColumnState(
      firstColumnData ?? this.firstColumnData,
      secondColumnData ?? this.secondColumnData,
      deviceLists ?? this.deviceLists,
    );
  }
}

class ColumnBloc extends Bloc<ColumnEvent, ColumnState> {
  late Database _database;

  ColumnBloc() : super(ColumnState([], [], [])) {
    _openDatabaseAndLoadInitialData();
    on<AddBoxEvent>(_mapAddBoxEventToState);
    on<LoadInitialDataEvent>(_mapLoadInitialDataEventToState);
    on<DeleteBoxEvent>(_mapDeleteBoxEventToState);
    on<ToggleDeviceListPowerEvent>(_mapToggleDeviceListPowerEventToState);
  }

  void addBox(int newBoxNumber, String deviceType, String deviceName,
      String pairedDevice) {
    add(AddBoxEvent(newBoxNumber, deviceType, deviceName, pairedDevice));
  }

  void deleteBox(int boxNumber) {
    add(DeleteBoxEvent(boxNumber));
  }

  void toggleDeviceListPower(DeviceList deviceList) {
    add(ToggleDeviceListPowerEvent(deviceList));
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

  Future<void> _mapToggleDeviceListPowerEventToState(
      ToggleDeviceListPowerEvent event, Emitter<ColumnState> emit) async {
    final newDeviceLists = state.deviceLists.map((list) {
      if (list.name == event.deviceList.name) {
        return DeviceList(list.name, isOn: !list.isOn);
      }
      return list;
    }).toList();

    emit(state.copyWith(deviceLists: newDeviceLists));
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

    return ColumnState(firstColumnData, secondColumnData, []);
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
        final firstColumnBoxes =
            state.firstColumnData.take(maxBoxesPerColumn1).toList();
        final secondColumnBoxes =
            state.secondColumnData.take(maxBoxesPerColumn2).toList();

        return Column(
          children: [
            if (showButtons)
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<ColumnBloc>(context)
                      .add(LoadInitialDataEvent());
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
                  children: firstColumnBoxes.map<Widget>((box) {
                    if (box.deviceType == 'Lampe') {
                      return Box_lampe(
                        name: box.deviceName,
                        Xcode: box.pairedDevice,
                        onDelete: () {
                          BlocProvider.of<ColumnBloc>(context)
                              .deleteBox(box.boxNumber);
                        },
                      );
                    } else {
                      return Box_tv(
                        name: box.deviceName,
                        Xcode: box.pairedDevice,
                        onDelete: () {
                          BlocProvider.of<ColumnBloc>(context)
                              .deleteBox(box.boxNumber);
                        },
                      );
                    }
                  }).toList(),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.07),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: secondColumnBoxes.map<Widget>((box) {
                    if (box.deviceType == 'Lampe') {
                      return Box_lampe(
                        name: box.deviceName,
                        Xcode: box.pairedDevice,
                        onDelete: () {
                          BlocProvider.of<ColumnBloc>(context)
                              .deleteBox(box.boxNumber);
                        },
                      );
                    } else {
                      return Box_tv(
                        name: box.deviceName,
                        Xcode: box.pairedDevice,
                        onDelete: () {
                          BlocProvider.of<ColumnBloc>(context)
                              .deleteBox(box.boxNumber);
                        },
                      );
                    }
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),

            /*  SizedBox(
  height: 200,
  child: ListView(
    children: [
      ...state.firstColumnData.map((box) {
        return ListTile(
          title: Text(box.deviceName),
          onTap: () {
            // Ajouter la logique de sélection de l'appareil ici
            // Lorsque l'utilisateur appuie sur un nom d'appareil, vous pouvez ajouter cet appareil à une liste de sélection
          },
        );
      }),
      ...state.secondColumnData.map((box) {
        return ListTile(
          title: Text(box.deviceName),
          onTap: () {
            // Ajouter la logique de sélection de l'appareil ici
            // Lorsque l'utilisateur appuie sur un nom d'appareil, vous pouvez ajouter cet appareil à une liste de sélection
          },
        );
      }),
    ],
  ),
),*/

            if (showButtons)
              AddScence(
                updateDeviceName: updateDeviceName,
                updatePairedDevice: updatePairedDevice,
                updateDeviceType: updateDeviceType,
                firstColumnData: state.firstColumnData,
                secondColumnData: state.secondColumnData,
                onPressed:
                    (newBoxNumber, deviceType, deviceName, pairedDevice) {
                  BlocProvider.of<ColumnBloc>(context).add(AddBoxEvent(
                      newBoxNumber, deviceType, deviceName, pairedDevice));
                  BlocProvider.of<ColumnBloc>(context)
                      .add(LoadInitialDataEvent());
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
