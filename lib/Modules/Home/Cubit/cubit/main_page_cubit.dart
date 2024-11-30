
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talents/Modules/Home/Cubit/state/main_page_stata.dart';
import 'package:talents/Modules/Home/View/Screens/home_screen.dart';
import 'package:talents/Modules/Library/View/Screens/main_sections_library.dart';
import 'package:talents/Modules/Profile/View/Screens/profile_screen.dart';

class MainPageCubit extends Cubit<MainPageState> {
  MainPageCubit() : super(HomeInInitial());

  static MainPageCubit get(context) => BlocProvider.of(context);

  final List pages = [const HomeScreen(), const MainSectionsLibrary(), const ProfileScreen()];

  int selectedPage = 0;

  void moveTab(int index) {
    selectedPage = index;
    emit(MoveTab());
  }
}
