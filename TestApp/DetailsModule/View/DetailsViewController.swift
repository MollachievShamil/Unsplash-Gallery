//
//  DetailsViewController.swift
//  TestApp
//
//  Created by Шамиль Моллачиев on 02.02.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    var presenter: DetailsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setupViews()
        setConstraints()
    }

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let autorNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Author Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateOfCreationLabel: UILabel = {
        let label = UILabel()
        label.text = "Date Of Creation"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Location"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let downloadsLabel: UILabel = {
        let label = UILabel()
        label.text = "10 tracks"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var stackView = UIStackView()

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        
        stackView = UIStackView(arrangedSubviews: [autorNameLabel,
                                                   dateOfCreationLabel,
                                                   locationLabel,
                                                   downloadsLabel],
                                axis: .vertical,
                                spacing: 20,
                                distribution: .fillProportionally)
        
        view.addSubview(stackView)
    }
}

extension DetailsViewController: DetailsViewProtocol {
    
}

extension DetailsViewController {

private func setConstraints() {
    
    NSLayoutConstraint.activate([
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        imageView.heightAnchor.constraint(equalToConstant: 100),
        imageView.widthAnchor.constraint(equalToConstant: 100)
    ])
    
    NSLayoutConstraint.activate([
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
        stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
    ])
    
}
}
