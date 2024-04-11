import 'package:dartssh2/dartssh2.dart';

abstract class SSHRepository {
  Future<SSHSocket> connectToLG(String ip, int port, String username, String password);
  Future<SSHSession?> locatePlace(String place);
}