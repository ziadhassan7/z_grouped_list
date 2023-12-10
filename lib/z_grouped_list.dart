library z_grouped_list;

import 'package:flutter/material.dart';

//ignore: must_be_immutable
class ZGroupedList<T, E> extends StatelessWidget {

  /// your data list
  final List<T> items;
  /// The item you need to sort by
  /// A Function which maps an element to its grouped value
  /// example: fetch the year integer of your data , and return this integer
  final E Function(T) sortBy;
  /// item widget
  final Widget Function(BuildContext, T) itemBuilder;
  /// group separator widget
  final Widget Function(E) groupSeparatorBuilder;
  /// how many items horizontally in a grid
  int? crossAxisCount;
  /// pass in a custom gridDelegate
  SliverGridDelegate? gridDelegate;
  /// Should organize in a descending order?
  /// true by default
  bool descendingOrder;

  late bool _isGrid;
  static final List _sortHeaders = [];


  ///Normal List View
  ZGroupedList(
      {Key? key,
        required this.items,
        required this.sortBy,
        required this.itemBuilder,
        required this.groupSeparatorBuilder,
        this.descendingOrder = true})
      : super(key: key) {

    _isGrid = false;
  }

  /// Grid List
  ZGroupedList.grid(
      {Key? key,
        required this.items,
        required this.sortBy,
        required this.itemBuilder,
        required this.groupSeparatorBuilder,
        this.crossAxisCount,
        this.gridDelegate,
        this.descendingOrder = true
      })
      : super(key: key) {

    _isGrid = true;
    assert(crossAxisCount != null || gridDelegate != null);
  }

  @override
  Widget build(BuildContext context) {

    _generateHeaderList();

    return groupWidget(context);
  }


  /// Main Widget - (Header & Group)
  Widget groupWidget(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        children: [

          for(var header in _sortHeaders)
            Column(
              children: [
                //header
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: groupSeparatorBuilder(header),
                ),
                //group
                _isGrid
                    ? sliverList(getGroupByHeader(header))
                    : normalList(getGroupByHeader(header)),
              ],
            ),

        ],
      ),
    );

  }


  // Your Group Widget
  Widget normalList(List currentGroup){
    return Padding(
        padding: const EdgeInsets.only(top: 30),

        child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            // use count of group items
            itemCount: currentGroup.length,
            itemBuilder: (context, index) {
              return itemBuilder(context, currentGroup[index]);
            }
        )

    );
  }

  // Your Group Widget
  Widget sliverList(List currentGroup){
    return Padding(
      padding: const EdgeInsets.only(top: 30),

      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              // use count of group items
              childCount: currentGroup.length,
                  (context, index) {
                return itemBuilder(context, currentGroup[index]);
              },
            ),

            gridDelegate: gridDelegate ?? SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount ?? 1,
              childAspectRatio: 2 / 3.2,
              crossAxisSpacing: 25,
              mainAxisSpacing: 15,),
          )
        ],
      ),
    );
  }


  ///                                                                           / Functions

  // List of headers
  void _generateHeaderList(){

    for(var item in items){
      if(!_sortHeaders.contains(sortBy(item))){
        _sortHeaders.add(sortBy(item));
      }
    }

    //arrange headers
    _sortHeaders.sort((a,b) {
      return descendingOrder
          ? b.compareTo(a)
          : a.compareTo(b);
    });
  }

  // List of groups
  getGroupByHeader(var header){

    List currentGroup = [];

    for(var item in items){
      if(sortBy(item) == header){
        currentGroup.add(item);
      }
    }

    return currentGroup;
  }

}