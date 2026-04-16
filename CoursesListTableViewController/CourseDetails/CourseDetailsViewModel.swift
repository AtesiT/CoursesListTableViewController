import Foundation

protocol CourseDetailsViewModelProtcol {
    var courseName: String { get }
    var numberOfLessons: String { get }
    var numbersOfTests: String { get }
    var imageData: Data? { get }
    var isFavorite: Box<Bool> { get }
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
    
    var isFavorite: Box<Bool>
    
    //  Делаем приватным, т.к. View знает про свою модель представления, View обращается к своей модели представления напрямую, но при этом View не должна знать про свою модель, поэтому мы прячем её.
    private let course: Product
    
    required init(course: Product) {
        self.course = course
        isFavorite = Box(value: DataManager.shared.getFavoriteStatus(for: course.name))
    }
    
    func favoriteButtonPressed() {
        isFavorite.value.toggle()
        DataManager.shared.setFavoriteStatus(for: course.name, with: isFavorite.value)
    }
}
