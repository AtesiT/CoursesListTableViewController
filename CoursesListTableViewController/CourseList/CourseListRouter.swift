import UIKit
@objc protocol CourseListRoutingLogic {
    // func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol CourseListDataPassing {
    var dataStore: CourseListDataStore? { get }
}

class CourseListRouter: NSObject, CourseListRoutingLogic, CourseListDataPassing {
    weak var viewController: CourseListViewController?

    var dataStore: CourseListDataStore?
}
