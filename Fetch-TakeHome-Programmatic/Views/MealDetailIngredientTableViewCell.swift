//
//  MealDetailsIngredientTableViewCell.swift
//  Fetch-TakeHome-Programmatic
//
//  Created by Phil Pilosi on 6/14/23.
//

import UIKit

class MealDetailIngredientTableViewCell: UITableViewCell {
    
    private lazy var nameLabel: UILabel = {
        let ingredientLabel = UILabel()
        ingredientLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientLabel.font = .systemFont(ofSize: 20)
        ingredientLabel.textAlignment = .left
        return ingredientLabel
    }()
    
    private lazy var measurementLabel: UILabel = {
        let measurementLabel = UILabel()
        measurementLabel.translatesAutoresizingMaskIntoConstraints = false
        measurementLabel.font = .systemFont(ofSize: 20)
        measurementLabel.textAlignment = .right
        return measurementLabel
    }()
    
    func setupIngredientCell() {
        addSubview(nameLabel)
        addSubview(measurementLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 2),
            
            measurementLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            measurementLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            measurementLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            nameLabel.rightAnchor.constraint(equalTo: measurementLabel.leftAnchor, constant: 10)
        ])
    }
    
    func configureCell(withName name: String, andMeasurement measurement: String){
        nameLabel.text = name
        measurementLabel.text = measurement
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupIngredientCell()
        selectionStyle = .none
    }
}
