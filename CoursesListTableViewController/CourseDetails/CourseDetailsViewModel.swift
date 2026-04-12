import Foundation

protocol CourseDetailsViewModelProtcol {
    var courseName: String { get }
    var numberOfLessons: String { get }
    var numbersOfTests: String { get }
    var imageData: Data? { get }
    var isFavorite: Bool { get }
    var viewModelDidChange: ((CourseDetailsViewModelProtcol) -> Void)? { get set }
    //  Для отображения данных нам понадобится экземпляр модели, поэтому необходим инициализатор
    init(course: Product)
    func favoriteButtonPressed()
}

//  Модель представления (сущность, которая описывает интерфейс)
class CourseDetailsViewModel: CourseDetailsViewModelProtcol {
    var courseName: String {
        course.name
    }
    
    var numberOfLessons: String {
        "Number of lessons: \(course.numberOfTests)"
    }
    
    var numbersOfTests: String {
        "Number of tests: \(course.numberOfTests)"
    }
    
    var imageData: Data? {
        ImageManager.shared.fetchImageData(from: course.imageURL)
    }
    
    var viewModelDidChange: ((any CourseDetailsViewModelProtcol) -> Void)?
    
    var isFavorite: Bool {
        get {
            DataManager.shared.getFavoriteStatus(for: course.name)
        } set {
            DataManager.shared.setFavoriteStatus(for: course.name, with: newValue)
            //  Возвращаем обновлённое состояние модели
            viewModelDidChange?(self)
        }
    }
    //  Делаем приватным, т.к. View знает про свою модель представления, View обращается к своей модели представления напрямую, но при этом View не должна знать про свою модель, поэтому мы прячем её.
    private let course: Product
    
    required init(course: Product) {
        self.course = course
    }
    
    func favoriteButtonPressed() {
        isFavorite.toggle()
    }

}
