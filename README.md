# News Flutter

This app will show the latest news to users.

### Flutter SDK used

Flutter 3.3.6 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 6928314d50 (1 year, 5 months ago) • 2022-10-25 16:34:41 -0400
Engine • revision 3ad69d7be3
Tools • Dart 2.18.2 • DevTools 2.15.0

### Clean Architecture with MVVM
In Clean Architecture we have data domain and presentation layer
![CleanArchitectureLayers](https://github.com/SaurabhS120/news_flutter/assets/70626113/1ec19f43-fa06-4171-9415-1c1cf07f3f25)
#### Domain layer:
Domain layer is Innermost layer of clean architecture which contains Plain data models, Repository abstractions/interfaces and Usecases.
Usecases are mediator between presentation and domain later which will be used to store and retrive data. Each usecase will call repository functions in order tp perform operations.
The required repository will be provided to each usecase by using Dependency Injection techniques.

#### Data layer
Data layer is contails the actual implementation of domain layer repositories. Here we have the actual code and calls for database or network. Dio or sql conntection oojects.
We have entities are the objects which can be used in database or api technologies like JSON objects for retrofit. we will also have transformations mehods for these entities by which these objects can be convrted to domain layer models before sending back to domain layer through repository.

#### Presentation Layer
Presentation layer contains all UI which is responsible for communication and interaction with user. In order to fetch required data presentatstion layer will call usecases which will take responsiblity of implementations. 

### MVVM:
MVVM stands for Model View ViewModel architecture.
#### Model
These are Plain data models which we have implemented in domain layer models. These can also contain buisness logic like validations, calculations, filter, compare functions
#### ViewModel
ViewModel contains the state and operations of the page. Eg. When we will open News page, we will call getNews() function from view model who will take responsiblity of fetching data. After gathring data it will store it and will notify to view pages to update UI. Because of this if pages are rebuilt we will show same state from view model which will give us better performance.
#### View
View contains ui which will be visible to user. It will only contain UI implementations and for all operations it will call view model and will listen data from it. This will provide us better seperation of concerns.

### Documentation
We have added documentation for each function for easy understanding.
In dart all comments with triple slash /// gets added into documentation.
By hovering on any function in android studio we can get information about their uses
![Screenshot 2024-03-11 100541](https://github.com/SaurabhS120/news_flutter/assets/70626113/3e4f13f9-8e29-4b66-a474-746eae5e224c)

#### Dart documentation
We can also generate dart documentations for each layer for our use. Here are the steps mentioned
1. You will need to navigate to the module by using cd command for which you want to generate documentation
2. Execute *dart doc* command which will generate documentations
![Screenshot 2024-03-11 101653](https://github.com/SaurabhS120/news_flutter/assets/70626113/3116e63a-2c40-457e-bc09-ead2ec985fcb)
3. Install dhttpd (if not already installed):
Open your terminal and run the following command to install the dhttpd package globally:
pub global activate dhttpd
4. Execute following command to host project documentation locally
dhttpd --path ./doc/api
![Screenshot 2024-03-11 101702](https://github.com/SaurabhS120/news_flutter/assets/70626113/7b770b92-2810-41cd-9bce-7adf74f0a222)
5. Open http://localhost:8080/ url into your browser.
![Screenshot 2024-03-11 102136](https://github.com/SaurabhS120/news_flutter/assets/70626113/2d92e4e4-d205-4a5c-b91b-635ec2ee5fc5)
