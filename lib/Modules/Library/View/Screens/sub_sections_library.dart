import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Library/Cubit/library_cubit.dart';
import 'package:talents/Modules/Library/Cubit/library_state.dart';
import 'package:talents/Modules/Library/View/Screens/books_screen.dart';
import 'package:talents/Modules/Library/View/Widgets/grad_shimmer.dart';
import 'package:talents/Modules/Library/View/Widgets/library_section_card.dart';
import 'package:talents/Modules/Widgets/app_footer.dart';
import 'package:talents/Modules/Widgets/app_scaffold.dart';
import 'package:talents/Modules/Widgets/no_data.dart';
import 'package:talents/Modules/Widgets/refresher_header.dart';
import 'package:talents/Modules/Widgets/try_agin.dart';


class SubSectionsLibrary extends StatefulWidget {
  const SubSectionsLibrary(
      {super.key, required this.perantId, required this.perantName});
  final int perantId;
  final String perantName;

  @override
  State<SubSectionsLibrary> createState() => _SubSectionsLibraryState();
}

class _SubSectionsLibraryState extends State<SubSectionsLibrary> {
  late LibraryCubit libraryCubit;
  @override
  void initState() {
    libraryCubit = LibraryCubit()..getSubSections(widget.perantId);
    super.initState();
  }

  @override
  void dispose() {
    libraryCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: widget.perantName,
      body: SlideInUp(
        child: BlocProvider(
          create: (context) => libraryCubit,
          child: BlocBuilder<LibraryCubit, LibraryState>(
              builder: (context, state) {
            final LibraryCubit libraryCubit = LibraryCubit.get(context);
          
          
            if (state is LibraryErrorState) {
              return TryAgain(
                message: state.message,
                onTap: () {
                  libraryCubit.getSubSections(widget.perantId);
                },
              );
            }

            if (state is LibraryLoadingState) {
              return const GradShimmer();
            }

            if (libraryCubit.librarySubSections.isEmpty) {
              return const Nodata();
            }

            return Expanded(
              child: SmartRefresher(
                controller: libraryCubit.refreshController,
                onRefresh: () {
                  libraryCubit.page = 1;
                  libraryCubit.getSubSections(widget.perantId);
                  libraryCubit.refreshController.refreshCompleted();
                  libraryCubit.refreshController.loadComplete();
                },
                onLoading: () {
                  libraryCubit.getSubSections(widget.perantId);
                },
                header: const AppRefresherHeader(),
          footer: const AppFooter(
                title:   'لا يوجد المزيد من الكتب',
              ),
                enablePullDown: true,
                enablePullUp: libraryCubit.librarySubSections.isNotEmpty,
                child: GridView.builder(
                  padding: EdgeInsets.only(bottom: 3.h, top: 2.h),
                  itemCount: libraryCubit.librarySubSections.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.1,
                      crossAxisCount: 2,
                      crossAxisSpacing: 1.w,
                      mainAxisSpacing: 2.h),
                  itemBuilder: (context, index) => InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        pushTo(
                            context: context,
                            toPage: BooksScreen(
                              perantId:
                                  libraryCubit.librarySubSections[index].id,
                              subSectionName:
                                  libraryCubit.librarySubSections[index].name,
                            ));
                      },
                      child: ZoomIn(
                        child: LibrarySectionCard(
                            section: libraryCubit.librarySubSections[index]),
                      )),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
