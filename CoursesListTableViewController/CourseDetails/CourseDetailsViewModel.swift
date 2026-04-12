import Foundation

protocol CourseDetailsViewModelProtcol {
    var courseName: String { get }
    
    //  Для отображения данных нам понадобится экземпляр модели, поэтому необходим инициализатор
    init(course: Product)
}

//  Модель представления (сущность, которая описывает интерфейс)
class CourseDetailsViewModel: CourseDetailsViewModelProtcol {
    var courseName: String {
        course.name 
    }
    
    //  Делаем приватным, т.к. View знает про свою модель представления, View обращается к своей модели представления напрямую, но при этом View не должна знать про свою модель, поэтому мы прячем её.
    private let course: Product
    
    required init(course: Product) {
        self.course = course
    }
}
