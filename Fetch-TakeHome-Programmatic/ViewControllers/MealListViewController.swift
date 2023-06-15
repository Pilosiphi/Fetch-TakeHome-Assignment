//
//  MealListViewController.swift
//  Fetch-TakeHome-Programmatic
//
//  Created by Phil Pilosi on 6/12/23.
//

import UIKit

class MealListViewController: BaseViewController {
    
    var mealList = [MealDataModel]()

    //Lazy load Tableview to display list of Meals.
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .black
        tableView.separatorInset = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        tableView.largeContentTitle = "Desserts"
        return tableView
    }()
    
    let loadingVC = LoadingViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Desserts"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        retrieveMealList()
    }
    
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
        
        tableView.register(MealListTableViewCell.self, forCellReuseIdentifier: Constants.TableViewCellIdentifiers.mealListTableViewCellIdentifier)
    }
    
    func retrieveMealList() {
        let mealListDataRequest = MealAPI.sharedInstance.createMealListRequest(category: "Dessert")
        MealAPI.sharedInstance.getMealListData(with: mealListDataRequest) { [weak self] (data, error) in
            guard let weakSelf = self,
                  let mealListData = data as? MealListDataModel else {
                //TODO:Add Error notification logic here.
                return
                
            }

            weakSelf.mealList = mealListData.mealList
            DispatchQueue.main.async {
                weakSelf.tableView.reloadData()
            }
        }
    }
    
    func retrieveMealDetailedInfo(withMeal meal: MealDataModel) {
        let mealDetailRequest = MealAPI.sharedInstance.createMealDetailRequest(mealID: meal.mealID)
        MealAPI.sharedInstance.getMealDetailData(with: mealDetailRequest) { [weak self] (data, error) in
            guard let weakSelf = self else { return }
            
            guard let mealDetailData = data as? MealDetailedInfoDataModel else {
                DispatchQueue.main.async {
                    weakSelf.dismiss(animated: true)
                }
                //TODO: Display error message here.
                return
            }
            
            DispatchQueue.main.async {
                weakSelf.loadingVC.dismiss(animated: true) {
                    weakSelf.transitionToMealDetailViewController(withMeal: mealDetailData)
                }
            }
        }
    }

    func transitionToMealDetailViewController(withMeal meal: MealDetailedInfoDataModel) {
        let mealDetailViewController = MealDetailViewController(withMealData: meal)
        navigationController?.pushViewController(mealDetailViewController, animated: true)
    }
}

extension MealListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        retrieveMealDetailedInfo(withMeal: mealList[indexPath.row])
        
        // Animate loadingVC over the existing views on screen
        loadingVC.modalPresentationStyle = .overCurrentContext

        // Animate loadingVC with a fade in animation
        loadingVC.modalTransitionStyle = .crossDissolve
               
        present(loadingVC, animated: true, completion: nil)
    }
}

extension MealListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let mealTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCellIdentifiers.mealListTableViewCellIdentifier, for: indexPath) as? MealListTableViewCell else { return UITableViewCell() }
        
        mealTableViewCell.configureCell(with: mealList[indexPath.row])
        return mealTableViewCell
    }
}


























