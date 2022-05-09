import 'dart:ffi';

import 'dart:io';
import 'dart:typed_data';

class AddMovieRequest {
  final String author;
  final String title;
  final File movie;

  const AddMovieRequest({
    required this.author,
    required this.title,
    required this.movie
  });

  factory AddMovieRequest.create(String author, String title, File movie) {
    return AddMovieRequest(author: author, title: title, movie: movie);
  }
}