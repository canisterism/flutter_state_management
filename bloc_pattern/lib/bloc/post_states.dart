import 'package:bloc_pattern/models/post.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostFailure extends PostState {}

class PostSuccess extends PostState {
  PostSuccess({
    @required this.posts,
    @required this.hasReachedMax,
  });

  final List<Post> posts;
  final bool hasReachedMax;

  PostSuccess copyWith({List<Post> posts, bool hasReachedMax}) => PostSuccess(
        posts: posts ?? this.posts,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      );

  @override
  List<Object> get props => [posts, hasReachedMax];
}
