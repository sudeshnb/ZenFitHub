import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:zen_fit_hub/src/core/constants/database.dart';
import 'package:zen_fit_hub/src/core/error/functions.dart';
import 'package:zen_fit_hub/src/core/network/network_info.dart';

import '../models/model.dart';

class OnboardLocalSource {
  EitherString<List<OnBoardModel>> getOnBoardData() async {
    try {
      List<OnBoardModel> list = [];
      if (await NetworkInfo.isConnected) {
        await AppDB.onboard.get().then((QuerySnapshot querySnapshot) {
          for (var doc in querySnapshot.docs) {
            Map<String, dynamic> json = doc.data() as Map<String, dynamic>;

            list.add(OnBoardModel.fromMap(json));
          }
        });
        return Left(list);
      }
      return const Right('Please check your internet connection and try.');
    } catch (e) {
      return const Right('Somethings went wrong.');
    }
  }
}
