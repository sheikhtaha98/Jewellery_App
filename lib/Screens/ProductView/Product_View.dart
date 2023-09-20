import 'package:flutter/material.dart';
import 'package:ui_project/Constants/colors.dart';
import 'package:ui_project/Functions/getfilteredList.dart';
import 'package:ui_project/Screens/productView/ProductView_widgets/itemCard.dart';
import 'package:ui_project/Screens/productView/ProductView_widgets/productAppBar.dart';

class ProductView extends StatefulWidget {
  final int pageNo;
  final String categoryName;
  const ProductView(
      {super.key, required this.pageNo, required this.categoryName});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView>
    with TickerProviderStateMixin {
  List TagList = [];
  String? tag;
  @override
  void initState() {
    tag = 'All';
    TagList = FilteredList.getFilteredList(widget.categoryName, tag!);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(15, 10, 0, 0),
                child: ProductAppBar(
                  categoryName: widget.categoryName,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(15, 10, 10, 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // All
                      ChoiceChip(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: BorderSide(
                                color: (tag == 'All')
                                    ? PrimaryColors.primaryOrange
                                    : SecondaryColors.secondaryGrey02,
                                width: 1)),
                        label: SizedBox(
                          width: 80,
                          height: 30,
                          child: Center(
                              child: Text(
                            'All',
                            style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 14,
                                color: (tag == 'All')
                                    ? TextColors.textColor1
                                    : SecondaryColors.secondaryGrey02,
                                fontWeight: FontWeight.w600),
                          )),
                        ),
                        selected: (tag == 'All') ? true : false,
                        selectedColor: PrimaryColors.primaryOrange,
                        backgroundColor: Colors.transparent,
                        onSelected: (value) {
                          setState(() {
                            tag = 'All';
                            TagList = FilteredList.getFilteredList(
                                widget.categoryName, tag!);
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      // Popular for All
                      ChoiceChip(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: BorderSide(
                                color: (tag == 'Popular')
                                    ? PrimaryColors.primaryOrange
                                    : SecondaryColors.secondaryGrey02,
                                width: 1)),
                        label: SizedBox(
                          width: 80,
                          height: 30,
                          child: Center(
                              child: Text(
                            'Popular',
                            style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 14,
                                color: (tag == 'Popular')
                                    ? TextColors.textColor1
                                    : SecondaryColors.secondaryGrey02,
                                fontWeight: FontWeight.w600),
                          )),
                        ),
                        selected: (tag == 'Popular') ? true : false,
                        selectedColor: PrimaryColors.primaryOrange,
                        backgroundColor: Colors.transparent,
                        onSelected: (value) {
                          setState(() {
                            tag = 'Popular';
                            TagList = FilteredList.getFilteredList(
                                widget.categoryName, tag!);
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ChoiceChip(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: BorderSide(
                                color: (tag == 'New')
                                    ? PrimaryColors.primaryOrange
                                    : SecondaryColors.secondaryGrey02,
                                width: 1)),
                        label: SizedBox(
                          width: 80,
                          height: 30,
                          child: Center(
                              child: Text(
                            'New',
                            style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 14,
                                color: (tag == 'New')
                                    ? TextColors.textColor1
                                    : SecondaryColors.secondaryGrey02,
                                fontWeight: FontWeight.w600),
                          )),
                        ),
                        selected: (tag == 'New') ? true : false,
                        selectedColor: PrimaryColors.primaryOrange,
                        backgroundColor: Colors.transparent,
                        onSelected: (value) {
                          setState(() {
                            tag = 'New';
                            TagList = FilteredList.getFilteredList(
                                widget.categoryName, tag!);
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      // low Price for all
                      ChoiceChip(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: BorderSide(
                                color: (tag == 'Low Price')
                                    ? PrimaryColors.primaryOrange
                                    : SecondaryColors.secondaryGrey02,
                                width: 1)),
                        label: SizedBox(
                          width: 80,
                          height: 30,
                          child: Center(
                              child: Text(
                            'Low Price',
                            style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 14,
                                color: (tag == 'Low Price')
                                    ? TextColors.textColor1
                                    : SecondaryColors.secondaryGrey02,
                                fontWeight: FontWeight.w600),
                          )),
                        ),
                        selected: (tag == 'Low Price') ? true : false,
                        selectedColor: PrimaryColors.primaryOrange,
                        backgroundColor: Colors.transparent,
                        onSelected: (value) {
                          setState(() {
                            tag = 'Low Price';
                            TagList = FilteredList.getFilteredList(
                                widget.categoryName, tag!);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: TagList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.73,
                            mainAxisSpacing: 2),
                    itemBuilder: (context, index) {
                      return Container(
                          margin: const EdgeInsets.all(5),
                          child: ProductCard(
                            TagList: TagList[index],
                            Index: index,
                          ));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
