//
//  HeroesTableViewModel.swift
//  HeroisMarvel
//
//  Created by Jeferson Dias dos Santos on 18/03/23.
//  Copyright © 2023 Eric Brito. All rights reserved.
//

import Foundation

protocol HeroesTableViewModelDelegate{
    func updateLabel()
    func reloadData()
}

class HeroesTableViewModel{
    
    //MARK: - Variables
    var heroes: [Hero] = []
    var loadingHeroes = false
    var currentPage = 0
    var total = 0
    var delegate: HeroesTableViewModelDelegate?
    
    //MARK: - LoadHeroes
    func loadHeroes(name: String?) {
        self.loadingHeroes = true
        Service.loadHeros(name: name, page: currentPage) { (info) in
            if let info = info {
                self.heroes += info.data.results
                self.total = info.data.total
                print("Total:", self.total, "Já incluidos:", self.heroes.count)
                DispatchQueue.main.async {
                    self.loadingHeroes = false
                    self.delegate?.updateLabel()
                    self.delegate?.reloadData()
                }
            }
        }
    }
    
    //MARK: - MethodsSettingsTableView
    func loadHero(indexPathRow: Int) -> Hero {
        let hero = heroes[indexPathRow]
        return hero
    }
    
    public var numberOfRows: Int {
        return heroes.count
    }
    
    func loadHeroList(indexPath: IndexPath, name: String) {
        if indexPath.row == heroes.count - 10 && !loadingHeroes && heroes.count != total {
            currentPage += 1
            loadHeroes(name: name)
            print("Carregando mais Heróis")
        }
        
    }
}
