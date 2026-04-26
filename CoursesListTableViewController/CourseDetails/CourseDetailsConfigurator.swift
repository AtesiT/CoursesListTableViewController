import Foundation

final class CourseDetailsConfigurator: CourseDetailsConfiguratorInputProtocol {
    static let shared = CourseDetailsConfigurator()
    
    private init () {}
    
    func configure(withView view: CourseDetailsViewController, and course: Course) {
        let interactor = CourseDetailsInteractor()
        let presenter = CourseDetailsPresenter()
        let router = CourseDetailsRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
