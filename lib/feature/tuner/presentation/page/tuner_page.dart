import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertuner/feature/tuner/cubit/pitch_cubit.dart';

class TunerPage extends StatelessWidget {
  const TunerPage({super.key});

  static const path = '/tuner';

  @override
  Widget build(BuildContext context) {
    final pitchCubitState = context.watch<PitchCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterTune',
            style: TextStyle(
                fontSize: 34,
                fontWeight:
                    FontWeight.lerp(FontWeight.w700, FontWeight.w500, 0.5))),
      ),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text(
                          'Гитара',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.lerp(
                                  FontWeight.w700, FontWeight.w500, 0.5)),
                        ),
                        //TODO Заменить иконку потом на DropDownMenu
                        const Icon(Icons.arrow_drop_down),
                        const SizedBox(
                          width: 100,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text(
                          'Авто',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.lerp(
                                  FontWeight.w700, FontWeight.w500, 0.5)),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        //TODO подключить свитч к смене режима авто/ручной
                        const Switch(
                          value: true,
                          onChanged: ValueKey.new,
                          activeTrackColor: Colors.black,
                        )
                      ],
                    ),
                  )
                ],
              ),
              //TODO Вместо sizedbox надо будет поместить виджет со шкалой и стрелку
              const SizedBox(
                height: 300,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      pitchCubitState.note,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 65.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      pitchCubitState.status,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black),
                        child: IconButton(
                          disabledColor: Colors.white,
                          padding: const EdgeInsets.all(30),
                          color: Colors.black,
                          onPressed: () {},
                          icon: const Text(
                            'D',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black),
                        child: IconButton(
                          disabledColor: Colors.white,
                          padding: const EdgeInsets.all(30),
                          color: Colors.white,
                          onPressed: () {},
                          icon: const Text(
                            'A',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black),
                        child: IconButton(
                          disabledColor: Colors.white,
                          padding: const EdgeInsets.all(30),
                          color: Colors.white,
                          onPressed: () {},
                          icon: const Text(
                            'E',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 150,
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black),
                        child: IconButton(
                          disabledColor: Colors.white,
                          padding: const EdgeInsets.all(30),
                          color: Colors.white,
                          onPressed: () {},
                          icon: const Text(
                            'G',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black),
                        child: IconButton(
                          disabledColor: Colors.white,
                          padding: const EdgeInsets.all(30),
                          color: Colors.white,
                          onPressed: () {},
                          icon: const Text(
                            'B',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black),
                        child: IconButton(
                          disabledColor: Colors.white,
                          padding: const EdgeInsets.all(30),
                          color: Colors.white,
                          onPressed: () {},
                          icon: const Text(
                            'E',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
