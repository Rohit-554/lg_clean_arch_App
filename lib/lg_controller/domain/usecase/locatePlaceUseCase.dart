import 'package:dartssh2/dartssh2.dart';

import '../repositories/SSHRepository.dart';

class LocatePlaceUseCase {
  final  SSHRepository _repository;

  LocatePlaceUseCase(this._repository);

  Future<SSHSession?> locatePlace(String place) async {
    try {
      final session = await _repository.locatePlace(place);
      return session;
    } catch (e) {
      print('An error occurred while executing the command: $e');
      return null;
    }
  }

}