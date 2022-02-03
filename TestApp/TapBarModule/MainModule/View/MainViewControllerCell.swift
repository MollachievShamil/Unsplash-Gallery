//
//  MainViewControllerCell.swift
//  TestApp
//
//  Created by Шамиль Моллачиев on 02.02.2022.


import UIKit

class MainViewControllerCell: UICollectionViewCell {

    var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setConstraints()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setConstraints() {
        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
    }
}

