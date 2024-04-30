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
  //final int maxBoxesToShow;
  //final int maxBoxesPerColumn1;
  //final int maxBoxesPerColumn2;
  

  MyWidgetContent({
    Key? key,
    required this.showButtons,
    //required this.maxBoxesToShow,
    //required this.maxBoxesPerColumn1,
   // required this.maxBoxesPerColumn2,
   
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
                        return SceneDevice(deviceName:  box.deviceName,isChecked:true);
                        
                      } else {
                        return SceneDevice(deviceName:  box.deviceName,isChecked:true);
                         
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
                        return SceneDevice(deviceName:  box.deviceName,isChecked:true);
                       
                      } else {
                        return SceneDevice(deviceName:  box.deviceName,isChecked:true);
                         
                      }
                    })
                        .toList(),
                  ),
                ],
              ),
            /*   ElevatedButton(
  onPressed: () {
    final columnBloc = BlocProvider.of<ColumnBloc>(context);
    columnBloc.add(AddBoxEvent(1, 'malk', 'tv', 'on'));
    columnBloc.add(LoadInitialDataEvent()); // Rafraîchir les données après l'ajout
  },
  child: Text('Ajouter une case'),
),*/
              const SizedBox(height: 200),
            ],
          );
        },
      ),
    );
  }
}

class Insert2 extends StatefulWidget {
  final bool showButtons;
  final int maxBoxesToShow;
  final int maxBoxesPerColumn1;
  final int maxBoxesPerColumn2;

  Insert2({
    Key? key,
    this.showButtons = true,
    this.maxBoxesToShow = 999,
    this.maxBoxesPerColumn1 = 9999,
    this.maxBoxesPerColumn2 = 9999,
  }) : super(key: key);

  @override
  _InsertState createState() => _InsertState();
}

class _InsertState extends State<Insert2> {
  String deviceName = 'malak';
  String pairedDevice = '';
  String deviceType = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyWidgetContent(showButtons: true,),
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

