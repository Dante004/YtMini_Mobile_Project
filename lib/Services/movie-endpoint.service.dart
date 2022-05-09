import 'dart:_http';
import 'dart:convert';
import 'dart:ffi';
import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:inject/inject.dart';
import 'package:ytmini/Models/Requests/add-movie-request.model.dart';
import 'package:ytmini/app-settings.dart';

import '../Models/movie.model.dart';

@provide
@singleton
class MovieEndpointService {

    String get movieUrl {
        return AppSettings.apiUrl + "/api/movies/";
    }

    Future<List<Movie>> getMovies() async {
        var response = await http.get(Uri.parse(movieUrl),
            headers: {HttpHeaders.authorizationHeader: AppSettings.accessToken});

        if(response.statusCode == 200) {
            List<Movie> movies = json.decode(response.body);
            return movies;
        }
        else {
            throw Exception("Failed to load movies");
        }
    }

    Future<List<Movie>> getAllMovies() async {
        var response = await http.get(Uri.parse(movieUrl+'all'),
            headers: {HttpHeaders.authorizationHeader: AppSettings.accessToken});

        if(response.statusCode == 200) {
            List<Movie> movies = json.decode(response.body);
            return movies;
        }
        else {
            throw Exception("Failed to load movies");
        }
    }

    Future<Movie> getMovie(int id) async {
        var response = await http.get(Uri.parse(movieUrl+id.toString()),
            headers: {HttpHeaders.authorizationHeader: AppSettings.accessToken});

        if(response.statusCode == 200) {
            return Movie.fromJson(jsonDecode(response.body));
        }
        else {
            throw Exception("Failed to load movie");
        }
    }

    Future addMovie(AddMovieRequest addMovieRequest) async{
        final bytes = await addMovieRequest.movie.readAsBytes();

        var postUri = Uri.parse(movieUrl+'add');
        var request = new http.MultipartRequest("POST", postUri);
        request.fields['title'] = addMovieRequest.title;
        request.fields['author'] = addMovieRequest.author;
        request.files.add(http.MultipartFile.fromBytes(bytes));
    }
    
    Future editMovie(int id, dynamic request) async {
        var response = await http.post(Uri.parse(movieUrl+id.toString()+'edit'),
            body: jsonEncode(request),
            headers: {HttpHeaders.authorizationHeader: AppSettings.accessToken});

        if(response.statusCode != 200) {
            throw Exception("Failed to edit movie");
        }
    }

    Future removeMovie(int id) async {
        var response = await http.delete(Uri.parse(movieUrl+id.toString()+'/delete'),
            headers: {HttpHeaders.authorizationHeader: AppSettings.accessToken});

        if(response.statusCode != 200) {
            throw Exception("Failed to remove movie");
        }
    }
}