/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../widgets/box_lampe.dart';
import '../widgets/box_tv.dart';
import '../widgets/boutton/add_scence.dart';
import '../widgets/boutton/sceneDevice.dart';
import 'dart:async';
import '../screens/scencepage.dart';

class Case {
  final int boxNumber;
  final String deviceType;
  final String deviceName;
  Case(this.boxNumber, this.deviceType, this.deviceName,);
}

class ColumnEvent2 {}

class AddBoxEvent2 extends ColumnEvent2 {
  final int newBoxNumber;
  final String deviceType;
  final String deviceName;

  AddBoxEvent2(
      this.newBoxNumber, this.deviceType, this.deviceName);
}

class DeleteBoxEvent extends ColumnEvent2 {
  final int boxNumber;
  DeleteBoxEvent(this.boxNumber);
}

class LoadInitialDataEvent2 extends ColumnEvent2 {}

class ColumnState2 {
  final List<Case> ColumnData2;

  ColumnState2( this.ColumnData2);
}

class ColumnBloc2 extends Bloc<ColumnEvent2, ColumnState2> {
  late Database _database;

  ColumnBloc2() : super(ColumnState2([])) {
    _openDatabaseAndLoadInitialData();
    on<AddBoxEvent2>(_mapAddBoxEvent2ToState);
    on<LoadInitialDataEvent2>(_mapLoadInitialDataEvent2ToState);
    on<DeleteBoxEvent>(_mapDeleteBoxEventToState);
  }

  void addCase(int newBoxNumber, String deviceType, String deviceName) {
    add(AddBoxEvent2(newBoxNumber, deviceType, deviceName));
  }

  void deleteBox(int boxNumber) {
    add(DeleteBoxEvent(boxNumber));
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
          'CREATE TABLE columns(id INTEGER PRIMARY KEY AUTOINCREMENT, columnNumber INTEGER, boxNumber INTEGER, deviceType TEXT, deviceName TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> _mapAddBoxEvent2ToState(
      AddBoxEvent2 event, Emitter<ColumnState2> emit) async {
    final List<Map<String, dynamic>> rows = await _database.query('columns');
    final List<Case> cases = rows.map((row) {
      final int boxNumber = row['boxNumber'];
      final String deviceType = row['deviceType'];
      final String? deviceName = row['deviceName'];
      return Case(boxNumber, deviceType, deviceName ?? '');
    }).toList();

    final int newColumnNumber = cases.length % 2 == 0 ? 1 : 2;

    await _database.insert(
      'columns',
      {
        'columnNumber': newColumnNumber,
        'boxNumber': event.newBoxNumber,
        'deviceType': event.deviceType,
        'deviceName': event.deviceName,
      },
    );

    emit(_getColumnState2(cases));
  }

  Future<void> _mapLoadInitialDataEvent2ToState(
      LoadInitialDataEvent2 event, Emitter<ColumnState2> emit) async {
    final List<Map<String, dynamic>> rows = await _database.query('columns');
    final List<Case> cases = rows.map((row) {
      final int columnNumber = row['columnNumber'];
      final int boxNumber = row['boxNumber'];
      final String deviceType = row['deviceType'];
      final String? deviceName = row['deviceName'];
      return Case(boxNumber, deviceType, deviceName ?? '');
    }).toList();

    emit(_getColumnState2(cases));
  }

  Future<void> _mapDeleteBoxEventToState(
      DeleteBoxEvent event, Emitter<ColumnState2> emit) async {
    await _database.delete('columns',
        where: 'boxNumber = ?', whereArgs: [event.boxNumber]);

    final List<Map<String, dynamic>> rows = await _database.query('column');
    final List<Case> cases = rows.map((row) {
      final int boxNumber = row['boxNumber'];
      final String deviceType = row['deviceType'];
      final String? deviceName = row['deviceName'];
      return Case(boxNumber, deviceType, deviceName ?? '', );
    }).toList();
    emit(_getColumnState2(cases));
  }

  ColumnState2 _getColumnState2(List<Case> cases) {
    final List<Case> ColumnData2 = [];
    for (int i = 0; i < cases.length; i++) {
        ColumnData2.add(cases[i]);
      }
   

    return ColumnState2(ColumnData2);
  }

  List<Case> get cases => state.ColumnData2 ;

  

  int countCases() {
    return cases.length;
  }
}

class MyWidget extends StatelessWidget {
  final bool showButtons;
  //final int maxBoxesToShow;
  //final int maxBoxesPerColumn1;
  //final int maxBoxesPerColumn2;
  

