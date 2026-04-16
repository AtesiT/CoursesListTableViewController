import Foundation

class Box<T> {
    //  Делаем typealias для работы как с обычным типом данных
    typealias Listener = (T) -> Void
    
    var value: T {
        //  Как только меняется значение value, то мы обращаемся к listener и помещаем обновленное значение
        didSet {
            listener?(value)
        }
    }
    
    private var listener: Listener?
    
    init(value: T) {
        self.value = value
    }
    
    //  Возвращает наш value
    func bind(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
}
