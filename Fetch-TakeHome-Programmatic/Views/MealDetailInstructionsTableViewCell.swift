//
//  MealDetailInstructionsTableViewCell.swift
//  Fetch-TakeHome-Programmatic
//
//  Created by Phil Pilosi on 6/12/23.
//

import UIKit

class MealDetailInstructionsTableViewCell: UITableViewCell {

    private lazy var mealInstructionLabel: UILabel = {
        let mealLabel = UILabel()
        mealLabel.translatesAutoresizingMaskIntoConstraints = false
        mealLabel.font = .systemFont(ofSize: 20, weight: .regular)
        mealLabel.numberOfLines = 0
        return mealLabel
    }()
    
    
    func setupInstructionCell() {
        self.addSubview(mealInstructionLabel)
        NSLayoutConstraint.activate([
            mealInstructionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            mealInstructionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            mealInstructionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            mealInstructionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInstructionCell()
    }
    
    public func configureCell(withMeal meal: MealDetailedInfoDataModel){
        mealInstructionLabel.text = meal.mealInstructions
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
