import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inbox_driver/feature/model/country.dart';
import 'package:inbox_driver/feature/view/widgets/primary_button.dart';
import 'package:inbox_driver/feature/view_model/auht_view_modle/auth_view_modle.dart';
import 'package:inbox_driver/util/app_color.dart';
import 'package:inbox_driver/util/app_dimen.dart';
import 'package:inbox_driver/util/app_shaerd_data.dart';
import 'package:inbox_driver/util/app_style.dart';
import 'package:inbox_driver/util/string.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

import 'country_item_widget.dart';



class ChooseCountryScreen extends StatefulWidget {
 const ChooseCountryScreen({Key? key}) : super(key: key);

  @override
  State<ChooseCountryScreen> createState() => _ChooseCountryScreenState();
}

class _ChooseCountryScreenState extends State<ChooseCountryScreen> {
  final controller = PagingController<int, Country>(firstPageKey: 1);

  final repo = AuthViewModle();

  Logger log = Logger();

  Country selctedCountry = Country();
  AuthViewModle authViewModle = Get.put(AuthViewModle());
  Set<Country> listCountry = <Country>{};
  @override
  void initState() {
    super.initState();
    authViewModle.tdSearch.clear();
  }

  @override
  Widget build(BuildContext context) {
    screenUtil(context);
    controller.addPageRequestListener((pageKey) async {
      final data = await repo.getCountries((1 + (pageKey ~/ 10)).toInt(), 250);
      for(var i in data){
        var contains = listCountry.contains(i);
        if(contains) {
          data.remove(i);
        }
      }
      controller.appendPage(data.toList(), pageKey + data.length);
      listCountry.addAll(data);
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(Get.context!);
          },
          icon: isArabicLang()
              ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/svgs/back_arrow_ar.svg"),
              )
              : SvgPicture.asset("assets/svgs/back_arrow.svg"),
        ),
        title: Text(
         txtChooseCountry.tr,
          style: textStyleAppBarTitle(),
        ),
        centerTitle: true,
        backgroundColor: colorBackground,
      ),
      body: GetBuilder<AuthViewModle>(
        init: AuthViewModle(),
        builder: (logic) {
          return Column(
            children: [
              Container(
                height: sizeH10,
                color: colorScaffoldRegistrationBody,
              ),
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorScaffoldRegistrationBody,
                ),
                padding: EdgeInsets.symmetric(horizontal: sizeH20!),
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          "assets/svgs/search_icon.svg",
                        ),
                      ),
                     hintText:  txtChooseCountry
                    ),
                  onChanged: (newVal) {
                    logic.tdSearch.text = newVal.toString();
                    logic.update();
                  },
                ),
              ),
              SizedBox(height: sizeH16,),
              Expanded(
                child: PagedListView(
                  pagingController: controller,
                  builderDelegate: PagedChildBuilderDelegate<Country>(
                      newPageProgressIndicatorBuilder: (ctx) {
                    return const SizedBox();
                  }, itemBuilder: (context, item, index) {
                       // if(listCountry.contains(item)){
                       //   return const SizedBox.shrink();
                       // }
                    if(item.name?.toLowerCase() == "iran" ||item.name?.toLowerCase() == "syria"){
                      return const SizedBox();
                    }
                    return InkWell(
                      onTap: () {
                        logic.selectedIndex = -1;
                        logic.selectedIndex = index;
                        selctedCountry = item;
                        logic.update();
                      },
                      child: Container(
                          color: colorScaffoldRegistrationBody,
                          padding: EdgeInsets.symmetric(horizontal: sizeH20!,),
                          child: logic.tdSearch.text.isEmpty ||
                                  item.name.toString().toUpperCase().contains(
                                      logic.tdSearch.text.toUpperCase())
                              ? CountryItem(
                                  cellIndex: index,
                                  selectedIndex: logic.selectedIndex,
                                  item: item,
                                )
                              : const SizedBox()),
                    );
                  }),
                ),
              ),
              Container(
                color: colorScaffoldRegistrationBody,
                padding: const EdgeInsets.all(10),
                child: PrimaryButton(
                    isLoading: false,
                    textButton: txtOk.tr,
                    onClicked: () {
                      if(selctedCountry.name != null && selctedCountry.code != null) {
                        logic.defCountry = selctedCountry;
                        logic.update();
                        Navigator.pop(context);
                      }
                    },
                    isExpanded: true),
              ),
              Container(
                height: sizeH20,
                color: colorScaffoldRegistrationBody,
              ),
            ],
          );
        },
      ),
    );
  }
}
