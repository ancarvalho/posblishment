import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../data_source/settings_data_source.dart';
import '../domain/entities/establishment_settings.dart';

class SettingsRepository {
  final SettingsDataSource settingsDataSource;

  SettingsRepository(this.settingsDataSource);

  Future<Either<Failure, int>> updateEstablishmentSettings(NewEstablishmentSettings newEstablishmentSettings) async {
    try {
      final result = await settingsDataSource
          .updateEstablishmentSettings(newEstablishmentSettings);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  Future<Either<Failure, EstablishmentSettings>> getSettings() async {
    try {
      final result = await settingsDataSource.getSettings();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  Future<Either<Failure, int>> createEstablishment(NewEstablishmentSettings newEstablishmentSettings) async {
    try {
      final result = await settingsDataSource.createEstablishment(newEstablishmentSettings);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

   Future<Either<Failure, bool>> checkIfSettingsExist() async {
    try {
      final result = await settingsDataSource.checkIfSettingsExist();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
   }
}
