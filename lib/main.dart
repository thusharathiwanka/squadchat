import 'package:flutter/material.dart';
import 'package:squadchat/composition_root.dart';
import 'package:squadchat/theme.dart';
import 'package:squadchat/views/screens/splash/Splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CompositionRoot.configure();
  final firstPage =
      _AppState.fetchLocalUser() ? CompositionRoot.start() : const Splash();
  runApp(App(firstPage));
}

class App extends StatefulWidget {
  final Widget firstPage;

  App(this.firstPage);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (!fetchLocalUser()) {
      return;
    }

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;

    final isNotActive = state == AppLifecycleState.paused;
    final isResumed = state == AppLifecycleState.resumed;

    if (isNotActive) CompositionRoot.disconnectUser();
    if (isResumed) CompositionRoot.reconnectUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Squadchat',
        theme: lightTheme(context),
        darkTheme: darkTheme(context),
        home: widget.firstPage);
  }

  static bool fetchLocalUser() {
    return CompositionRoot().localCache.fetch('USER').isNotEmpty;
  }
}
