//
//  HeroesTableViewController.swift
//  HeroisMarvel
//
//  Created by Eric Brito on 22/10/17.
//  Copyright © 2017 Eric Brito. All rights reserved.
//

import UIKit

class HeroesTableViewController: UITableViewController {
    
    //MARK: - Variables
    var name: String?
    let viewModel = HeroesTableViewModel()
    
    
    //MARK: - Label Loading
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        label.text = "Buscando Heróis. Aguarde..."
        viewModel.loadHeroes(name: name)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //NextViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! HeroViewController
        vc.hero = viewModel.loadHero(indexPathRow: tableView.indexPathForSelectedRow!.row)
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = viewModel.numberOfRows == 0 ? label : nil
        return viewModel.numberOfRows
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HeroesTableViewCell
        
        let hero = viewModel.loadHero(indexPathRow: indexPath.row)
        cell.setupCell(with: hero)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //se o numero da linha mostrada for igual numero de herois ja carregados-10 e se nao estiver carregando herois e se a contagem de herois carregados ainda nao for o total, acrescenta uma pagina e carrega mais herois
        viewModel.loadHeroList(indexPath: indexPath, name: name ?? "")
    }
}

//MARK: - HeroesTableViewModelDelegate
extension HeroesTableViewController: HeroesTableViewModelDelegate{
    func updateLabel() {
        self.label.text = "Não foram encontrados heróis com o nome \(self.name!)"
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
}
