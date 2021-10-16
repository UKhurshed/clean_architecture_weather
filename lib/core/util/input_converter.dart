import 'package:clean_architecture_weather/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class InputConverter {
  Either<Failure, String> checkInputStr(String query) {
    try {
      final alphabets = RegExp(r'^[a-zA-Z]+$');
      if (alphabets.hasMatch(query)) {
        return Right(query);
      } else {
        throw const FormatException();
      }
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
