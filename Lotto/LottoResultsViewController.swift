//
//  LottoResultsViewController.swift
//  Lotto
//
//  Created by NERO on 6/6/24.
//

import UIKit
import Alamofire
import SnapKit

class LottoResultsViewController: UIViewController {
    
    let roundTextField = UITextField()
    let roundPickerView = UIPickerView()
    
    let lottoDateLabel = UILabel()
    
    let lottoRoundLabel = UILabel()
    let resultLabel = UILabel()
    let resultStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        //추가 설정 필요
        return stackView
    }()
    
    lazy var lottoNumbers = [lottoNo1Label, lottoNo2Label, lottoNo3Label, lottoNo4Label, lottoNo5Label, lottoNo6Label, plusLabel, lottoBonusLabel]
    let lottoNo1Label = UILabel()
    let lottoNo2Label = UILabel()
    let lottoNo3Label = UILabel()
    let lottoNo4Label = UILabel()
    let lottoNo5Label = UILabel()
    let lottoNo6Label = UILabel()
    let plusLabel = UILabel()
    let lottoBonusLabel = UILabel()
    let lottoNumberStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    let firstPrizeMoneyTitleLabel = UILabel()
    let firstPrizeMoneyLabel = UILabel()
    let prizeMoneyStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        //추가 설정 필요
        return stackView
    }()
    
    let firstWinnerCountTitleLabel = UILabel()
    let firstWinnerCountLabel = UILabel()
    let winnerCountStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        //추가 설정 필요
        return stackView
    }()
    
    
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
