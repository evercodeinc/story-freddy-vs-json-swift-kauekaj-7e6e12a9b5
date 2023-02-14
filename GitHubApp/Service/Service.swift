import Foundation

struct Service {
    
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }
    
    func fetchList(of user: String, completion: @escaping ([Repository]?) -> Void) {
        
        let url: URL = URL(fileURLWithPath: "https://api.github.com/users/\(user)/repos")
        
        network.performGet(url: url) { data in
            
            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            let repositoryList = try? decoder.decode([Repository].self, from: data)
            
            completion(repositoryList)
        }
    }
}
