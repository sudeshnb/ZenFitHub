import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_fit_hub/src/core/constants/database.dart';
import 'package:zen_fit_hub/src/core/network/connection.lost.dart';
import 'package:zen_fit_hub/src/features/home/data/models/exercise.dart';
import 'package:zen_fit_hub/src/features/home/presentation/widgets/exercisecard.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OfflineBuilder(
        connectivityBuilder: (context, connectivity, child) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return const _ExerciseList();
          }
          return const ConnectionLostScreen();
        },
        child: const SizedBox(),
      ),
    );
  }
}

class _ExerciseList extends StatelessWidget {
  const _ExerciseList();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: AppDB.exercise.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(20.w),
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ExercisecardItemWidget(ExerciseModel.fromMap(data));
          }).toList(),
        );
      },
    );
  }
}
