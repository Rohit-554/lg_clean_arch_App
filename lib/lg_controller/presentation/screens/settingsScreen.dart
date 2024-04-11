// presentation/screens/settings_screen.dart

import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lg_controller_clean_arch/lg_controller/domain/usecase/locatePlaceUseCase.dart';

import '../providers/ssh_providers.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ipController = TextEditingController();
  TextEditingController portController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    var isConnected = ref.watch(connectedProvider);
    print("isConnected:" + isConnected.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.connected_tv,
              color: isConnected ? Colors.green : Colors.red,
            ),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => SettingsScreen()),
              // );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: ipController,
              decoration: InputDecoration(
                labelText: 'IP Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: portController,
              decoration: InputDecoration(
                labelText: 'Port',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: ()  {
               _connectToLg(context);

              },
              child: Text('Connect'),
            ),
            ElevatedButton(
              onPressed: ()  {
                _locatePlace("Mumbai");
              },
              child: Text('Show Place on map'),
            ),
          ],
        ),
      ),
    );
  }

  _connectToLg (BuildContext context) async{
    final connectToLGUsecase = ref.read(connectToLGUsecaseProvider(ref.read(sshClientProvider)));
    var socket  = await connectToLGUsecase.connect(ipController.text,int.parse(portController.text), usernameController.text, passwordController.text);
    if (socket!=null) {
      ref.read(sshClientProvider.notifier).state = SSHClient(socket, username:usernameController.text, onPasswordRequest: () =>passwordController.text);
      ref.read(connectedProvider.notifier).state = true;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Connected to LG'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // Connection failed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to connect'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  _locatePlace(String place) async {
    final locatePlaceUsecase = ref.read(locatePlaceUseCaseProvider(ref.read(sshClientProvider)));
    var session = await locatePlaceUsecase.locatePlace(place);
    if (session != null) {
      print(session.stdout);
    } else {
      print('Session is null');
    }
  }


}
