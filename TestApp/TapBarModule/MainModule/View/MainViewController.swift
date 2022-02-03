//
//  MainViewController.swift
//  TestApp
//
//  Created by Шамиль Моллачиев on 02.02.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol!
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setConstraints()
        setupSearchController()
        presenter.getPhotoInformation()
        setupActivityIndicator()
        indicatorActivity.startAnimating()
    }
    
    var indicatorActivity = UIActivityIndicatorView()
    func setupActivityIndicator() {
        indicatorActivity.style = .large
        indicatorActivity.color = .black
        collectionView1.addSubview(indicatorActivity)
        indicatorActivity.frame = view.frame 
    }
    
    private let collectionView1: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
       // layout.minimumLineSpacing = 1
        let collectionView1 = UICollectionView(frame: .zero, collectionViewLayout: layout)
     
        collectionView1.register(MainViewControllerCell.self, forCellWithReuseIdentifier: "cell")
        collectionView1.translatesAutoresizingMaskIntoConstraints = false
        return collectionView1
    }()
    
    
    private let searchController = UISearchController(searchResultsController: nil)
    private func setupSearchController() {
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
   
    func setDelegate() {
        collectionView1.dataSource = self
        collectionView1.delegate = self

    }
    func setConstraints() {
        view.addSubview(collectionView1)
        NSLayoutConstraint.activate([
            collectionView1.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView1.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MainViewController: MainViewProtocol {
    func sucsess() {
        collectionView1.reloadData()
        indicatorActivity.stopAnimating()
        indicatorActivity.hidesWhenStopped = true
    }
    
 
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainViewControllerCell
        cell.imageView.image = presenter.makeImage(img: presenter.photoModels[indexPath.row].picture)
        //cell.contentView.backgroundColor = .systemBlue
        //let song = songs[indexPath.row].trackName
     //   let images = presenter.getPhoto()
       // cell.imageView.image = UIImage(named: "1")
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.photoModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.goToDetailsModule()
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: (view.frame.size.width/2) - 12,
            height: (view.frame.size.width/2) - 2
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        if text != "" {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
               // self?.fetchAlbum(name: text!)
            })
        }
    }
}
