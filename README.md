# NasaApp
Show space images from NASA

iOS application created by using below methodologies:

- Coordinator pattern for navigation.
- MVVM architecture for cleaner View controllers.
- RxSwift for communication between VC and VM.

- SorryBoard is been completely removed from the app. In the SceneDelegate the MainCoordinator instance is created which holds the navigation controller.
- MainCoordinator has start method which launches the GridViewController. This is our first VC which shows the list of all the images fetched from a LocalJSON file.
- NASAImageService is a DAO class. It fetches data from the local data.JSON file and feed it to the requestor.
- NasaImage is a DTO object. It represents the structure of the JSON objects.
- Users interaction of the GridVC are bonded to the VM using RxSwift. There are 2 events. "viewDidLoad" and "tappedOnCell".
- The GridVM loads the images upon the didLoad event and upon tappedOnCell event it asks the coordinator to navigate to the detailVC.
- In DetailVC a 3rd party controller (InfiniteScrollView) is used to display the selected image details.
- The DetailVC follows the dataSource and delegate protocol of the InfintieScrollView. 

Tests:
- The app has test cases written to test the GridVM. Test cases evaluates a VM's output based on the input supplied.

Known Bugs in the project:
- There are few warnings in our pod projects.
- When user selects any image instead of that, the image at first index is shown in the DetailVC. The Infinite scrollView don't have a set index method due to which this happens.

Scope for enhancement;
- We can use UIPageViewController to simulate the effect of infinite scrolling. This way we will also reduce our dependency on the third party components.
- We can host the JSON file on jsonPlaceholder kind of site and fetch the data from there. 
- We can have option for addition of new data and modification of any existing image data.
- Dark and Light mode differentiation can be added to this.
- Local authentication using FaceID/TouchID can be added.
- UI Test cases can be added.

