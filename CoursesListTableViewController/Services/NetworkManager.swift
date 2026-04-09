import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let api = "https://dummyjson.com/products"
    
    private init() {}
    
    func fetchData(completion: @escaping (_ courses: [Product]) -> Void) {
        guard let url = URL(string: api) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No Description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Course.self, from: data)
                DispatchQueue.main.async {
                    completion(response.products)
                }
            } catch let error {
                print("You have the error:", error)
            }
            
            
        }.resume()
    }
    
}
