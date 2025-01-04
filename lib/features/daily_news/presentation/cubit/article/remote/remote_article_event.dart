import 'package:equatable/equatable.dart';

/// Abstract class representing all possible events related to Articles.
abstract class RemoteArticlesEvent extends Equatable {
  const RemoteArticlesEvent();

  @override
  List<Object?> get props => [];
}

/// Event to fetch articles.
class GetArticles extends RemoteArticlesEvent {
  const GetArticles();
}
