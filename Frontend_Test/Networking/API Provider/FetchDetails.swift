//
//  FetchDetails.swift
//  Frontend_Test
//
//  Created by Big oh on 03/04/22.
//

import Foundation
class FetchDetails{
    static let shared = FetchDetails()
    func fetchData(from urlString: String, method: String, completion: @escaping (Result<ImageDetails, Error>) -> Void ){
        
        DispatchQueue.global(qos: .userInitiated).async {
            let url = URL(string: urlString)

            guard let requestURL = url else{return}
            var request = URLRequest(url: requestURL)
            request.httpMethod = "\(method)"
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                var result: ImageDetails?
                do {
                    result = try JSONDecoder().decode(ImageDetails.self, from: data)
                }
                catch {
                    print(error)
                }
                guard let output = result else { return }
                completion(.success(output))
            }
            dataTask.resume()
        }
    }
}
