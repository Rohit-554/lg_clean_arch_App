import 'package:dartssh2/dartssh2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/SSHRepository.dart';

class ConnectToLGUseCase {
  final  SSHRepository _repository;
  ConnectToLGUseCase(this._repository);

  Future<SSHSocket?> connect(String ip, int port, String username, String password) async {
    try {
      final socket = await _repository.connectToLG(ip, port, username, password);
      return socket;
    } catch (e) {
      print('Failed to connect: $e');
      throw Exception('Failed to connect: $e');
    }
  }


}