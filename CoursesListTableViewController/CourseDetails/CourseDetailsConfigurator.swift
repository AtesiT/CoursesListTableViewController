protocol CourseDetailsConfiguratorInputProtocol {
    func configure(withView view: CourseDetailsViewController, and course: Course)
}

class CourseDetailsConfigurator: CourseDetailsConfiguratorInputProtocol {
    func configure(withView view: CourseDetailsViewController, and course: Course) {
        let presenter = CourseDetailsPresenter(view: view)
        let interactor = CourseDetailsInteractor(presenter: presenter, course: course)
        view.presenter = presenter
        presenter.interactor = interactor
    }
}
