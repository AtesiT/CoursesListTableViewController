import UIKit

@objc protocol CourseDetailsRoutingLogic {
    
}

protocol CourseDetailsDataPassing {
    var dataStore: CourseDetailsDataStore? { get }
}

class CourseDetailsRouter: NSObject, CourseDetailsRoutingLogic, CourseDetailsDataPassing {
    
    weak var viewController: CourseDetailsViewController?
    var dataStore: CourseDetailsDataStore?
}
