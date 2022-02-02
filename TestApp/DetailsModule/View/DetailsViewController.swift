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
    }


}

extension DetailsViewController: DetailsViewProtocol {
    
}
