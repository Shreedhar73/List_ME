# listme

Flutter Version : 2.10.3
Dart Version : 2.16.0


Project Structure:

![image](https://user-images.githubusercontent.com/53093990/185200732-6ded7bca-70a6-4bf6-b41f-4a6c4325e2cc.png)




##Flow Of App: 

#SplashScreen :
    Use of Animated Container and Animated Opacity to Animate Screen to a Extent
    
    

   ##HomeScreen :
         Containes BottomNav Bar with Three Bottom Nav Items:
            Bottom Nav bar is Animated using Animated Container Widget
        
        <B>Three Tabs :
        #Posts : 
          Shows List of Posts in Listview Builder:
            On Tapping Each List: A ModalBottom Sheet opens That Displays the List of Comments as per Post ID.
        
        
        #Users: 
          Shows List Of Users:
              On Tapping Each Items: Routes to User Detail Page:
              User Details Page Contains some generic info and two buttons :
                    Albums: (On Click Routes to List of Albums Page)
                    Images: Are Shown in Carousel , can be swipped infinitely, swpie down to dismiss and zoom in and out
                    Posts :: Routes to Post List page(where post are on userID Basis)
        
        #ToDO: 
            Shows List of TODO's from API
            
            
 #Implemented :
        Pull to Refresh
  
  #Statemanagement Tool:
  
    Bloc/ Flutter_bloc,,,  use of cubits
  
  
  
  ##Performance Tuning: 
  
    Multithreading using, ISOLATES.SPWAN method. after api call, the model json serilization and Model mapping are done in different Isolate.
    Thus , The network performance is significantly Fast.
    
    
   Bloc , Cubits are used to Convert API response into Data Stream.
   
   
  ## Github Actions: 
   
         [rootdirectory/.github/workflows/CI.yml], contains yml file where workflow for github actions are written.
   
        On every push on Master Branch, Github Actions will automate the app build process and store the built apk for Android on Releases Sections.
        
        
    ScreenShots :
    //App Icon
![image](https://user-images.githubusercontent.com/53093990/185212288-527221a9-93e4-4afe-893e-4e2d13e78d76.png)
    
    
    //Splash(animated)
![image](https://user-images.githubusercontent.com/53093990/185211437-27f79207-0342-4254-9c37-901b36f392a6.png)


    //Home Screen
 ![image](https://user-images.githubusercontent.com/53093990/185211483-ab9ef4ec-95af-4f67-abe8-a3d5ba017d3a.png)
    
    
    //user Listing
![image](https://user-images.githubusercontent.com/53093990/185211562-1ffa3272-d3cf-4d4e-bed1-ff9384365e4e.png)

    
    //comment widget
![image](https://user-images.githubusercontent.com/53093990/185211600-0ac57482-baab-4c7c-a063-f8b6c33f3c7c.png)

    // pull to refresh
![image](https://user-images.githubusercontent.com/53093990/185317852-16949c71-aadd-4e5c-b417-39054b632102.png)




   
    
   





