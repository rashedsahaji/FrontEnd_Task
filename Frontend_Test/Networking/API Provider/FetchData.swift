//
//  FetchData.swift
//  Frontend_Test
//
//  Created by Big oh on 02/04/22.
//

import Foundation

class RestManger{
    static let shared = RestManger()
    func fetchData(pagination:Bool = false, from urlString: String, method: String, completion: @escaping (MyResult) -> Void ){
            let url = URL(string: urlString)

            guard let requestURL = url else{return}
            var request = URLRequest(url: requestURL)
            request.httpMethod = "\(method)"
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                var result: MyResult?
                do {
                    result = try JSONDecoder().decode(MyResult.self, from: data)
                }
                catch {
                    print(error)
                }
                guard let output = result else { return }
                completion(output)
            }
            dataTask.resume()
        }
}
