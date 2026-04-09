import Foundation

struct Course: Decodable {
    let products: [Product]
}

struct Product: Decodable {
    let name: String
    let imageURL: URL
    let numberOfLessons: Double
    let numberOfTests: Double
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case imageURL = "thumbnail"
        case numberOfLessons = "price"
        case numberOfTests = "rating"
    }
}
