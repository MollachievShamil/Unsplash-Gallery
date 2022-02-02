//
//  FavoriteViewController.swift
//  TestApp
//
//  Created by Шамиль Моллачиев on 02.02.2022.
//

import UIKit

class FavoriteViewController: UIViewController {

    var presenter: FavoritePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }


}

extension FavoriteViewController: FavoriteViewProtocol {
    
}
