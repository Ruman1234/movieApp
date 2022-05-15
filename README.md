# movieApp

**Used design pattern and App architecture**
I use MVVM architecture with the help of protocol approach 

**Code Structure**
VM have a weak refrence for preventing retain cycle
This code have all basic utilities for handling data

**User guide to use the app**
There is a tab bar which have 3 itmes 
**  home **
  home screen have all movies list
  on click on favorrite button it will save data to local memory
  on click on movie it will show you details screen
**favorite**
  this screen have all user favorite movies
  
**  Search**
  with the help of this screen user can search any movie

**Developer Notes**

**Third parties**

Alamofire
DropDown
ObjectMapper
Reachability
RXswift
SwiftyJson

**Unit test**

Every Utility class have its test
Api call is testing with live server and by local as well with the help of loadLocally parameter
