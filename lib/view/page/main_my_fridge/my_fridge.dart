import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/widget/custom_widgets/super_container.dart';
import 'package:leute/view/page/main_my_fridge/my_fridge_view_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class MyFridge extends StatelessWidget {
  const MyFridge({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MyFridgeViewModel>();
    final state = viewModel.state;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            '나의냉장고',
            style: AppTextStyle.header22(color: Colors.white),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: const Color(0xFF9bc6bf),
              borderRadius: BorderRadius.circular(10).r),
        ),
      ),
      body: state.isLoading
          ? Center(
              child: LoadingAnimationWidget.inkDrop(
                color: const Color(0xFF9bc6bf),
                size: 50,
              ),
            )
          : state.myFoodDetails.isEmpty
              ? const Center(
                  child: Text('보관중인 음식이 없습니다.'),
                )
              : Padding(
                  padding: const EdgeInsets.all(8).w,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (var refrigeDetail in state.refrigeDetails)
                          Column(
                            children: [
                              Stack(
                                children: [
                                  if (state.myFoodDetails
                                      .where((e) =>
                                          e.refrigeName ==
                                          refrigeDetail.refrigeName)
                                      .isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                              top: 40, left: 16, right: 16)
                                          .w,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10).r,
                                            color: const Color(0xFFbbd7da)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0).w,
                                          child: GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              mainAxisSpacing: 10,
                                              crossAxisSpacing: 10,
                                              childAspectRatio: 1 / 1,
                                            ),
                                            itemCount: state.myFoodDetails
                                                .where((e) =>
                                                    e.refrigeName ==
                                                    refrigeDetail.refrigeName)
                                                .length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  context.go('/myfooddetail',
                                                      extra: [
                                                        state.myFoodDetails
                                                            .where((e) =>
                                                                e.refrigeName ==
                                                                refrigeDetail
                                                                    .refrigeName)
                                                            .toList()[index],
                                                        refrigeDetail
                                                      ]);
                                                },
                                                child: SuperContainer(
                                                  height: 90,
                                                  width: 100,
                                                  border: 80,
                                                  borderWidth: 10,
                                                  borderColor: (state
                                                              .myFoodDetails
                                                              .where((e) =>
                                                                  e.refrigeName ==
                                                                  refrigeDetail
                                                                      .refrigeName)
                                                              .toList()[index]
                                                              .isPublic ==
                                                          true)
                                                      ? const Color(0xFFFFE088)
                                                      : const Color(0xFFbbd7da),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      state.myFoodDetails
                                                          .where((e) =>
                                                              e.refrigeName ==
                                                              refrigeDetail
                                                                  .refrigeName)
                                                          .toList()[index]
                                                          .foodImage,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (state.myFoodDetails
                                      .where((e) =>
                                          e.refrigeName ==
                                          refrigeDetail.refrigeName)
                                      .isNotEmpty)
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0).w,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5).r,
                                              border: Border.all(
                                                  color:
                                                      const Color(0xFF9bc6bf),
                                                  width: 3),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0).w,
                                              child: Text(
                                                ' ${refrigeDetail.refrigeName}',
                                                style: AppTextStyle.body12R(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              if (state.myFoodDetails
                                  .where((e) =>
                                      e.refrigeName ==
                                      refrigeDetail.refrigeName)
                                  .isNotEmpty)
                                SizedBox(
                                  height: 30.h,
                                )
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
