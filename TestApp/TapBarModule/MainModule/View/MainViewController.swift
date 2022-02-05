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
    var paginator = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setConstraints()
        setupSearchController()
        presenter.fetchPhotoModels()
        setupActivityIndicator()
        navBarSettings()
    }
    
    var indicatorActivity = UIActivityIndicatorView()
   
    func setupActivityIndicator() {
        indicatorActivity.style = .large
        indicatorActivity.color = .black
        collectionView1.addSubview(indicatorActivity)
        indicatorActivity.center = view.center
        indicatorActivity.startAnimating()
    }
    
    let collectionView1: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView1 = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView1.register(MainViewControllerCell.self, forCellWithReuseIdentifier: "cell")
        collectionView1.translatesAutoresizingMaskIntoConstraints = false
        //collectionView1.refreshControl = UIRefreshControl()
      //  collectionView1.refreshControl?.addTarget(self, action: #selector(refreshing), for: .allEvents)
        return collectionView1
    }()
    
//    @objc func refreshing() {
//        presenter.getPhotoInformation()
//    }
//    
    
    func createCustomButton(selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: selector, for: .touchUpInside)
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
    
    func navBarSettings(){
        let refreshButton = createCustomButton(selector: #selector(refreshButtonTapped))
        navigationItem.rightBarButtonItem = refreshButton
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private func setupSearchController() {
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    @objc func refreshButtonTapped(){
        DispatchQueue.main.async {
            if self.paginator {
                self.presenter.fetchPhotoModels()
                self.indicatorActivity.startAnimating()
                print("refresh")
            } else {
                    self.refreshButtonTapped()
            }
        }
    }
    
    
    //MARK: - Delegates
    func setDelegate() {
        collectionView1.dataSource = self
        collectionView1.delegate = self
        searchController.searchBar.delegate = self
    }
}

//MARK: - Presenter Delegate
extension MainViewController: MainViewProtocol {
    func sucsess() {
        collectionView1.reloadData()
        indicatorActivity.stopAnimating()
        indicatorActivity.hidesWhenStopped = true
        paginator = true
//        DispatchQueue.main.async {
//            self.collectionView1.refreshControl?.endRefreshing()
//        }
    }
    
    func reloadCollectionView() {
        collectionView1.reloadData()
    }
}

//MARK: - Collection View Delegates
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.photoModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainViewControllerCell
        cell.imageView.image = presenter.makeImage(img: presenter.photoModels[indexPath.row].picture)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = presenter.photoModels[indexPath.row]
        presenter.goToDetailsModule(model: model)
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

//MARK: -  Search Bar Delegate
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        if text != "" {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
                self?.presenter.fetchSearchingPhotoModels(name: text!)
                self?.indicatorActivity.startAnimating()
            })
        }
    }
}

//MARK: - Constraints
extension MainViewController {
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

//MARK: - InfinityScroll

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (collectionView1.contentSize.height-100-scrollView.frame.size.height) {
            if paginator {
                paginator = false
            presenter.addMorePhotoForInfinityScroll()

        }
      }
    }
}
