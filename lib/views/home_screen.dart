import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:listme/commons/styles.dart';
import 'package:listme/views/posts/posts_screen.dart';
import 'package:listme/views/user/user_screen.dart';
import 'todos/todos_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key, this.xCurrentSelected = 0 }) : super(key: key);
   final int xCurrentSelected;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  var currentIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  //list of Screens
  final _screens = [
    const PostScreen(),
    const UserScreen(),
    const TodoScreen(),
  ];
  final _bottomNavItem = ["Posts", "Users", "Todos"];
  @override
  void initState() {
    currentIndex = widget.xCurrentSelected;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Text(_bottomNavItem[currentIndex],style: gotu(white, 15),),
          centerTitle: true,
        ),
        body : _screens[currentIndex],
        bottomNavigationBar: bottomNavBar(_width)
    
      ),
    );
  }

  //bottom navigation bar widget
  Widget bottomNavBar(_width){
    return Container(
        height: kToolbarHeight+10,
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(5)
        ),
        child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _screens.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context,index)=> SizedBox(width: _width * 0.07),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  setState(
                    () {
                      currentIndex = index;    
                       _onItemTapped(currentIndex);             
                    },
                  );
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      margin: EdgeInsets.only(
                        bottom: index == currentIndex ? 0 : _width * .029,
                        right: _width * .0422,
                        left: _width * .0422,
                      ),
                      width: _width * .2,
                       height: index == currentIndex ? _width * .014 : 0,
                      decoration: const BoxDecoration(
                        color:Colors.red,
                        borderRadius:  BorderRadius.vertical(
                          bottom: Radius.circular(10),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(_bottomNavItem[index], 
                        style: GoogleFonts.jost(
                          textStyle: const TextStyle(
                            color: Colors.amber,
                              fontSize: 10
                          ),
                      ),
                      ),
                    ),
                    // Icon(
                    //   listOfIcons[index],
                    //   size: _width * .076,
                    //   color: index == currentIndex ? Colors.indigo : Colors.white,
                    // ),
                    SizedBox(height: _width * .03),
                  ],
                ),
              ),
            ),
          ),
      );
  }
}