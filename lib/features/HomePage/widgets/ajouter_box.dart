import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/box_lampe.dart';
/*
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late List<int> firstColumnData;
  late List<int> secondColumnData;

  @override
  void initState() {
    super.initState();
    loadColumnData();
  }

  Future<void> loadColumnData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstColumnData =
          prefs.getStringList('firstColumnData')?.map(int.parse).toList() ?? [];
      secondColumnData =
          prefs.getStringList('secondColumnData')?.map(int.parse).toList() ?? [];
    });
  }

  Future<void> saveColumnData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'firstColumnData', firstColumnData.map((e) => e.toString()).toList());
    await prefs.setStringList(
        'secondColumnData', secondColumnData.map((e) => e.toString()).toList());
  }

  void addBoxOnClick() {
    setState(() {
      int newBoxNumber = firstColumnData.length + secondColumnData.length + 1;
      if (firstColumnData.length <= secondColumnData.length) {
        firstColumnData.add(newBoxNumber);
      } else {
        secondColumnData.add(newBoxNumber);
      }
      saveColumnData();
      loadColumnData(); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.065),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: firstColumnData.map((boxNumber) {
                return Box_lampe();
              }).toList(),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.07),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: secondColumnData.map((boxNumber) {
                return Box_lampe();
              }).toList(),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: addBoxOnClick,
          child: const Text('Ajouter une boîte'),
        ),
      ],
    );
  }
}
*/
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
/*
abstract class ColumnEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddBoxEvent extends ColumnEvent {
  final int newBoxNumber;

  AddBoxEvent(this.newBoxNumber);

  @override
  List<Object?> get props => [newBoxNumber];
}

class ColumnState extends Equatable {
  final List<int> firstColumnData;
  final List<int> secondColumnData;

  ColumnState(this.firstColumnData, this.secondColumnData);

  @override
  List<Object?> get props => [firstColumnData, secondColumnData];
}///////////////////////////////////////////////////
class ColumnBloc extends Bloc<ColumnEvent, ColumnState> {
  ColumnBloc() : super(ColumnState([], []));

  @override
  Stream<ColumnState> mapEventToState(ColumnEvent event) async* {
    if (event is AddBoxEvent) {
      yield _addBoxToColumnState(event.newBoxNumber);
    }
  }

  ColumnState _addBoxToColumnState(int newBoxNumber) {
    final currentState = state;
    final List<int> firstColumnData = List.from(currentState.firstColumnData);
    final List<int> secondColumnData = List.from(currentState.secondColumnData);
    
    if (firstColumnData.length <= secondColumnData.length) {
      firstColumnData.add(newBoxNumber);
    } else {
      secondColumnData.add(newBoxNumber);
    }

    return ColumnState(firstColumnData, secondColumnData);
  }
}///////////////////////////////////////////////////////////
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ColumnBloc(),
      child: MyWidgetContent(),
    );
  }
}

class MyWidgetContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ColumnBloc columnBloc = BlocProvider.of<ColumnBloc>(context);

    return BlocBuilder<ColumnBloc, ColumnState>(
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.065),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: state.firstColumnData.map((boxNumber) {
                    return Box_lampe();
                  }).toList(),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.07),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: state.secondColumnData.map((boxNumber) {
                    return Box_lampe();
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newBoxNumber = state.firstColumnData.length + state.secondColumnData.length + 1;
                columnBloc.add(AddBoxEvent(newBoxNumber));
              },
              child: const Text('Ajouter une boîte'),
            ),
          ],
        );
      },
    );
  }
}
*/
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';

// Définition des événements et de l'état du bloc

abstract class ColumnEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddBoxEvent extends ColumnEvent {
  final int newBoxNumber;

  AddBoxEvent(this.newBoxNumber);

  @override
  List<Object?> get props => [newBoxNumber];
}

