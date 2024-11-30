import 'package:animate_do/animate_do.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:talents/Apis/urls.dart';
import 'package:talents/Constant/app_colors.dart';
import 'package:talents/Constant/app_text_styles.dart';
import 'package:talents/Modules/Library/Cubit/library_cubit.dart';
import 'package:talents/Modules/Library/Cubit/library_state.dart';
import 'package:talents/Modules/Library/Model/book.dart';
import 'package:talents/Modules/Widgets/app_footer.dart';
import 'package:talents/Modules/Widgets/app_shimmer.dart';
import 'package:talents/Modules/Widgets/cached_image.dart';
import 'package:talents/Modules/Widgets/custom_button.dart';
import 'package:talents/Modules/Widgets/no_data.dart';
import 'package:talents/Modules/Widgets/refresher_header.dart';
import 'package:talents/Modules/Widgets/try_agin.dart';

import '../../../Widgets/app_scaffold.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen(
      {super.key, required this.perantId, required this.subSectionName});
  final int perantId;
  final String subSectionName;
  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  late LibraryCubit libraryCubit;

  @override
  void initState() {
    libraryCubit = LibraryCubit()..getBooks(widget.perantId);
    super.initState();
  }

  @override
  void dispose() {
    libraryCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return AppScaffold(
      title: widget.subSectionName,
      body: BlocProvider(
        create: (context) => libraryCubit,
        child:
            BlocBuilder<LibraryCubit, LibraryState>(builder: (context, state) {
          if (state is LibraryErrorState) {
            return TryAgain(
                message: state.message,
                onTap: () {
                  context.read<LibraryCubit>().page = 1;
                  libraryCubit.getBooks(widget.perantId);
                });
          }
          if (state is LibraryLoadingState) {
            return const BooksShimmer();
          }

          return SmartRefresher(
            onRefresh: () {
              libraryCubit.page = 1;
              libraryCubit.getBooks(widget.perantId);
              libraryCubit.refreshController.refreshCompleted();
              libraryCubit.refreshController.loadComplete();
            },
            header: const AppRefresherHeader(),
       footer: const AppFooter(
                title:   'لا يوجد المزيد من الكتب',
              ),
            controller: libraryCubit.refreshController,
            enablePullDown: true,
            enablePullUp: libraryCubit.books.isNotEmpty,
            onLoading: () {
              libraryCubit.getBooks(widget.perantId);
            },
            child: Builder(
              builder: (context) {
                if (libraryCubit.books.isEmpty) {
                  return const Nodata();
                }
                return ListView.builder(
                  itemCount: context.watch<LibraryCubit>().books.length,
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  itemBuilder: (context, index) => SlideInDown(
                    duration: Duration(milliseconds: 200 + ((index % 7) * 100)),
                    child: BookCard(
                      book: libraryCubit.books[index],
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}

class BooksShimmer extends StatelessWidget {
  const BooksShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: ListView.builder(
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) => Container(
          height: 15.h,
          decoration: BoxDecoration(
              color: AppColors.secondary,
              border: Border.all(color: AppColors.buttonColor, width: 1),
              borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        ),
        itemCount: 10,
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AppColors.cardBackground,
            border: const Border(
              bottom: BorderSide(color: AppColors.secondary, width: 2),
            ),
            borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.symmetric(vertical: 0.75.h),
        child: Row(
          children: <Widget>[
            Container(
              height: 13.h,
              width: 30.w,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                color: AppColors.favoriteBlue,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: CachedImage(imageUrl: book.image),
            ),
            SizedBox(
              width: 2.w,
            ),
            Expanded(
                child: SizedBox(
              height: 12.h,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    book.name,
                    style: AppTextStyles.secondTitle
                        .copyWith(fontWeight: FontWeight.bold),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  CustomButton(
                    titlebutton: "فتح الكتاب",
                    onPressed: () {
                      EasyLauncher.url(
                          url: "${Urls.storageBaseUrl}${book.file}");
                    },
                    width: 23,
                    fontSize: 10,
                    height: 3.5,
                  )
                ],
              ),
            ))
          ],
        ));
  }
}
