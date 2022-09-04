import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_courses_project/screens/home.dart';
import 'package:online_courses_project/themes/color.dart';
import 'package:online_courses_project/utils/data.dart';
import 'package:online_courses_project/widgets/category_item.dart';
import 'package:online_courses_project/widgets/course_item.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: appBarColor,
            pinned: true,
            title: getAppBar(),
          ),
          SliverToBoxAdapter(
            child: getSearchBox(),
          ),
          SliverToBoxAdapter(
            child: getCategoryBox(),
          ),
          SliverList(
            delegate: getCourses(),
          ),
        ],
      ),
    );
  }

  int selectedCategoryIndex = 0;

  getCourses() {
    return SliverChildBuilderDelegate(
      childCount: courses.length,
      (context, index) => Padding(
        padding: const EdgeInsets.only(top: 5, left: 15.0, right: 15),
        child: CourseItem(
          data: courses[index],
          onBookmark: () {
            setState(() {
              courses[index]['is_favorited'] = !courses[index]['is_favorited'];
            });
          },
        ),
      ),
    );
  }

  getCategoryBox() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: 15, top: 10, bottom: 5),
      child: Row(
        children: List.generate(
            categories.length,
            (index) => CategoryItem(
                  onTap: () {
                    setState(() {
                      selectedCategoryIndex = index;
                    });
                  },
                  isActive: index == selectedCategoryIndex,
                  data: categories[index],
                )),
      ),
    );
  }

  getSearchBox() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          Expanded(
            child: Container(
                height: 40,
                padding: EdgeInsets.only(bottom: 1),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: shadowColor.withOpacity(0.05),
                        spreadRadius: .5,
                        blurRadius: .5,
                        offset: Offset(0, 0),
                      ),
                    ]),
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                      border: InputBorder.none),
                )),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
              'assets/icons/filter.svg',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  getAppBar() {
    return Container(
      child: Row(
        children: [
          Text(
            'Explore',
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.w600, fontSize: 24),
          ),
        ],
      ),
    );
  }
}
