//
//  MealListTableViewCell.swift
//  Fetch-TakeHome-Programmatic
//
//  Created by Phil Pilosi on 6/12/23.
//

import UIKit

class MealListTableViewCell: UITableViewCell {
    
    private lazy var mealThumbnail: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var mealNameLabel: UILabel = {
        let mealLabel = UILabel()
        mealLabel.translatesAutoresizingMaskIntoConstraints = false
        mealLabel.font = .systemFont(ofSize: 20, weight: .regular)
        mealLabel.numberOfLines = 0
        return mealLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //heightAnchor.constraint(equalToConstant: 120).isActive = true
        setupMealThumbnail()
        setupMealLabel()
    }
    
    
    func setupMealThumbnail() {
        self.addSubview(mealThumbnail)
        NSLayoutConstraint.activate([
            mealThumbnail.heightAnchor.constraint(equalToConstant: 100),
            mealThumbnail.widthAnchor.constraint(equalToConstant: 100),
            mealThumbnail.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            mealThumbnail.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setupMealLabel() {
        self.addSubview(mealNameLabel)
        NSLayoutConstraint.activate([
            mealNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            mealNameLabel.leadingAnchor.constraint(equalTo: mealThumbnail.trailingAnchor, constant: 10),
            mealNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20)
        ])
    }
    
    public func configureCell(with mealData: MealDataModel) {
        mealNameLabel.text = mealData.mealName
        if let thumbnailURL = URL(string: mealData.mealThumbnail) {
            mealThumbnail.load(url: thumbnailURL, placeholder: UIImage(named: "Cupcake"))
        } else {
            mealThumbnail.image = UIImage(named: "Cupcake")
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
