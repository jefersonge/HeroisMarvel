//
//  HeroViewModel.swift
//  HeroisMarvel
//
//  Created by Jeferson Dias dos Santos on 29/03/23.
//  Copyright © 2023 Eric Brito. All rights reserved.
//

import Foundation

class HeroViewModel {
    
    func createRequest(hero: Hero?, completion: @escaping(URLRequest)-> Void){
        if let url = URL(string: hero?.urls.first!.url ?? ""){
            let request = URLRequest(url: url)
            completion(request)
        }
        
    }
}
