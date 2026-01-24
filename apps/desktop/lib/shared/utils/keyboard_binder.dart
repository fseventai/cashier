import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyboardBinder extends StatelessWidget {
  final Widget child;
  final Map<LogicalKeyboardKey, VoidCallback> bindings;

  const KeyboardBinder({
    super.key,
    required this.child,
    required this.bindings,
  });

  @override
  Widget build(BuildContext context) {
    // Mapping keys ke Intents secara dinamis
    final shortcuts = <ShortcutActivator, Intent>{};
    final actions = <Type, Action<Intent>>{};

    // Kita buat list unik untuk setiap key agar tidak bentrok
    for (var entry in bindings.entries) {
      final intent = _SingleCallbackIntent(entry.value);
      shortcuts[SingleActivator(entry.key)] = intent;
      actions[_SingleCallbackIntent] = CallbackAction<_SingleCallbackIntent>(
        onInvoke: (intent) => intent.callback(),
      );
    }

    return Shortcuts(
      shortcuts: shortcuts,
      child: Actions(
        actions: actions,
        child: Focus(autofocus: true, child: child),
      ),
    );
  }
}

class _SingleCallbackIntent extends Intent {
  final VoidCallback callback;
  const _SingleCallbackIntent(this.callback);
}
