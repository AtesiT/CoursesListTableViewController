protocol CourseListConfiguratorImputProtocol {
    func configure(withView view: CourseListViewController)
}

class CourseListConfigurator: CourseListConfiguratorImputProtocol {
    func configure(withView view: CourseListViewController) {
        let presenter = CourseListPresenter(view: view)
        let interactor = CourseListInteractor(presenter: presenter)
        let router = CourseListRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
