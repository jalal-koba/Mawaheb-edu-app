import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talents/Apis/exception_handler.dart';
import 'package:talents/Apis/network.dart';
import 'package:talents/Apis/urls.dart';
import 'package:talents/Modules/Library/Cubit/library_state.dart';
import 'package:talents/Modules/Library/Model/book.dart';
import 'package:talents/Modules/Library/Model/library_response.dart';
import 'package:talents/Modules/Library/Model/librart_secions_response.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:talents/Modules/Library/Model/library_section.dart';

class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit() : super(LibraryInitialState());

  LibrarySectionsResponse? librarySectionsResponse;
  static LibraryCubit get(context) => BlocProvider.of(context);
  List<LibrarySection> libraryMianSections = [];
  List<LibrarySection> librarySubSections = [];
  List<Book> books = [];

  int page = 1;

  BooksResponse? libraryResponse;
  RefreshController refreshController = RefreshController();

  void onRefresh() {}

  Future<void> getMainSections() async {
    if (page == 1) {
      emit(LibraryLoadingState());
    }
    try {
      Response response =
          await Network.getData(url: "${Urls.librarySections}&page=$page");

      librarySectionsResponse = LibrarySectionsResponse.fromJson(response.data);

      if (page > 1) {
        libraryMianSections.addAll(librarySectionsResponse!.data.sections);

        if (librarySectionsResponse!.data.sections.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      } else {
        libraryMianSections = librarySectionsResponse!.data.sections;
      }
      page = librarySectionsResponse!.data.currentPage + 1;

      emit(LibrarySuccessState());
    } on DioException catch (error) {
      emit(LibraryErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(LibraryErrorState(message: "حدث خطأ ما"));
    }
  }

  Future<void> getSubSections(int parentPage) async {
    if (page == 1) {
      emit(LibraryLoadingState());
    }
    try {
      Response response = await Network.getData(
          url:
              "${Urls.librarySubSections}/$parentPage?page=$page&type=book_sub_section");

      librarySectionsResponse = LibrarySectionsResponse.fromJson(response.data);

      if (page > 1) {
        librarySubSections.addAll(librarySectionsResponse!.data.sections);

        if (librarySectionsResponse!.data.sections.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      } else {
        librarySubSections = librarySectionsResponse!.data.sections;
      }
      page = librarySectionsResponse!.data.currentPage + 1;

      emit(LibrarySuccessState());
    } on DioException catch (error) {
      emit(LibraryErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(LibraryErrorState(message: "حدث خطأ ما"));
    }
  }

  Future<void> getBooks(int subSectionId) async {
    if (page == 1) {
      emit(LibraryLoadingState());
    }
    try {
      Response response = await Network.getData(
          url: "${Urls.librarySubSections}/$subSectionId/books?page=$page");

      libraryResponse = BooksResponse.fromJson(response.data);
      if (page > 1) {
        books.addAll(libraryResponse!.data.data);

        if (libraryResponse!.data.data.isEmpty) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
      } else {
        books = libraryResponse!.data.data;
      }
      page = libraryResponse!.data.currentPage + 1;

      print(books.length);
      emit(LibrarySuccessState());
    } on DioException catch (error) {
      emit(LibraryErrorState(message: exceptionsHandle(error: error)));
    } catch (error) {
      emit(LibraryErrorState(message: "حدث خطأ ما"));
    }
  }
}
