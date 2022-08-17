# listme

Flutter Version : 2.10.3 \n
Dart Version : 2.16.0



Home Screen :: Bottom Nav 
                  with three tabs : 
                  [Post Screen default)
                  [USERS LIST SCREEN]
                  [TODOD SCREEN]
      The bottom Nav is minimally animated using AnimatedContainer widget.
      
      
ALL the data is Fetched from API.
     I have used Threading , using (ISolates.spwan(), method  that has significantly reduced the data fetching via HTTP)
     All the fetched data are stored in HIVE . 
     If there is no Internet (checked using SOCKETEXCEPTION class), then the data is shown from HIVE else directly from web.
     
POST SCREEN , contains POST data in TILES, there is an Animated pop up  at init, thatdirects to tap on individual TILE to open Comment Widget.
Comment Widget is a ModalBottomSheet widget that allows to See and POST Comment.



USER TAB, consists of List of USERS arranged in List of Tiles: 
On tapping Each tile, you will be directed to User Detail Page: 
  User Detail Page Contains , data if user(basic information and stored in hive, for offline use)
  There two buttons in detail pages : 
      i) ALBUMS = > LIST of Images on basis of USER ID (To be done)
      ii) POSTS =>> Same as Above post but the posts are on basis of USerID
