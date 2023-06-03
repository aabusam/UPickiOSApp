//
//  HomeViewController.swift
//  UPickiOS
//
//  Created by Abdallah Abu Samaha on 6/3/23.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        UPickService.shared.excute(UPickRequest.listFarmsRequests, expecting: UPickListFarmsResponse.self) { result in
            switch result {
            case .success(let model):
                print(model)
            case .failure(let error):
                print(error)
            }
        }
    }
}
