import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Constant/public_constant.dart';
import 'package:talents/Modules/Library/Cubit/library_cubit.dart';
import 'package:talents/Modules/Library/Cubit/library_state.dart';
import 'package:talents/Modules/Library/View/Screens/sub_sections_library.dart';
import 'package:talents/Modules/Library/View/Widgets/library_section_card.dart'; 
import 'package:talents/Modules/Widgets/no_data.dart';
import 'package:talents/Modules/Widgets/page_loading.dart';
import 'package:talents/Modules/Widgets/try_agin.dart';

import '../../../Widgets/refresher_header.dart';
import '../Widgets/grad_shimmer.dart';

class MainSectionsLibrary extends StatefulWidget {
  const MainSectionsLibrary({super.key});

  @override
  State<MainSectionsLibrary> createState() => _MainSectionsLibraryState();
}

class _MainSectionsLibraryState extends State<MainSectionsLibrary> {
  late LibraryCubit libraryCubit;

  @override
  void initState() {
    libraryCubit = LibraryCubit()..getMainSections();
    super.initState();
  }

  @override
  void dispose() {
    libraryCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideInUp(
      child: BlocProvider(
        create: (context) => libraryCubit,
        child: Builder(builder: (context) {
          return Column(
            children: [
              SizedBox(height: 15.h),
              Text(
                'أقسام المكتبة',
                style: AppTextStyles.meduimTitle
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 0.5.h),
              BlocBuilder<LibraryCubit, LibraryState>(
                builder: (context, state) {
                  final LibraryCubit libraryCubit = LibraryCubit.get(context);
                  // return const LibrarySectionShimmer();
                  if (state is LibraryLoadingState) {
                    return const Expanded(
                        child: GradShimmer(
                      isScrollable: true,
                    ));
                  }

                  if (state is LibraryErrorState) {
                    return SizedBox(
                      height: 70.h,
                      child: TryAgain(
                        message: state.message,
                        onTap: () {
                          libraryCubit.getMainSections();
                        },
                      ),
                    );
                  }

                  if (libraryCubit.libraryMianSections.isEmpty) {
                    return const Nodata();
                  }

                  return Expanded(
                    child: SmartRefresher(
                      controller: libraryCubit.refreshController,
                      header: const AppRefresherHeader(),
                      onRefresh: () {
                        libraryCubit.page = 1;
                        libraryCubit.getMainSections();
                        libraryCubit.refreshController.refreshCompleted();
                        libraryCubit.refreshController.loadComplete();
                      },
                      onLoading: () {
                        libraryCubit.getMainSections();
                      },
                      footer: CustomFooter(builder: (context, mode) {
                        return const SizedBox();
                      }),
                      enablePullDown: true,
                      enablePullUp: true,
                      child: CustomScrollView(
                        slivers: [
                          SliverPadding(
                            padding: EdgeInsets.only(
                                left: 2.w, right: 2.w, top: 2.h, bottom: 1.5.h),
                            sliver: SliverGrid.builder(
                              itemCount: context
                                  .watch<LibraryCubit>()
                                  .libraryMianSections
                                  .length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
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
                                        toPage: SubSectionsLibrary(
                                          perantId: libraryCubit
                                              .libraryMianSections[index].id,
                                          perantName: libraryCubit
                                              .libraryMianSections[index].name,
                                        ));
                                  },
                                  child: ZoomIn(
                                    child: LibrarySectionCard(
                                        section: libraryCubit
                                            .libraryMianSections[index]),
                                  )),
                            ),
                          ),
                          SliverToBoxAdapter(
                              child: Column(
                            children: [
                              PaginitionFotter(libraryCubit: libraryCubit),
                              SizedBox(height: 1.h)
                            ],
                          )),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}

class PaginitionFotter extends StatefulWidget {
  const PaginitionFotter({super.key, required this.libraryCubit});

  final LibraryCubit libraryCubit;

  @override
  PaginitionFotterState createState() => PaginitionFotterState();
}

class PaginitionFotterState extends State<PaginitionFotter> {
  @override
  void initState() {
    widget.libraryCubit.refreshController.footerMode!.addListener(
      () {
        widget.libraryCubit.refreshController.footerStatus;
        if (mounted) setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.libraryCubit.refreshController.footerStatus ==
        LoadStatus.noMore) {
      return Center(
        child: FadeIn(
          child: Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: Text(
              'لا يوجد المزيد من الأقسام',
              style: AppTextStyles.meduimTitle.copyWith(shadows: boxShadow),
            ),
          ),
        ),
      );
    }
    if (widget.libraryCubit.refreshController.footerStatus ==
        LoadStatus.loading) {
      return Padding(
        padding: EdgeInsets.only(
          top: 1.h,
        ),
        child: const PageLoading(),
      ); // LibrarySectionShimmer();
    }
    return const SizedBox();
  }
}
