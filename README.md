# listme

Flutter Version : 2.10.3
Dart Version : 2.16.0


Project Structure:

![image](https://user-images.githubusercontent.com/53093990/185200732-6ded7bca-70a6-4bf6-b41f-4a6c4325e2cc.png)




Flow Of App: 

SplashScreen :
    Use of Animated Container and Animated Opacity to Animate Screen to a Extent

HomeScreen :
    Containes BottomNav Bar with Three Bottom Nav Items:
       Bottom Nav bar is Animated using Animated Container Widget
    Three Tabs :
        Posts : 
          Shows List of Posts in Listview Builder:
            On Tapping Each List: A ModalBottom Sheet opens That Displays the List of Comments as per Post ID.
        
        
        Users: 
          Shows List Of Users:
              On Tapping Each Items: Routes to User Detail Page:
              User Details Page Contains some generic info and two buttons :
                    Albums: (On Click Routes to List of Albums Page)
                    Posts :: Routes to Post List page(where post are on userID Basis)
        
        ToDO: 
            Shows List of TODO's from API
            
  
  Statemanagement Tool:
  Bloc/ Flutter_bloc,,,  use of cubits
  
  
  
  Performance Tuning: 
    Multithreading using, ISOLATES.SPWAN method. after api call, the model json serilization and Model mapping are done in different Isolate.
    Thus , The network performance is significantly Fast.
    
    
   Bloc , Cubits are used to Convert API response into Data Stream.
   
   
   Github Actions: 
   [rootdirectory/.github/workflows/CI.yml], contains yml file where workflow for github actions are written.
   
   On every push on Master Branch, Github Actions will automate the app build process and store the built apk for Android on Releases Sections.
   
    
   





