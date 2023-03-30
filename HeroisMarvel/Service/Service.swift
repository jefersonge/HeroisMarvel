//
//  MarvelAPI.swift
//  
//
//  Created by Jeferson Dias dos Santos on 08/10/22.
//

import Foundation

import Alamofire
import SwiftHash

class Service {
    static private let basePath = "https://gateway.marvel.com/v1/public/characters?"
    static private let privateKey = "a0def3abf5a7fc9754502068987739f15df2bb47"
    static private let publicKey = "bc27dfea01638cbcef2e9cf89f0d96a7"
    static private let limit = 50
    
    
    class func loadHeros(name: String?, page: Int = 0, onComplete: @escaping (MarvelInfo?) -> Void) {
        let offset = page * limit
        let startsWith: String
        if let name = name, !name.isEmpty {
            startsWith = "nameStartsWith=\(name.replacingOccurrences(of: " ", with: ""))&"
        }else {
            startsWith = ""
        }
        
        let url = basePath + "offset=\(offset)&limit=\(limit)&" + startsWith + getCredentials()
        
        AF.request(url).response { response in

            guard let data = response.data else {
                onComplete(nil)
                return
            }
            do {
                let marvelInfo = try JSONDecoder().decode(MarvelInfo.self, from: data)
                onComplete(marvelInfo)
            } catch {
                print(String(describing: error))
                print(error.localizedDescription)
                onComplete(nil)
            }
        }
    }
    
    private class func getCredentials() -> String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(ts+privateKey+publicKey).lowercased()
        return "ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    }
    
}
