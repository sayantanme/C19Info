//
//  NetworkManager.swift
//  C19Info
//
//  Created by Sayantan Chakraborty on 24/04/21.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchO2Data(completionHandler:@escaping (Result<OxygenData,Error>)->Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    private var urlProvider: URLProvider = Constants()
    
    func fetchO2Data(completionHandler: @escaping (Result<OxygenData, Error>) -> Void) {
        if let url = URL(string: urlProvider.getOxyGenURL()) {
            URLSession.shared.dataTask(with: url) { result in
                switch result {
                case .success((_, let data)) :
                    let resultData = try! JSONDecoder().decode(OxygenData.self, from: data)
                    completionHandler(.success(resultData))
                    
                case .failure(let error):
                    print(error)
                }
            }.resume()
        }
    }
    
}


extension URLSession {
    /// url session method which converts the responses into Result type.
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse,Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
    
    /// urlsession download task implementation with Result type wrapper.
    func downloadtask(with url: URL, result: @escaping (Result<URL, Error>) -> Void) -> URLSessionDownloadTask {
        return downloadTask(with: url) { (url, response, error) in
            if let error = error {
                result(.failure(error))
            }
            guard let _ = response, let localurl = url else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success(localurl))
        }
    }
}
