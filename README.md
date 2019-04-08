# Marvel - Mobile Exercise #

This is a iOS app created using Swift and the [Marvel Developer API](https://developer.marvel.com/).
You can search and save the chracteres you like most.

### Architecture

This app is using `MVVM`, with `Interactor (Called Logic in this project)` and `Routers`, taking advantage of `Coordinators` no navigate between screens.
All the `UIKit` stuff are only at `Coordinators` and `UIViewControllers`. The app's core do not rely on UIKit.

The data flow starts from the user interface on the screen to the ViewModel then to the Logic class and then to the router's class when we need to go to another screen. The service layer is injected into the Logic, so it's easy to replace  network calls with mocked jsons.

### Features

This project takes advantage of `Protocols` and `Generics` to reuse views and cells. Using this swift features we avoid typos when using `reuseIdentifiers`. 

### Pods
pod 'PureLayout' - Less verbose Auto-Layout constraints: `myView.autoPinEdgesToSuperviewEdges()`.
pod 'CCBottomRefreshControl' - Add a activity indicator at the bottom of UIScrollView (UITableView, UICollectionView). Because [ANGTFT](https://www.youtube.com/watch?v=pzZOc05BFHE), I'm kidding, I have a [lib](https://github.com/FelipeCardoso89/UILoadControl) that do that but its not on swift 5 yet and I had no time to implement it again at this moment. 

### How to install

* Clone or download the project to your machine.
* At the project directory run: ```pod install```.
* Open XCode10 and build the project using: ```Cmd```+ ```Shift``` + ```B```.
* Build the project for testing using: ```Cmd```+ ```Shift```+ ```U```.
* Run the tests using: ```Cmd``` + ```U```
