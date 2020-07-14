import 'dart:io';

import 'package:bloc_pattern/bloc/bloc.dart';
import 'package:bloc_pattern/bloc/post_bloc.dart';
import 'package:bloc_pattern/bloc/post_events.dart';
import 'package:bloc_pattern/widget/bottom_loader.dart';
import 'package:bloc_pattern/widget/post_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart';
import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }
}

void main() {
  EquatableConfig.stringify = true;
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('InfiniteListViewScreen'),
        ),
        body: BlocProvider(
          create: (_context) =>
              PostBloc(httpClient: Client())..add(PostFetchStart()),
          child: InfiniteListViewScreen(),
        ),
      ),
    );
  }
}

class InfiniteListViewScreen extends StatefulWidget {
  InfiniteListViewScreen({Key key}) : super(key: key);

  @override
  _InfiniteListViewScreenState createState() => _InfiniteListViewScreenState();
}

class _InfiniteListViewScreenState extends State<InfiniteListViewScreen> {
  final _scrollController = ScrollController();
  final _scrollThreshould = 200;
  PostBloc _postBloc;

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshould) {
      _postBloc.add(PostFetchStart());
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = BlocProvider.of<PostBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      // Use if statement, not switch because `if (state is T)` works as type guard.
      // I prefer to use switch statement, but type guard doesn't work with it.
      if (state is PostInitial)
        return Center(
          child: CircularProgressIndicator(),
        );
      else if (state is PostSuccess) {
        if (state.posts.isEmpty) {
          return Center(
            child: Text('no posts'),
          );
        } else {
          return ListView.builder(
              itemBuilder: (context, index) {
                return index >= state.posts.length
                    ? BottomLoader()
                    : PostWidget(post: state.posts[index]);
              },
              itemCount: state.posts.length);
        }
      } else {
        // PostFailed
        return Center(child: Text('failed to fetch posts'));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
