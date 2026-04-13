import Foundation

protocol CourseListViewModelProtcol {
    #warning("TODO: private courses")
    var courses: [Product] { get }
    func fetchCourses(completion: @escaping() -> Void)
    func numberOfRows() -> Int
}

class CourseListViewModel: CourseListViewModelProtcol {
    var courses: [Product] = []
    
    func fetchCourses(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData { [unowned self] courses in
            self.courses = courses
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        courses.count
    }
    
    
}
