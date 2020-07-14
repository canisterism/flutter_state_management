import 'dart:convert';

import 'package:bloc_pattern/bloc/bloc.dart';
import 'package:bloc_pattern/bloc/post_events.dart';
import 'package:bloc_pattern/models/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// behave just like reducer in redux.
// newState = f(currentState, event)
class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBloc({@required this.httpClient}) : super(PostInitial());

  // this function is called before mapEventToState called, in order to apply some operation.
  @override
  Stream<Transition<PostEvent, PostState>> transformEvents(
    Stream<PostEvent> events,
    TransitionFunction<PostEvent, PostState> transitionFn,
  ) {
    return super.transformEvents(
        events.debounceTime(const Duration(milliseconds: 500)), transitionFn);
  }

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is PostFetchStart && !_hasReachedMax(state)) {
      try {
        switch (state.runtimeType) {
          case PostInitial:
            final posts = await _fetchPosts(0, 20);
            yield (PostSuccess(posts: posts, hasReachedMax: false));
            break;
          case PostSuccess:
            final currentState = (state as PostSuccess);
            final posts = await _fetchPosts(currentState.posts.length, 20);
            yield posts.isEmpty
                ? currentState.copyWith(
                    hasReachedMax: false,
                  )
                : currentState.copyWith(
                    posts: [
                      ...currentState.posts,
                      ...posts,
                    ],
                  );
            break;
          default:
            yield state;
            break;
        }
      } catch (e) {
        yield PostFailure();
      }
    }
  }

  bool _hasReachedMax(PostState state) =>
      state is PostSuccess && state.hasReachedMax;

  Future<List<Post>> _fetchPosts(int startIndex, int limit) async {
    final response = await httpClient.get(
        'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data
          .map(
            (rawJson) => Post(
                id: rawJson['id'],
                title: rawJson['title'] as String,
                body: rawJson['body'] as String),
          )
          .toList();
    } else {
      throw Exception('error fetching posts');
    }
  }
}
