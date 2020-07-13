import 'package:bloc_pattern/bloc/flash_number_provider.dart';
import 'package:flutter/material.dart';

class FlashNumberScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlashNumberProvider(
      child: Builder(
        builder: (context) {
          final bloc = FlashNumberProvider.of(context).bloc;

          return Scaffold(
            appBar: AppBar(
              title: Text('FlashNumberBloc'),
            ),
            body: Center(
              child: StreamBuilder(
                stream: bloc.onAdd,
                builder: (context, snapShot) => Text(
                  snapShot.hasData ? snapShot.data : 'N/A',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
            floatingActionButton: StreamBuilder<bool>(
              stream: bloc.onToggle,
              builder: (context, snapshot) {
                return Opacity(
                  opacity: snapshot.hasData && snapshot.data ? 1.0 : 0.3,
                  child: FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      bloc.start.add(null);
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
