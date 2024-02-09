import 'package:dartz/dartz.dart';

import 'failures.dart';

typedef EitherData<T> = Future<Either<T, Failure>>;

typedef EitherString<T> = Future<Either<T, String>>;
