import Foundation

struct Course: Decodable {
    let products: [Product]
}

struct Product: Decodable {
    let name: String
    let imageUrl: URL
    let numberOfLessons: Double
    let numberOfTests: Double
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case imageUrl = "thumbnail"
        case numberOfLessons = "price"
        case numberOfTests = "rating"
    }
}
