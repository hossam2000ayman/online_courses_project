import 'package:flutter/material.dart';
import 'package:online_courses_project/themes/color.dart';
import 'package:online_courses_project/utils/data.dart';
import 'package:online_courses_project/widgets/custom_image.dart';
import 'package:readmore/readmore.dart';

class CourseDetails extends StatefulWidget {
  CourseDetails({required this.data});
  final data;

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late var courseData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    courseData = widget.data['course'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      elevation: 0,
      title: Text(
        'Detail',
        style: TextStyle(color: textColor),
      ),
      iconTheme: IconThemeData(color: textColor),
      centerTitle: true,
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: Column(
        children: [
          Hero(
            tag:  courseData['image'],
            child: CustomImage(
              courseData['image'],
              radius: 20,
              width: double.infinity,
              height: 200,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          getInfo(),
          SizedBox(
            height: 10,
          ),
          Divider(),
          getTabBar(),
          getTabBarPages(),
        ],
      ),
    );
  }

  Widget getTabBar() {
    return Container(
        child: TabBar(
      indicatorColor: primary,
      controller: tabController,
      tabs: [
        Tab(
          child: Text(
            'Lessons',
            style: TextStyle(fontSize: 18, color: textColor),
          ),
        ),
        Tab(
          child: Text(
            'Exercises',
            style: TextStyle(fontSize: 18, color: textColor),
          ),
        ),
      ],
    ));
  }

  Widget getLessons() {
    return ListView.builder(
      itemCount: lessons.length,
      itemBuilder: (context, index) => LessonItem(data: lessons[index]),
    );
  }

//body of tab bar
  Widget getTabBarPages() {
    return Container(
      width: double.infinity,
      height: 200,
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          getLessons(),
          Container(
            child: Center(child: Text('Exercises')),
          ),
        ],
      ),
    );
  }

  Widget getFooter() {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: shadowColor.withOpacity(0.05),
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 0),
        )
      ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Price',
                style: TextStyle(
                    color: labelColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                courseData['price'],
                style: TextStyle(
                    color: textColor,
                    fontSize: 26,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            width: 30,
          ),
          Expanded(
              child: CustomButton(
            title: 'Buy Now',
            onTap: () {},
          ))
        ],
      ),
    );
  }

  Widget getInfo() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                courseData['name'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              BookmarkBox(
                isBookmarked: courseData['is_favorited'],
                onTap: () {
                  setState(() {
                    courseData['is_favorited'] = !courseData['is_favorited'];
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              getAttribute(
                  Icons.play_circle_outline, courseData['session'], labelColor),
              SizedBox(
                width: 20,
              ),
              getAttribute(
                  Icons.schedule_outlined, courseData['duration'], labelColor),
              SizedBox(
                width: 20,
              ),
              getAttribute(Icons.star, courseData['review'], yellow),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Course',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: textColor),
              ),
              SizedBox(
                height: 10,
              ),
              ReadMoreText(
                courseData['description'],
                trimLines: 2,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'show more',
                moreStyle: TextStyle(
                    fontSize: 17, color: primary, fontWeight: FontWeight.w500),
                style: TextStyle(fontSize: 16, color: labelColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget getAttribute(IconData icon, String info, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: color,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          info,
          style: TextStyle(color: labelColor),
        ),
      ],
    );
  }
}
