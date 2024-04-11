import 'package:dartssh2/dartssh2.dart';
import 'package:dartssh2/src/socket/ssh_socket.dart';

import '../../domain/repositories/SSHRepository.dart';

class SSHRepositoryImpl implements SSHRepository {
  final SSHClient? _client;
  SSHRepositoryImpl(this._client);

  @override
  Future<SSHSocket> connectToLG(String ip, int port, String username, String password) async {
    try {
      final socket = await SSHSocket.connect(ip, port, timeout: const Duration(seconds: 5));
      print('Connected to $ip:$port');
      return socket;
    } catch (e) {
      throw Exception('Failed to connect: $e');
    }
  }

  @override
  Future<SSHSession?> locatePlace(String place) async {
    try {
      if (_client == null) {
        print('SSH client is not initialized.');
        return null;
      }
      final session = await _client!.execute('echo "search=$place" >/tmp/query.txt');
      return session;
    } catch (e) {
      print('An error occurred while executing the command: $e');
      return null;
    }
  }
}