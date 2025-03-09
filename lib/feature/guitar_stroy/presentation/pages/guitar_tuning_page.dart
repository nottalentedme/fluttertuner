//Страница, на которой отображается информация о текущем строе,
// а также элементы управления для изменения настроек

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/guitar_stroy/domain/repositories/i_guitar_tuning_repository.dart';
import 'package:fluttertuner/feature/guitar_stroy/presentation/bloc/guitar_tuning_bloc.dart';
import 'package:fluttertuner/feature/guitar_stroy/presentation/bloc/guitar_tuning_event.dart';
import 'package:fluttertuner/feature/guitar_stroy/presentation/bloc/guitar_tuning_state.dart';

class GuitarTuningPage extends StatelessWidget {
  final IGuitarTuningRepository repository;

  GuitarTuningPage({required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GuitarTuningBloc(repository),
      child: Scaffold(
        appBar: AppBar(title: Text('Гитарный Тюнер')),
        body: BlocBuilder<GuitarTuningBloc, GuitarTuningState>(
          builder: (context, state) {
            if (state is GuitarTuningLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GuitarTuningActive) {
              return Center(
                child: Text('Текущий строй: ${(', ')}'),
              );
            } else if (state is GuitarTuningError) {
              return Center(child: Text(state.error as String));
            } else {
              return Center(child: Text('Ошибка'));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            BlocProvider.of<GuitarTuningBloc>(context)
                .add(ChangeTuningEvents(1)); // Изменяем строй
          },
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }
}
