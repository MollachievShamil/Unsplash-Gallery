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
        setupLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setButton()
    }

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
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
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Add to favorite", for: .normal)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()
    
    func setButton() {
        let model = makeModel()
        if presenter.imageExistInRealm(model: model) {
            button.backgroundColor = .red
            button.setTitle("Delete", for: .normal)
        } else {
            button.backgroundColor = .orange
            button.setTitle("Add", for: .normal)
        }
    }
    
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
        view.addSubview(button)
    }
    
    
    func setupLabels(){
        autorNameLabel.text = "Name of author: " +  presenter.getNameLabel()
        dateOfCreationLabel.text = "Photo was created: " + presenter.getDateOfCreationLabel()
        locationLabel.text = "Photo was made in: " + presenter.getLocationLabel()
        downloadsLabel.text = presenter.getDownloadsLabel()
    }
    
    func setAlert(){
        let model = makeModel()
        if presenter.imageExistInRealm(model: model) {
            alertOk(title: "Add", massege: "Photo sucsessfuly added")
            
        } else {
            alertOk(title: "Delete", massege: "Photo sucsessfuly deleted")
        }
    }
    
    func makeModel() -> RealmPictureModel {
        let model = RealmPictureModel()
        model.name = presenter.getNameLabel()
        model.pictureData = presenter.getData()
        model.URL = presenter.getURL()
        model.downloads = presenter.model?.downloads ?? 0
        model.createdAt = presenter.model?.created_at ?? ""
        model.location = presenter.getLocationLabel()
        return model
    }
    
    @objc func addToFavorite() {
        let model = makeModel()
        presenter.saveDeleteFromRealm(model: model)
        setAlert()
        setButton()
    }
}

//MARK: - Presenter Protocol
extension DetailsViewController: DetailsViewProtocol {
    func setUpPhoto(image: UIImage) {
        imageView.image = image
    }
}


//MARK: -  Constraints
extension DetailsViewController {

private func setConstraints() {
    
    NSLayoutConstraint.activate([
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        imageView.heightAnchor.constraint(equalToConstant: 300),
        imageView.widthAnchor.constraint(equalToConstant: 300)
    ])
    
    NSLayoutConstraint.activate([
        stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
        stackView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
    ])
    
    NSLayoutConstraint.activate([
        button.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        button.heightAnchor.constraint(equalToConstant: 40),
        button.widthAnchor.constraint(equalToConstant: 150)
    ])
 }
}
