import 'package:flutter/material.dart';
import 'package:movies_app/utils/constants.dart';
import 'package:movies_app/screens/trendingMovies/trending_movies_bloc.dart';
import 'package:movies_app/screens/trendingMovies/trending_movies_model.dart';


import '../../server/api_response.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   late TrendingMoviesBloc _bloc;

  @override
  void didChangeDependencies() {
    if (mounted) {
      _bloc = TrendingMoviesBloc(context, this)..onGetTrendingMovies();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ApiResponse<TrendingMoviesModel>>(
          initialData: ApiResponse.loading(),
          stream: _bloc.trendingMoviesSubject,
          builder: (context, snapshot) {

            bool isLoading = false;

            if (!snapshot.hasError) {
              isLoading =
                  snapshot.hasData && snapshot.data?.status == Status.loading;
            }

            return snapshot.data!.status == Status.error
                ? Center(child: Text(snapshot.data!.message!))
                : isLoading
                    ? const Center(child: CircularProgressIndicator(color: Constants.kPrimaryColor,))
                    : snapshot.data!.data!.results.isEmpty
                        ? const Center(
                            child: Text("ConstantStrings.NO_ORDER_FOUND"),
                          )
                        : ListView(
                            children: [
                              ...List.generate(
                                snapshot.data!.data!.results.length,
                                (i) => ListTile(title: Text(snapshot.data!.data!.results[i].originalTitle.toString()))
                              ),
                            ],
                          );
          }),
    );
  }
}