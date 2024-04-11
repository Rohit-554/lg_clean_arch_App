import 'package:dartssh2/dartssh2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lg_controller_clean_arch/lg_controller/domain/usecase/ConnectToLGUsecase.dart';

import '../../data/repositories/SSHRepositoriesImpl.dart';
import '../../domain/usecase/locatePlaceUseCase.dart';

connectToLGUsecaseProvider(SSHClient) => Provider<ConnectToLGUseCase>((ref) {
  final sshRepository = SSHRepositoryImpl(SSHClient);
  return ConnectToLGUseCase(sshRepository);
});

locatePlaceUseCaseProvider(SSHClient) => Provider<LocatePlaceUseCase>((ref) {
  final sshRepository = SSHRepositoryImpl(SSHClient);
  return LocatePlaceUseCase(sshRepository);
});

StateProvider<bool> connectedProvider = StateProvider((ref) => false);
StateProvider<SSHClient?> sshClientProvider = StateProvider((ref) => null);