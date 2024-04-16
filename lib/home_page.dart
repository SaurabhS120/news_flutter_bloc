import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/base_page/base_page.dart';
import 'package:news_flutter_data_dummy/di.dart';
import 'package:news_flutter_domain/NewsDI.dart';
import 'package:news_flutter_domain/errors/base_error.dart';
import 'package:news_flutter_domain/model/news_model.dart';
import 'package:news_flutter_domain/usecase/get_news_usecase.dart';

class HomePage extends BasePage {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends BasePageState<HomePage> {
  @override
  PreferredSizeWidget buildAppBar() {
    return AppBar(
      title: const Text('home page'),
    );
  }

  @override
  Widget buildBody() {
    return const HomePageView();
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageViewModel, HomePageBlocState>(
      builder: (context, state) {
        if (state is HomePageBlocStateSuccess) {
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(state.news[index].title),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemCount: state.news.length,
          );
        } else if (state is HomePageBlocStateLoading) {
          return const Center(
            child: Text("Loading"),
          );
        } else {
          return const Center(
            child: Text("Error"),
          );
        }
      },
    );
  }
}

/// View model will handle communication between UI and data layer
/// Responsibilities:
/// Fetching data from data layer and notifying its response to UI
/// To hold UI state, required controllers
/// Calculations like validation, data filtration, sorting
abstract class HomePageEvent {}

class HomePageGetNewsEvent extends HomePageEvent {}

abstract class HomePageBlocState {}

class HomePageBlocStateInitial extends HomePageBlocState {}

class HomePageBlocStateLoading extends HomePageBlocState {}

class HomePageBlocStateSuccess extends HomePageBlocState {
  final List<NewsModel> news;

  HomePageBlocStateSuccess({required this.news});
}

class HomePageBlocStateError extends HomePageBlocState {
  final BaseError error;

  HomePageBlocStateError({required this.error});
}

class HomePageViewModel extends Bloc<HomePageEvent, HomePageBlocState> {
  NewsDI newsDI = DummyNewsDI();
  late GetNewsUseCase getNewsUseCase = newsDI.createGetNewsUseCase();

  HomePageViewModel() : super(HomePageBlocStateInitial()) {
    on<HomePageGetNewsEvent>((event, emit) async {
      emit(HomePageBlocStateLoading());
      var result = await getNewsUseCase.execute(GetNewsUseCaseParams());
      if (result.isLeft) {
        emit(HomePageBlocStateSuccess(news: result.left));
      } else {
        emit(HomePageBlocStateError(error: result.right));
      }
    });
  }
}
