//
//  ItunesAPI.swift
//  AppleAppStore
//
//  Created by skillist on 2021/12/15.
//

import Foundation

class ItunesAPI {
    static var dataTask: URLSessionDataTask?
    
    static var itunesURLComponents: URLComponents {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "itunes.apple.com"
        return urlComponent
    }
    
    //https://itunes.apple.com/search?entity=software&term=
    static func searchApps(term: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var urlComponents = itunesURLComponents
        urlComponents.path = "/search"
        urlComponents.queryItems = [
            URLQueryItem(name: "entity", value: "software"),
//            URLQueryItem(name: "term", value: term.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
            URLQueryItem(name: "term", value: term)
        ]
        
        guard let url = urlComponents.url else {
            return
        }
        print("url : \(url.description)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: completionHandler)
        dataTask?.resume()
    }
}
