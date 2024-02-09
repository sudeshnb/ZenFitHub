import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_fit_hub/src/core/constants/database.dart';
import 'package:zen_fit_hub/src/core/network/connection.lost.dart';
import 'package:zen_fit_hub/src/features/home/data/models/models.dart';
import '../widgets/recipecard.dart';

class MealplanPage extends StatelessWidget {
  const MealplanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OfflineBuilder(
        connectivityBuilder: (context, connectivity, child) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return const _MealplanList();
          }
          return const ConnectionLostScreen();
        },
        child: const SizedBox(),
      ),
    );
  }
}

class _MealplanList extends StatelessWidget {
  const _MealplanList();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: AppDB.meals.snapshots(),
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
            return RecipecardItemWidget(MealModel.fromMap(data));
          }).toList(),
        );
      },
    );
  }
}
