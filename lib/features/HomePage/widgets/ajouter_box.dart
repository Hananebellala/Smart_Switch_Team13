/*
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../widgets/box_lampe.dart';
import '../widgets/box_tv.dart';
import '../widgets/boutton/add_scence.dart';
import 'dart:async';
import '../screens/scencepage.dart';
import '../widgets/on_off_lampe.dart';
class Box {
  final int boxNumber;
  final String deviceType;
  final String deviceName;
  final String pairedDevice;
  final String etat;
  Box(this.boxNumber, this.deviceType, this.deviceName, this.pairedDevice,this.etat);
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
 class UpdateBoxNameEvent extends ColumnEvent {}
class UpdateBoxetatOFFEvent extends ColumnEvent {}
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
          'CREATE TABLE columns(id INTEGER PRIMARY KEY AUTOINCREMENT, columnNumber INTEGER, boxNumber INTEGER, deviceType TEXT, deviceName TEXT, pairedDevice TEXT, etat TEXT)',
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
      final String? etat = row['etat'];
      return Box(boxNumber, deviceType, deviceName ?? '', pairedDevice ?? '',etat ?? 'OFF');
    }).toList();

    final int newColumnNumber = boxes.length % 2 == 0 ? 1 : 2;

    await _database.insert(
      'columns',
      {
        'columnNumber': newColumnNumber,
        'boxNumber': event.newBoxNumber,
        'deviceType': event.deviceType,
        'deviceName': event.deviceName,
        'pairedDevice': event.pairedDevice,
       
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
      final String? etat = row['etat'];
      return Box(boxNumber, deviceType, deviceName ?? '', pairedDevice ?? '',etat ?? 'OFF');
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
      final String? etat = row['etat'];
      return Box(boxNumber, deviceType, deviceName ?? '', pairedDevice ?? '',etat ??'OFF' );
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
                            Xid:box.boxNumber,
                            etat:'ON',
                            name: box.deviceName,
                            Xcode: box.pairedDevice,
                            onDelete: () {
                              BlocProvider.of<ColumnBloc>(context).deleteBox(box.boxNumber);
                            },
                          );
                        } else {
                          return Box_tv(
                             Xid:box.boxNumber,
                             etat:'OFF',
                                malak:false,
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
                             Xid:box.boxNumber,
                            etat:'ON',
                             
                            name: box.deviceName,
                            Xcode: box.pairedDevice,
                            onDelete: () {
                              BlocProvider.of<ColumnBloc>(context).deleteBox(box.boxNumber);
                            },
                          );
                        } else {
                          return Box_tv(
                             Xid:box.boxNumber,
                              etat:'ON',
                              malak:false,
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

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../widgets/box_lampe.dart';
import '../widgets/box_tv.dart';
import '../widgets/boutton/add_scence.dart';
import 'dart:async';
import '../screens/scencepage.dart';
import '../widgets/on_off_lampe.dart';
class Box {
  final int boxNumber;
  final String deviceType;
  final String deviceName;
  final String pairedDevice;
  final String etat;
  Box(this.boxNumber, this.deviceType, this.deviceName, this.pairedDevice,
  this.etat
  );
}

class ColumnEvent {}

class AddBoxEvent extends ColumnEvent {
  final int newBoxNumber;
  final String deviceType;
    final String deviceName;
  final String pairedDevice;
  
  AddBoxEvent(
      this.newBoxNumber, this.deviceType, this.deviceName, this.pairedDevice, );
      
  
}


///////////+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
class UpdateBoxNameEvent extends ColumnEvent {
   final int boxNumber;
   UpdateBoxNameEvent(this.boxNumber);
}
class UpdateBoxetatOFFEvent extends ColumnEvent {
   final int boxNumber;
   UpdateBoxetatOFFEvent(this.boxNumber);
}
class DeleteBoxEvent extends ColumnEvent {
  final int boxNumber;
  DeleteBoxEvent(this.boxNumber);
}
////////////////////////////////////////////////////////
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
    on<UpdateBoxNameEvent>(_mapUpdateBoxNameEventToState);
    on<UpdateBoxetatOFFEvent>(_mapUpdateBoxetatOFFEventToState);
  }

  void addBox(int newBoxNumber, String deviceType, String deviceName,
      String pairedDevice,String etat) {
    add(AddBoxEvent(newBoxNumber, deviceType, deviceName, pairedDevice,
   
    ));
  }



  void deleteBox(int boxNumber) {
    add(DeleteBoxEvent(boxNumber));
  }
  
////////////////////:



void updateBoxName(int boxNumber) {
  add(UpdateBoxNameEvent(boxNumber));
}

Future<void> _mapUpdateBoxNameEventToState(
    UpdateBoxNameEvent event, Emitter<ColumnState> emit) async {
  

  final List<Map<String, dynamic>> rows = await _database.query('columns');
  final List<Box> boxes = rows.map((row) {
    final int boxNumber = row['boxNumber'];
    final String deviceType = row['deviceType'];
    final String? deviceName = row['deviceName'];
    final String? pairedDevice = row['pairedDevice'];
    final String? etat = row['etat'];
    return Box(boxNumber, deviceType, deviceName ?? '', pairedDevice ?? '', etat ?? 'ON');
  }).toList();


  for (var box in boxes) {
    if (box.etat != 'ON') {
      // Mettez à jour l'état uniquement si l'état précédent n'était pas "ON"
      await _database.update(
        'columns',
        {'etat': 'ON'},
         where: 'boxNumber = ?',
        whereArgs: [event.boxNumber],
        
      );
    }
  }
  emit(_getColumnState(boxes));
}
/////////////////////////////////////


void etatOFF(int boxNumber) {
  add(UpdateBoxetatOFFEvent( boxNumber));
}

Future<void> _mapUpdateBoxetatOFFEventToState(
    UpdateBoxetatOFFEvent event, Emitter<ColumnState> emit) async {
  

  final List<Map<String, dynamic>> rows = await _database.query('columns');
  final List<Box> boxes = rows.map((row) {
    final int boxNumber = row['boxNumber'];
    final String deviceType = row['deviceType'];
    final String? deviceName = row['deviceName'];
    final String? pairedDevice = row['pairedDevice'];
    final String? etat = row['etat'];
    return Box(boxNumber, deviceType, deviceName ?? '', pairedDevice ?? '', etat ?? 'OFF');
  }).toList();


  for (var box in boxes) {
    if (box.etat != 'OFF') {
      // Mettez à jour l'état uniquement si l'état précédent n'était pas "ON"
      await _database.update(
        'columns',
        {'etat': 'OFF'},
         where: 'boxNumber = ?',
         whereArgs: [event.boxNumber],
        
      );
    }
  }
  emit(_getColumnState(boxes));
}

////////////////////////////////////
  Future<void> _openDatabaseAndLoadInitialData() async {
    _database = await _initializeDatabase();
    add(LoadInitialDataEvent());
  }

  Future<Database> _initializeDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE columns(id INTEGER PRIMARY KEY AUTOINCREMENT, columnNumber INTEGER, boxNumber INTEGER, deviceType TEXT, deviceName TEXT, pairedDevice TEXT ,etat TEXT)',
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
    final String? etat = row['etat'];
      return Box(boxNumber, deviceType, deviceName ?? '', pairedDevice ?? '', etat ?? 'OFF');
    }).toList();

    final int newColumnNumber = boxes.length % 2 == 0 ? 1 : 2;

    await _database.insert(
      'columns',
      {
        'columnNumber': newColumnNumber,
        'boxNumber': event.newBoxNumber,
        'deviceType': event.deviceType,
        'deviceName': event.deviceName,
        'pairedDevice': event.pairedDevice,
       //'etat': 'OFF',
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
      final String? etat = row['etat'];
      return Box(boxNumber, deviceType, deviceName ?? '', pairedDevice ?? '',etat ?? 'ON');
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
      final String? etat = row['etat'];
      return Box(boxNumber, deviceType, deviceName ?? '', pairedDevice ?? '',etat?? 'OFF');
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
  final String etat;
  final Function(String) updateDeviceName;
  final Function(String) updatePairedDevice;
  final Function(String) updateDeviceType;
   final Function(String) updateBoxetat;
  final bool showButtons;
  final int maxBoxesToShow;
  final int maxBoxesPerColumn1; // Nombre maximum de boîtes par colonne 1
  final int maxBoxesPerColumn2; // Nombre maximum de boîtes par colonne 2

  MyWidgetContent({
    required this.deviceName,
    required this.pairedDevice,
    required this.deviceType,
     required this.etat,
    required this.updateDeviceName,
    required this.updatePairedDevice,
    required this.updateDeviceType,
        required this.updateBoxetat,

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
             ElevatedButton(
                        onPressed: () {
                              BlocProvider.of<ColumnBloc>(context).add(UpdateBoxetatOFFEvent(0));
                                       },
                             child: Text('Modifier tous les rtat des boîtiers à "Off"'),
                                ),
            ElevatedButton(
                        onPressed: () {
                              BlocProvider.of<ColumnBloc>(context).add(UpdateBoxNameEvent(0));
                                       },
                             child: Text('Modifier tous les rtat des boîtiers à "On"'),
                                ),
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
                            Xid:box.boxNumber,
                            etat:'OFF',
                            name: box.deviceName,
                            Xcode: box.pairedDevice,
                            onDelete: () {
                              BlocProvider.of<ColumnBloc>(context).deleteBox(box.boxNumber);
                            },
                          );
                        } else {
                          return Box_tv(
                             Xid:box.boxNumber,
                             etat:'ON',
                            name: box.etat,
                            Xcode: box.pairedDevice,
                            onDelete: () {
                              BlocProvider.of<ColumnBloc>(context).deleteBox(box.boxNumber);
                            },
                           // malak:box.etat=='OFF'?false:true,
                            malak:false,
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
                             Xid:box.boxNumber,
                            etat:'ON',

                            name: box.deviceName,
                            Xcode: box.pairedDevice,
                            onDelete: () {
                              BlocProvider.of<ColumnBloc>(context).deleteBox(box.boxNumber);
                            },
                          );
                        } else {
                          return Box_tv(
                             Xid:box.boxNumber,
                              etat:'OFF',
                            name: box.etat,
                            Xcode: box.pairedDevice,
                           // malak:box.etat=='OFF'?false:true,
                              malak:false,

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
  String pairedDevice = 'OFF';
  String deviceType = '';
  String etat = 'etat';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ColumnBloc(),
      child: MyWidgetContent(
        deviceName: deviceName,
        pairedDevice: pairedDevice,
        deviceType: deviceType,
        etat:etat,
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
         updateBoxetat: (newValue) {
           print('ellemarche ');
          setState(() {
            etat = newValue;
            print(etat);
           
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

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../widgets/box_lampe.dart';
import '../widgets/box_tv.dart';
import '../widgets/boutton/add_scence.dart';
import 'dart:async';
import '../screens/next_homepage.dart';
import '../screens/scencepage.dart';
import '../widgets/on_off_lampe.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Box {
  final int boxNumber;
  final String deviceType;
  final String deviceName;
  final String pairedDevice;
  final String etat;
  Box(this.boxNumber, this.deviceType, this.deviceName, this.pairedDevice,
  this.etat
  );
}

class ColumnEvent {}

class AddBoxEvent extends ColumnEvent {
  final int newBoxNumber;
  final String deviceType;
    final String deviceName;
  final String pairedDevice;
  final String etat ;
  AddBoxEvent(
      this.newBoxNumber, this.deviceType, this.deviceName, this.pairedDevice,this.etat  );
      
  
}


///////////+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
class UpdateBoxNameEvent extends ColumnEvent {
   final int boxNumber;
   UpdateBoxNameEvent(this.boxNumber);
}
class UpdateBoxetatOFFEvent extends ColumnEvent {
   final int boxNumber;
   UpdateBoxetatOFFEvent(this.boxNumber);
}
class DeleteBoxEvent extends ColumnEvent {
  final int boxNumber;
  DeleteBoxEvent(this.boxNumber);
}
////////////////////////////////////////////////////////
class LoadInitialDataEvent extends ColumnEvent {
  
}

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
    on<UpdateBoxNameEvent>(_mapUpdateBoxNameEventToState);
    on<UpdateBoxetatOFFEvent>(_mapUpdateBoxetatOFFEventToState);
  }

  void addBox(int newBoxNumber, String deviceType, String deviceName,
      String pairedDevice,String etat) {
    add(AddBoxEvent(newBoxNumber, deviceType, deviceName, pairedDevice,etat
   
    ));
  }



  void deleteBox(int boxNumber) {
    add(DeleteBoxEvent(boxNumber));
  }
  
////////////////////:



void updateBoxName(int boxNumber) {
  add(UpdateBoxNameEvent(boxNumber));
}

Future<void> _mapUpdateBoxNameEventToState(
    UpdateBoxNameEvent event, Emitter<ColumnState> emit) async {
  

  final List<Map<String, dynamic>> rows = await _database.query('columns');
  final List<Box> boxes = rows.map((row) {
    final int boxNumber = row['boxNumber'];
    final String deviceType = row['deviceType'];
    final String? deviceName = row['deviceName'];
    final String? pairedDevice = row['pairedDevice'];
    final String? etat = row['etat'];
    return Box(boxNumber, deviceType, deviceName ?? '', pairedDevice ?? '', etat ?? 'ON');
  }).toList();


  for (var box in boxes) {
    if ( box.etat!='ON') {
      // Mettez à jour l'état uniquement si l'état précédent n'était pas "ON"
      await _database.update(
        'columns',
        {'etat': 'ON'},
       
        
      );
    }
  }
  emit(_getColumnState(boxes));
}
/////////////////////////////////////


void etatOFF(int boxNumber) {
  add(UpdateBoxetatOFFEvent( boxNumber));
}

Future<void> _mapUpdateBoxetatOFFEventToState(
    UpdateBoxetatOFFEvent event, Emitter<ColumnState> emit) async {
  

  final List<Map<String, dynamic>> rows = await _database.query('columns');
  final List<Box> boxes = rows.map((row) {
    final int boxNumber = row['boxNumber'];
    final String deviceType = row['deviceType'];
    final String? deviceName = row['deviceName'];
    final String? pairedDevice = row['pairedDevice'];
    final String? etat = row['etat'];
    return Box(boxNumber, deviceType, deviceName ?? '', pairedDevice ?? '', etat ?? 'OFF');
  }).toList();


  for (var box in boxes) {
    if (box.etat!='OFF' ) {
      // Mettez à jour l'état uniquement si l'état précédent n'était pas "ON"
      await _database.update(
        'columns',
        {'etat': 'OFF'},
        
        
      );
    }
  }
  emit(_getColumnState(boxes));
}

////////////////////////////////////
  Future<void> _openDatabaseAndLoadInitialData() async {
    _database = await _initializeDatabase();
    add(LoadInitialDataEvent());
  }

  Future<Database> _initializeDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE columns(id INTEGER PRIMARY KEY AUTOINCREMENT, columnNumber INTEGER, boxNumber INTEGER, deviceType TEXT, deviceName TEXT, pairedDevice TEXT , etat TEXT)',
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
    final String? etat = row['etat'];
      return Box(boxNumber, deviceType, deviceName ?? '', pairedDevice ?? '', etat ?? 'OFF');
    }).toList();
     

    final int newColumnNumber = boxes.length % 2 == 0 ? 1 : 2;

    await _database.insert(
      'columns',
      {
        'columnNumber': newColumnNumber,
        'boxNumber': event.newBoxNumber,
        'deviceType': event.deviceType,
        'deviceName': event.deviceName,
        'pairedDevice': event.pairedDevice,
        'etat':event.etat,
        
      },
    );

    emit(_getColumnState(boxes));
  }
Future<void> _mapLoadInitialDataEventToState(
    LoadInitialDataEvent event, Emitter<ColumnState> emit) async {
  final List<Map<String, dynamic>> rows = await _database.query('columns');
  

  // Construire la liste des boîtes avec defaultBoxState
  final List<Box> boxes = rows.map((row) {
    final int columnNumber = row['columnNumber'];
    final int boxNumber = row['boxNumber'];
    final String deviceType = row['deviceType'];
    final String? pairedDevice = row['pairedDevice'];
    final String? deviceName = row['deviceName'];
    //final String etat = anyBoxIsOn ? 'ON' : 'OFF';
        final String? etat = row['etat'];
    return Box(boxNumber, deviceType, deviceName ?? '', pairedDevice ?? '', etat ?? 'OFF');
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
      final String? etat = row['etat'];
      return Box(boxNumber, deviceType, deviceName ?? '', pairedDevice ?? '',etat?? 'OFF');
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

class MyWidgetContent extends StatefulWidget {
  final String deviceName;
  final String pairedDevice;
  final String deviceType;
  final String etat;
  final Function(String) updateDeviceName;
  final Function(String) updatePairedDevice;
  final Function(String) updateDeviceType;
   final Function(String) updateBoxetat;
  final bool showButtons;
    final bool showlist;
 final bool show;
  final int maxBoxesToShow;
  final int maxBoxesPerColumn1; // Nombre maximum de boîtes par colonne 1
  final int maxBoxesPerColumn2; // Nombre maximum de boîtes par colonne 2

  MyWidgetContent({
    required this.deviceName,
    required this.pairedDevice,
    required this.deviceType,
     required this.etat,
    required this.updateDeviceName,
    required this.updatePairedDevice,
    required this.updateDeviceType,
        required this.updateBoxetat,
 required this.showlist,
    required this.showButtons,
    required this.show,
    required this.maxBoxesToShow,
    required this.maxBoxesPerColumn1,
    required this.maxBoxesPerColumn2,
  });

  @override
  _MyWidgetContentState createState() => _MyWidgetContentState();
}

class _MyWidgetContentState extends State<MyWidgetContent> {
  late bool on;

  @override
  void initState() {
    super.initState();
    _loadCheckedState();
  }

  Future<void> _loadCheckedState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      on = prefs.getBool(_getUniqueKey()) ?? false;
    });
  }

  Future<void> _saveCheckedState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_getUniqueKey(), value);
  }

  String _getUniqueKey() {
    // Utilisez le nom ou l'identifiant de la case comme clé unique
    return 'on${widget.deviceName}';
  }

  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColumnBloc, ColumnState>(
      builder: (context, state) {
        final firstColumnBoxes = state.firstColumnData.take(widget.maxBoxesPerColumn1).toList();
        final secondColumnBoxes = state.secondColumnData.take(widget.maxBoxesPerColumn2).toList();
        return Column(
          children: [
           /* if(widget.show)
             ElevatedButton(
                        onPressed: () {
                              BlocProvider.of<ColumnBloc>(context).add(UpdateBoxetatOFFEvent(0));
                               BlocProvider.of<ColumnBloc>(context).add(LoadInitialDataEvent());
                              
                                       },
                             child: Text('Modifier tous les rtat des boîtiers à "Off"'),
                                ),
              if(widget.show)
            ElevatedButton(
                        onPressed: () {
                              BlocProvider.of<ColumnBloc>(context).add(UpdateBoxNameEvent(0));
                               BlocProvider.of<ColumnBloc>(context).add(LoadInitialDataEvent());
                              
                                       },
                             child: Text('Modifier tous les rtat des boîtiers à "On"'),
                                ),*/
             if (widget.show)
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAF7FF),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                        Positioned(
                          top: 8,
                          left: 10,
                          right: 10,
                          child: Text(
                            '  Turn Off all devices               ', // turn off all devices qui existe en temps de aluumer ce boutton 
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        Positioned(
                          right:0,
                          child: Switch(
                            value: on,
                            onChanged: (newValue) {
                              if (newValue) {
                                BlocProvider.of<ColumnBloc>(context).add(UpdateBoxNameEvent(0));
                              } else {
                                BlocProvider.of<ColumnBloc>(context).add(UpdateBoxetatOFFEvent(0));
                              }
                              BlocProvider.of<ColumnBloc>(context).add(LoadInitialDataEvent());
                              _saveCheckedState(newValue); // Enregistrez l'état de l'interrupteur
                              setState(() {
                                on = newValue;
                              });
                            },
                            activeColor: const Color(0xFFA58BFF), // Couleur de l'interrupteur lorsque activé
                            inactiveThumbColor: const Color(0xFFFAF7FF), // Couleur de la poignée lorsque désactivé
                            inactiveTrackColor: Colors.black.withOpacity(0.2), // Couleur de la piste lorsque désactivé
                          ),
                        ),
                      ],
                    ),
                  ),
        SizedBox(
          height: 25,
        ),
      ],
    ),
            if (widget.showButtons)
              ElevatedButton(
                onPressed: () {
                 
                  BlocProvider.of<ColumnBloc>(context).add(LoadInitialDataEvent());
                },
                child: Text('Actualiser'),
              ),
            const SizedBox(height: 20),
            if (widget.showlist)
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
                            Xid:box.boxNumber,
                            etat:'OFF',
                            name: box.deviceName,
                            Xcode: box.pairedDevice,
                             malak:box.etat=='OFF'?false:true,
                            onDelete: () {
                              BlocProvider.of<ColumnBloc>(context).deleteBox(box.boxNumber);
                            },
                          );
                        } else {
                          return Box_tv(
                             Xid:box.boxNumber,
                             etat:'ON',
                            name: box.deviceName,
                            Xcode: box.pairedDevice,
                            onDelete: () {
                              BlocProvider.of<ColumnBloc>(context).deleteBox(box.boxNumber);
                            },
                           malak:box.etat=='OFF'?false:true,
                            //malak:true,
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
                             Xid:box.boxNumber,
                            etat:'ON',
                            malak:box.etat=='OFF'?false:true,
                            name: box.deviceName,
                            Xcode: box.pairedDevice,
                            onDelete: () {
                              BlocProvider.of<ColumnBloc>(context).deleteBox(box.boxNumber);
                            },
                          );
                        } else {
                          return Box_tv(
                             Xid:box.boxNumber,
                              etat:'OFF',
                            name: box.deviceName,
                            Xcode: box.pairedDevice,
                           malak:box.etat=='OFF'?false:true,
                              //malak:true,

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
            if (widget.showButtons)
              AddScence(
                updateDeviceName: widget.updateDeviceName,
                updatePairedDevice:widget. updatePairedDevice,
                updateDeviceType:widget. updateDeviceType,
                firstColumnData: state.firstColumnData,
                secondColumnData: state.secondColumnData,
                onPressed: (newBoxNumber, deviceType, deviceName, pairedDevice) {
                  BlocProvider.of<ColumnBloc>(context).add(AddBoxEvent(
                      newBoxNumber, deviceType, deviceName, pairedDevice,'OFF'));
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
  final bool showlist;
  final bool show;
  final int maxBoxesToShow;
  final int maxBoxesPerColumn1;
  final int maxBoxesPerColumn2;

  Insert({
    Key? key,
    this.showButtons = true,
    this.showlist = true,
     this.show = false,
    this.maxBoxesToShow = 999,
    this.maxBoxesPerColumn1 = 9999,
    this.maxBoxesPerColumn2 = 9999,
  }) : super(key: key);

  @override
  _InsertState createState() => _InsertState();
}

class _InsertState extends State<Insert> {
  String deviceName = 'malak';
  String pairedDevice = 'OFF';
  String deviceType = '';
  String etat = 'etat';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ColumnBloc(),
      child: MyWidgetContent(
        deviceName: deviceName,
        pairedDevice: pairedDevice,
        deviceType: deviceType,
        etat:etat,
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
         updateBoxetat: (newValue) {
           print('ellemarche ');
          setState(() {
            etat = newValue;
            print(etat);
           
          });
        },
        showButtons: widget.showButtons,
         showlist: widget.showlist,
         show:widget.show,
        maxBoxesToShow: widget.maxBoxesToShow,
        maxBoxesPerColumn1: widget.maxBoxesPerColumn1,
        maxBoxesPerColumn2: widget.maxBoxesPerColumn2,
      ),
    );
  }
}