class LoadColumnDataEvent extends ColumnEvent {
  final List<int> firstColumnData;
  final List<int> secondColumnData;

  LoadColumnDataEvent(this.firstColumnData, this.secondColumnData);

  @override
  List<Object?> get props => [firstColumnData, secondColumnData];
}

class ColumnState extends Equatable {
  final List<int> firstColumnData;
  final List<int> secondColumnData;

  ColumnState(this.firstColumnData, this.secondColumnData);

  @override
  List<Object?> get props => [firstColumnData, secondColumnData];
}

class ColumnBloc extends Bloc<ColumnEvent, ColumnState> {
  ColumnBloc() : super(ColumnState([], []));

  @override
  Stream<ColumnState> mapEventToState(ColumnEvent event) async* {
    if (event is AddBoxEvent) {
      yield _addBoxToColumnState(event.newBoxNumber);
    } else if (event is LoadColumnDataEvent) {
      yield ColumnState(event.firstColumnData, event.secondColumnData);
    }
  }

  ColumnState _addBoxToColumnState(int newBoxNumber) {
    final currentState = state;
    final List<int> firstColumnData = List.from(currentState.firstColumnData);
    final List<int> secondColumnData = List.from(currentState.secondColumnData);
    
    if (firstColumnData.length <= secondColumnData.length) {
      firstColumnData.add(newBoxNumber);
    } else {
      secondColumnData.add(newBoxNumber);
    }

    return ColumnState(firstColumnData, secondColumnData);
  }
}

class insert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ColumnBloc()..add(LoadColumnDataEvent([], [])), // **
      child: MyWidgetContent(),
    );
  }
}

class MyWidgetContent extends StatefulWidget {
  @override
  _MyWidgetContentState createState() => _MyWidgetContentState();
}

class _MyWidgetContentState extends State<MyWidgetContent> {
  late ColumnBloc _columnBloc;

  @override
  void initState() {
    super.initState();
    _columnBloc = BlocProvider.of<ColumnBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadColumnData(); // **
  }
/*
  Future<void> _loadColumnData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<int> firstColumnData =
        prefs.getStringList('firstColumnData')?.map(int.parse).toList() ?? [];
    final List<int> secondColumnData =
        prefs.getStringList('secondColumnData')?.map(int.parse).toList() ?? [];
    _columnBloc.add(LoadColumnDataEvent(firstColumnData, secondColumnData)); // **
  }
*/
Future<void> _loadColumnData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final List<int> firstColumnData =
      prefs.getStringList('firstColumnData')?.map(int.parse).toList() ?? [];
  final List<int> secondColumnData =
      prefs.getStringList('secondColumnData')?.map(int.parse).toList() ?? [];
  
  // Vérifier si des données existent déjà avant de les charger
  if (firstColumnData.isNotEmpty || secondColumnData.isNotEmpty) {
    _columnBloc.add(LoadColumnDataEvent(firstColumnData, secondColumnData)); // **
  }
}
  @override
  Widget build(BuildContext context) {
    return BlocListener<ColumnBloc, ColumnState>(
      listener: (context, state) {
        _saveColumnData(state.firstColumnData, state.secondColumnData); // **
      },
      child: BlocBuilder<ColumnBloc, ColumnState>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.065),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: state.firstColumnData.map((boxNumber) {
                      return Box_lampe();
                    }).toList(),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.07),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: state.secondColumnData.map((boxNumber) {
                      return Box_lampe();
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final newBoxNumber = state.firstColumnData.length +
                      state.secondColumnData.length +
                      1;
                  _columnBloc.add(AddBoxEvent(newBoxNumber));
                },
                child: const Text('Ajouter une boîte'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _saveColumnData(List<int> firstColumnData, List<int> secondColumnData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'firstColumnData', firstColumnData.map((e) => e.toString()).toList());
    await prefs.setStringList(
        'secondColumnData', secondColumnData.map((e) => e.toString()).toList());
  }
}