  MyWidget({
    Key? key,
    required this.showButtons,
    //required this.maxBoxesToShow,
    //required this.maxBoxesPerColumn1,
   // required this.maxBoxesPerColumn2,
   
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ColumnBloc2(),
      child: BlocBuilder<ColumnBloc2, ColumnState2>(
        builder: (context, state) {
          final Columncases = state.ColumnData2;

          return Column(
            children: [
              if (showButtons)
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<ColumnBloc2>(context).add(LoadInitialDataEvent2());
                  },
                  child: Text('Actualiser'),
                ),
              const SizedBox(height: 20),
            
                  SizedBox(width: MediaQuery.of(context).size.width * 0.065),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: Columncases
                        .map<Widget>((u) {
                      if (u.deviceType == 'Lampe') {
                        return SceneDevice(deviceName:  u.deviceName,isChecked:true);
                        
                      } else {
                        return SceneDevice(deviceName:  u.deviceName,isChecked:true);
                         
                      }
                    })
                        .toList(),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.07),
                  
               
              ElevatedButton(
  onPressed: () {
    final columnBloc2 = BlocProvider.of<ColumnBloc2>(context);
    columnBloc2.add(AddBoxEvent2(1, 'malk', 'tv'));
    columnBloc2.add(LoadInitialDataEvent2()); // Rafraîchir les données après l'ajout
  },
  child: Text('Ajouter une case'),
),
              const SizedBox(height: 200),
            ],
          );
        },
      ),
    );
  }
}

class Insert3 extends StatefulWidget {
  final bool showButtons;
  final int maxBoxesToShow;
  final int maxBoxesPerColumn1;
  final int maxBoxesPerColumn2;

  Insert3({
    Key? key,
    this.showButtons = true,
    this.maxBoxesToShow = 999,
    this.maxBoxesPerColumn1 = 9999,
    this.maxBoxesPerColumn2 = 9999,
  }) : super(key: key);

  @override
  _InsertState createState() => _InsertState();
}

class _InsertState extends State<Insert3> {
  String deviceName = 'malak';
  String pairedDevice = '';
  String deviceType = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyWidget(showButtons: true,),
       /* MyWidgetContent(
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
        ),*/
      ],
    );
  }
}
*/



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../widgets/boutton/scene.dart';
import 'dart:async';

class Case {
  final int boxNumber;
  final String deviceType;
  final String deviceName;
  Case(this.boxNumber, this.deviceType, this.deviceName);
}

class ColumnEvent2 {}

class AddBoxEvent2 extends ColumnEvent2 {
  final int newBoxNumber;
  final String deviceType;
  final String deviceName;

  AddBoxEvent2(this.newBoxNumber, this.deviceType, this.deviceName);
}

class DeleteBoxEvent extends ColumnEvent2 {
  final int boxNumber;
  DeleteBoxEvent(this.boxNumber);
}

class LoadInitialDataEvent2 extends ColumnEvent2 {}

class ColumnState2 {
  final List<Case> ColumnData2;

  ColumnState2(this.ColumnData2);
}

class ColumnBloc2 extends Bloc<ColumnEvent2, ColumnState2> {
  late Database _database;

  ColumnBloc2() : super(ColumnState2([])) {
    _openDatabaseAndLoadInitialData();
    on<AddBoxEvent2>(_mapAddBoxEvent2ToState);
    on<LoadInitialDataEvent2>(_mapLoadInitialDataEvent2ToState);
    on<DeleteBoxEvent>(_mapDeleteBoxEventToState);
  }

  void addCase(int newBoxNumber, String deviceType, String deviceName) {
    add(AddBoxEvent2(newBoxNumber, deviceType, deviceName));
  }

  void deleteBox(int boxNumber) {
    add(DeleteBoxEvent(boxNumber));
  }

  Future<void> _openDatabaseAndLoadInitialData() async {
    _database = await _initializeDatabase();
    final bool tableExists = await _isTableExists('malak');

    if (!tableExists) {
      await _createTableAndAddDefaultData();
    } else {
      add(LoadInitialDataEvent2());
    }
  }

  Future<bool> _isTableExists(String tableName) async {
    final List<Map<String, dynamic>> tables = await _database.query(
      'sqlite_master',
      where: 'type = ? AND name = ?',
      whereArgs: ['table', tableName],
    );
    return tables.isNotEmpty;
  }

  Future<void> _createTableAndAddDefaultData() async {
    await _database.execute(
      'CREATE TABLE malak(id INTEGER PRIMARY KEY AUTOINCREMENT, columnNumber INTEGER, boxNumber INTEGER, deviceType TEXT, deviceName TEXT)',
    );

    await _database.insert(
      'malak',
      {
        'columnNumber': 1,
        'boxNumber': 1,
        'deviceType': 'DefaultType',
        'deviceName': 'DefaultName',
      },
    );

    add(LoadInitialDataEvent2());
  }

