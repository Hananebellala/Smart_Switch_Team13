import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/box_lampe.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
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
  ColumnBloc() : super(ColumnState([], [])) {
    on<AddBoxEvent>(_mapAddBoxEventToState);
  }

  void _mapAddBoxEventToState(AddBoxEvent event, Emitter<ColumnState> emit) {
    final currentState = state;
    final List<int> firstColumnData = List.from(currentState.firstColumnData);
    final List<int> secondColumnData = List.from(currentState.secondColumnData);

    if (firstColumnData.length <= secondColumnData.length) {
      firstColumnData.add(event.newBoxNumber);
    } else {
      secondColumnData.add(event.newBoxNumber);
    }

    emit(ColumnState(firstColumnData, secondColumnData));
    _saveBoxData([...firstColumnData, ...secondColumnData]);
  }

  @override
  Stream<ColumnState> mapEventToState(ColumnEvent event) async* {
    if (event is LoadColumnDataEvent) {
      yield ColumnState(event.firstColumnData, event.secondColumnData);
    }
  }

  Future<void> _saveBoxData(List<int> boxData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'boxData', boxData.map((e) => e.toString()).toList());
  }
}

class Insert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ColumnBloc(),
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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _columnBloc = BlocProvider.of<ColumnBloc>(context);
    _loadColumnData();
  }

  Future<void> _loadColumnData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<int> firstColumnData =
        prefs.getStringList('firstColumnData')?.map(int.parse).toList() ?? [];
    final List<int> secondColumnData =
        prefs.getStringList('secondColumnData')?.map(int.parse).toList() ?? [];

    if (firstColumnData.isNotEmpty || secondColumnData.isNotEmpty) {
      _columnBloc.add(LoadColumnDataEvent(firstColumnData, secondColumnData));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ColumnBloc, ColumnState>(
      listener: (context, state) {
        _saveColumnData(state.firstColumnData, state.secondColumnData);
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