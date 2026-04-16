import Foundation

class Box<T> {
    var value: T
    
    private var listener: ((T) -> Void)?
    
    init(value: T) {
        self.value = value
    }
}
