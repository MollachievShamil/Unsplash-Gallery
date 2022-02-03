//
//  MainViewController.swift
//  TestApp
//
//  Created by Шамиль Моллачиев on 02.02.2022.
//

import UIKit

class MainViewController: UIViewController {
let array = [1, 3, 4 , 5,8 ,6 ,7]
    var presenter: MainPresenterProtocol!
    
    private let collectionView1: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView1 = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView1.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView1.translatesAutoresizingMaskIntoConstraints = false

        return collectionView1
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.translatesAutoresizingMaskIntoConstraints = false
        collectionView1.delegate = self
        collectionView1.dataSource = self
       // collectionView1.frame = view.bounds
        view.addSubview(collectionView1)
       // collectionView1.frame = CGRect(x: 100, y: 100, width: 300, height: 300)
       // collectionView1.center = view.center
        setConstraints()
        //      //  view.backgroundColor = .green
//        view.addSubview(collectionView)
//        view.addSubview(button)
//        setConstraints()
//        setDelegate()
//collectionView.backgroundColor = .white
//        //collectionView.reloadData()
//        print(view.subviews)
//        collectionView.frame = view.bounds
        
      
    }
   
//    func setDelegate() {
//        collectionView.dataSource = self
//        collectionView.delegate = self
//
//    }
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            collectionView1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView1.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MainViewController: MainViewProtocol {
    
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = .systemBlue
        //let song = songs[indexPath.row].trackName
      //  cell.imageView = UIImageView(image: UIImage(named: "1"))
        print( "added")
        return cell
    }
    
   

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: collectionView.frame.width,
            height: 20
        )
    }
    
    
}

