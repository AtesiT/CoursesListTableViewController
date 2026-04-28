protocol CourseListPresentationLogic {
    func presentCourses(response: CourseList.ShowCourses.Response)
}

class CourseListPresenter: CourseListPresentationLogic {

    weak var viewController: CourseListDisplayLogic?

    func presentCourses(response: CourseList.ShowCourses.Response) {
        let rows: [CourseCellViewModelProtcol] = response.courses.map {
            CourseCellViewModel(course: $0)
        }
        let viewModel = CourseList.ShowCourses.ViewModel(rows: rows)
        viewController?.displayCourses(viewModel: viewModel)
    }
}
