import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/trailer_model.dart';
import '../blocs/movie_detail_bloc.dart';

class MovieDetail extends StatefulWidget {
  final String title;
  final String posterUrl;
  final String description;
  final String releaseDate;
  final String voteAverage;
  final int movieId;

  const MovieDetail({
    Key? key,
    required this.title,
    required this.posterUrl,
    required this.description,
    required this.releaseDate,
    required this.voteAverage,
    required this.movieId,
  }) : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  late final MovieDetailBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<MovieDetailBloc>();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (ctx, innerBoxIsScrolled) => <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(widget.title),
                background: Image.network(
                  'https://image.tmdb.org/t/p/w500${widget.posterUrl}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    const Icon(Icons.favorite, color: Colors.red),
                    const SizedBox(width: 4),
                    Text(
                      widget.voteAverage,
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      widget.releaseDate,
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  widget.description,
                  style: const TextStyle(fontSize: 16.0),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Trailers',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                SizedBox(
                  height: 120,
                  child: BlocBuilder<MovieDetailBloc, Future<TrailerModel>>(
                    builder: (context, futureTrailer) {
                      // 'futureTrailer' is the cubit’s state, i.e. a Future<TrailerModel>
                      return FutureBuilder<TrailerModel>(
                        future: futureTrailer,
                        builder: (ctx, itemSnap) {
                          if (itemSnap.hasError) {
                            return const Center(
                              child: Text(
                                'Error loading trailers',
                                style: TextStyle(color: Colors.red),
                              ),
                            );
                          }
                          if (itemSnap.hasData) {
                            final data = itemSnap.data!;
                            if (data.results.isNotEmpty) {
                              return _buildTrailerRow(data);
                            } else {
                              return const Center(child: Text('No trailers available'));
                            }
                          }
                          return const Center(child: CircularProgressIndicator());
                        },
                      );
                    },
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrailerRow(TrailerModel data) {
    final count = data.results.length.clamp(0, 2);
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: count,
      separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (ctx, index) {
        final t = data.results[index];
        return _trailerCard(t);
      },
    );
  }

  Widget _trailerCard(Result t) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(5.0),
          width: 150,
          height: 80,
          color: Colors.grey[300],
          child: const Center(
            child: Icon(Icons.play_circle_fill, size: 40),
          ),
        ),
        SizedBox(
          width: 150,
          child: Text(
            t.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}