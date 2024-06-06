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
        [lottoRoundLabel, resultLabel].forEach { resultStackView.addArrangedSubview($0) }
        
        lottoNumbers.forEach { lottoNumberStackView.addArrangedSubview($0) }
        
        [firstPrizeMoneyTitleLabel, firstPrizeMoneyLabel].forEach { prizeMoneyStackView.addArrangedSubview($0) }
        
        [firstWinnerCountTitleLabel, firstWinnerCountLabel].forEach { winnerCountStackView.addArrangedSubview($0) }
        
        [roundTextField, roundPickerView, lottoDateLabel, resultStackView, lottoNumberStackView, prizeMoneyStackView, winnerCountStackView].forEach { view.addSubview($0) }
    }
    
    func configureData() {
        
    }
}

//MARK: - Configure UI
extension LottoResultsViewController {
    func configureLayout() {
        lottoNumberStackView.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.centerY.equalTo(view) //임시
        }
        lottoNumbers.forEach {
            $0.snp.makeConstraints { $0.size.equalTo(42) }
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white

        lottoNumbers.forEach {
            $0.text = "21" //임시 번호
            $0.backgroundColor = .red //임시 색상
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 17, weight: .semibold)
            $0.layer.cornerRadius = 21
            $0.layer.masksToBounds = true
        }
        plusLabel.textColor = .black
        plusLabel.text = "+"
        plusLabel.backgroundColor = .clear
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
