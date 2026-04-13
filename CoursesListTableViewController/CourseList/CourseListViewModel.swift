import UIKit

protocol CourseListViewModelProtcol {
    func fetchCourses(completion: @escaping() -> Void)
    func numberOfRows() -> Int
    func getCourseCellViewModel(at indexPath: IndexPath) -> CourseCellViewModelProtcol
    func getCourseDetailsViewModel(at indexPath: IndexPath) -> CourseDetailsViewModelProtcol
}

class CourseListViewModel: CourseListViewModelProtcol {
    private var courses: [Product] = []
    
    func fetchCourses(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData { [unowned self] courses in
            self.courses = courses
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        courses.count
    }
    
    func getCourseCellViewModel(at indexPath: IndexPath) -> any CourseCellViewModelProtcol {
        CourseCellViewModel(course: courses[indexPath.row])
    }
    
    func getCourseDetailsViewModel(at indexPath: IndexPath) -> any CourseDetailsViewModelProtcol {
        CourseDetailsViewModel(course: courses[indexPath.row])
    }
}
