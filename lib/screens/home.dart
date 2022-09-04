import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_courses_project/screens/course_details.dart';
import 'package:online_courses_project/themes/color.dart';
import 'package:online_courses_project/utils/data.dart';
import 'package:online_courses_project/widgets/category_box.dart';
import 'package:online_courses_project/widgets/feature_item.dart';
import 'package:online_courses_project/widgets/notification_box.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:online_courses_project/widgets/recommend_item.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: buildBody(),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hossam Ayman',
                style: TextStyle(color: labelColor, fontSize: 14),
              ),
              Text(
                'Good Morning',
                style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          NotificationBox(notifiedNumber: 1),
        ],
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getCategories(),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
            child: Text(
              'Featured',
              style: TextStyle(
                color: textColor,
                fontSize: 22,
              ),
            ),
          ),
          getFeatures(context),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 25, 15, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recommended',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 22,
                  ),
                ),
                Text(
                  'see all',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          getRecommended(),
        ],
      ),
    );
  }

  Widget getRecommended() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 15),
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(
              recommends.length,
              (index) => Container(
                    margin: EdgeInsets.only(right: 15, bottom: 5),
                    child: RecommendedItem(
                        data: recommends[index],
                        onTap: () {
                          print(index);
                        }),
                  ))),
    );
  }

  Widget getAttribute(String info, IconData iconData, Color color) {
    return Row(
      children: [
        Icon(
          iconData,
          size: 19,
          color: color,
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          info,
          style: TextStyle(
            color: labelColor,
            fontSize: 19,
          ),
        ),
      ],
    );
  }
}

Widget getFeatures(BuildContext context) {
  return Container(
    height: 300,
    child: CarouselSlider(
        items: List.generate(
            features.length,
            (index) => FeatureItem(
                  data: features[index],
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CourseDetails(
                        data: {"courses": features[index]},
                      ),
                    ));
                  },
                )),
        options: CarouselOptions(
          height: 290,
          enlargeCenterPage: true,
          disableCenter: true,
        )),
  );
}

Widget getAttribute(String info, IconData iconData, Color color) {
  return Row(
    children: [
      Icon(
        iconData,
        size: 19,
        color: color,
      ),
      SizedBox(
        width: 3,
      ),
      Text(
        info,
        style: TextStyle(
          color: labelColor,
          fontSize: 19,
        ),
      ),
    ],
  );
}

Widget getCategories() {
  return SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(
          categories.length,
          (index) => Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CategoryBox(
                  data: categories[index],
                ),
              )),
    ),
  );
}
