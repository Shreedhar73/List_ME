import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../commons/styles.dart';
import '../cubits/image_cubit.dart';


class AnimatedCarousel extends StatefulWidget {
  const AnimatedCarousel({ Key? key,this.data }) : super(key: key);
  static const routeName = '/animatedCarousel';
  // ignore: prefer_typing_uninitialized_variables
  final data;
  @override
  State<AnimatedCarousel> createState() => _AnimatedCarouselState();
}

class _AnimatedCarouselState extends State<AnimatedCarousel> {
  var imageList = [];
  final imageCubit = ImageCubit();
  PageController pageViewController = PageController();
  @override
  void initState() {
    imageCubit.getImage(widget.data.id);
    super.initState();
  }
  @override
  void dispose() {
    imageCubit.close();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
      ),
      body: StreamBuilder(
        stream: imageCubit.stream,
        builder: (context,snapshot) {
          if(snapshot.hasData){
           var data = snapshot.data as List;
            data.forEach((element) {
            if(element.albumId == widget.data.id){
              imageList.add(element.url.toString()+".png");
            }
          });
          return DismissiblePage(
            backgroundColor: black,
            onDismissed: (){
              Navigator.pop(context);
            },
            behavior: HitTestBehavior.translucent,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: black,
                body: Stack(
                children: [
                    PhotoViewGallery.builder(
                      scrollPhysics: const ClampingScrollPhysics(),
                      builder: (BuildContext context, int index) {
                        return PhotoViewGalleryPageOptions(
                          maxScale: PhotoViewComputedScale.contained * 4,
                          minScale: PhotoViewComputedScale.contained * 1,
                          initialScale: PhotoViewComputedScale.contained * 1,
                          imageProvider: CachedNetworkImageProvider(imageList[index % imageList.length]),
                          heroAttributes: PhotoViewHeroAttributes(tag: imageList[index]),
                        );
                      },
                      itemCount: imageList.length,
                      loadingBuilder: (context, event) => const Center(
                        child: SizedBox(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      backgroundDecoration: const BoxDecoration(
                        color: black,
                      ),
                      pageController: pageViewController,
                    ),
                    //current index indicator
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
                        width: MediaQuery.of(context).size.width,
                        child: SmoothPageIndicator(  
                            controller: pageViewController,
                            count: imageList.length,  
                            effect: ExpandingDotsEffect(
                              activeDotColor: white,
                              dotColor: grey.withOpacity(0.3),
                              dotHeight: 8,
                              dotWidth: 8,
                              expansionFactor: 2
                            ) 
                        ),
                      ),
                    ),
                    //close button
                  ],
                ),
              ),
            ),
          );}else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      ),
    );
  }
}