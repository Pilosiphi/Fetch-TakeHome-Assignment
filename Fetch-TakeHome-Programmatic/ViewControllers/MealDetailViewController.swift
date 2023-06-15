//
//  MealDetailViewController.swift
//  Fetch-TakeHome-Programmatic
//
//  Created by Phil Pilosi on 6/12/23.
//

import UIKit

class MealDetailViewController: BaseViewController {
    
    
    var mealDetailDataSource: MealDetailedInfoDataModel?
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .black
        tableView.separatorInset = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        return tableView
    }()
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(MealDetailInstructionsTableViewCell.self, forCellReuseIdentifier: Constants.TableViewCellIdentifiers.mealDetailInstructionTableViewCellIdentifier)
        tableView.register(MealDetailIngredientTableViewCell.self, forCellReuseIdentifier: Constants.TableViewCellIdentifiers.mealDetailIngredientTableViewCellIdentifier)
        
    }
    
    init(withMealData mealDetailDataSource: MealDetailedInfoDataModel) {
        super.init(nibName: nil, bundle: nil)
        self.mealDetailDataSource = mealDetailDataSource
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupTableView()
        
    }
    
    func setupViewController() {
        guard let mealDetailData = mealDetailDataSource else { return }
        title = mealDetailData.mealName
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension MealDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let mealDetailData = mealDetailDataSource else { return 1 }
        return 1 + mealDetailData.mealIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == indexPath.first) {
            //Instruction cell.
            guard let mealDetailInstructionsTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellIdentifiers.mealDetailInstructionTableViewCellIdentifier,
                                                                                          for: indexPath) as? MealDetailInstructionsTableViewCell,
                  let mealDetailData = mealDetailDataSource else { return UITableViewCell() }
            mealDetailInstructionsTableViewCell.configureCell(withMeal: mealDetailData)
            return mealDetailInstructionsTableViewCell
            
        } else {
            guard let ingredientTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellIdentifiers.mealDetailIngredientTableViewCellIdentifier,
                                                                                          for: indexPath) as? MealDetailIngredientTableViewCell,
                  let mealDetailData = mealDetailDataSource else { return UITableViewCell() }
            
            let currentIngredient = mealDetailData.mealIngredients[indexPath.row - 1]
            let currentMeasurement = mealDetailData.mealIngredientQuantity[indexPath.row - 1]
            ingredientTableViewCell.configureCell(withName: currentIngredient, andMeasurement: currentMeasurement)
            return ingredientTableViewCell
        }
    }
}

extension MealDetailViewController: UITableViewDelegate {
    
}
