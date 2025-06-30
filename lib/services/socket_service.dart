import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:aquanet_mobile/config/url_config.dart' as urlConfig;

class SocketService {
  late IO.Socket socket;

  void connect({
    required Function(String) onMessage,
    required Function(String) onAlert,
  }) {
    socket = IO.io(
      "${urlConfig.url}/socket",
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      print("✅ Connected to server");
    });

    socket.on('data', (data) {
      print("Socket data : $data");
      onMessage(data.toString());
    });

    socket.on('limitAlert', (data) {
      print("Alert data : $data");
      onAlert(data.toString());
    });

    socket.onDisconnect((_) => print("❌ Disconnected"));
  }

  void sendMessage(String msg) {
    socket.emit('message', msg);
  }

  void disconnect() {
    socket.disconnect();
  }
}
