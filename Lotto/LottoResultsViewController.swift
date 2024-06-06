//
//  LottoResultsViewController.swift
//  Lotto
//
//  Created by NERO on 6/6/24.
//

import UIKit

class LottoResultsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureData()
        configureLayout()
        configureUI()
        
        settingNavigation()
    }
}

//MARK: - Configure
extension LottoResultsViewController {
    func configureHierarchy() {
        
    }
    
    func configureData() {
        
    }
}

//MARK: - Configure UI
extension LottoResultsViewController {
    func configureLayout() {
        
    }
    
    func configureUI() {
        view.backgroundColor = .white
    }
}

//MARK: - Switching View
extension LottoResultsViewController {
    func settingNavigation() {
        navigationItem.title = "🎁 당첨 번호 조회"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(resource: .main)
        ]
    }
}