  Future<Database> _initializeDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE malak(id INTEGER PRIMARY KEY AUTOINCREMENT, columnNumber INTEGER, boxNumber INTEGER, deviceType TEXT, deviceName TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> _mapAddBoxEvent2ToState(
      AddBoxEvent2 event, Emitter<ColumnState2> emit) async {
    final List<Map<String, dynamic>> rows = await _database.query('malak');
    final List<Case> cases = rows.map((row) {
      final int boxNumber = row['boxNumber'];
      final String deviceType = row['deviceType'];
      final String? deviceName = row['deviceName'];
      return Case(boxNumber, deviceType, deviceName ?? '');
    }).toList();

    final int newColumnNumber = cases.length % 2 == 0 ? 1 : 2;
    
    await _database.insert(
      'malak',
      {
        'columnNumber': newColumnNumber,
        'boxNumber': event.newBoxNumber,
        'deviceType': event.deviceType,
        'deviceName': event.deviceName,
      },
    );

    emit(_getColumnState2(cases));
  }

  Future<void> _mapLoadInitialDataEvent2ToState(
      LoadInitialDataEvent2 event, Emitter<ColumnState2> emit) async {
    final List<Map<String, dynamic>> rows = await _database.query('malak');
    final List<Case> cases = rows.map((row) {
      final int columnNumber = row['columnNumber'];
      final int boxNumber = row['boxNumber'];
      final String deviceType = row['deviceType'];
      final String? deviceName = row['deviceName'];
      return Case(boxNumber, deviceType, deviceName ?? '');
    }).toList();

    emit(_getColumnState2(cases));
  }

  Future<void> _mapDeleteBoxEventToState(
      DeleteBoxEvent event, Emitter<ColumnState2> emit) async {
    await _database.delete('malak',
        where: 'boxNumber = ?', whereArgs: [event.boxNumber]);

    final List<Map<String, dynamic>> rows = await _database.query('malak');
    final List<Case> cases = rows.map((row) {
      final int boxNumber = row['boxNumber'];
      final String deviceType = row['deviceType'];
      final String? deviceName = row['deviceName'];
      return Case(boxNumber, deviceType, deviceName ?? '');
    }).toList();
    emit(_getColumnState2(cases));
  }

  ColumnState2 _getColumnState2(List<Case> cases) {
    final List<Case> ColumnData2 = [];
    for (int i = 0; i < cases.length; i++) {
      ColumnData2.add(cases[i]);
    }

    return ColumnState2(ColumnData2);
  }

  List<Case> get cases => state.ColumnData2;

  int countCases() {
    return cases.length;
  }
}

class MyWidget extends StatelessWidget {
  final bool showButtons;

  MyWidget({
    Key? key,
    required this.showButtons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ColumnBloc2(),
      child: BlocBuilder<ColumnBloc2, ColumnState2>(
        builder: (context, state) {
          final ColumnData2 = state.ColumnData2;

          return Column(
            children: [
              if (showButtons)
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<ColumnBloc2>(context)
                        .add(LoadInitialDataEvent2());
                  },
                  child: Text('Actualiser'),
                ),
              const SizedBox(height: 20),
              SizedBox(width: MediaQuery.of(context).size.width * 0.065),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: ColumnData2
                    .map<Widget>((u) {
                      return SceneBox(
                        deviceName: u.deviceName,
                        //isChecked: true,
                      );
                    })
                    .toList(),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.07),
              ElevatedButton(
                onPressed: () {
                  final columnBloc2 = BlocProvider.of<ColumnBloc2>(context);
                  columnBloc2.add(AddBoxEvent2(1, 'malk', 'tv'));
                  columnBloc2.add(LoadInitialDataEvent2());
                },
                child: Text('Ajouter une case'),
              ),
              const SizedBox(height: 200),
            ],
          );
        },
      ),
    );
  }
}

class Insert3 extends StatefulWidget {
  final bool showButtons;
  final int maxBoxesToShow;
  final int maxBoxesPerColumn1;
  final int maxBoxesPerColumn2;

  Insert3({
    Key? key,
    this.showButtons = true,
    this.maxBoxesToShow = 999,
    this.maxBoxesPerColumn1 = 9999,
    this.maxBoxesPerColumn2 = 9999,
  }) : super(key: key);

  @override
  _InsertState createState() => _InsertState();
}

class _InsertState extends State<Insert3> {
  String deviceName = 'malak';
  String pairedDevice = '';
  String deviceType = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyWidget(
          showButtons: true,
        ),
      ],
    );
  }
}