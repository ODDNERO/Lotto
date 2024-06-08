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
    let showKeyboardButton = UIButton()
    let roundTextField = UITextField()
    let roundSearchButton = UIButton()
    let searchStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
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
    
    var latestRound = 0
    var roundList: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLatestRound(startRound: 1115) {
            print("completionRound:", $0)
            
            self.latestRound = $0
            print("latestRound:", self.latestRound)
            
            for round in (1...$0).reversed() {
                self.roundList.append(round)
            }
            
            self.configureHierarchy()
            self.configureData()
            self.configureLayout()
            self.configureUI()
            
            self.settingNavigation()
        }
    }
}

//MARK: - Configure
extension LottoResultsViewController {
    func configureHierarchy() {
        [showKeyboardButton, roundTextField, roundSearchButton].forEach { searchStackView.addArrangedSubview($0) }
        
        [lottoRoundLabel, resultLabel].forEach { resultStackView.addArrangedSubview($0) }
        
        lottoNumbers.forEach { lottoNumberStackView.addArrangedSubview($0) }
        
        [firstPrizeMoneyTitleLabel, firstPrizeMoneyLabel].forEach { prizeMoneyStackView.addArrangedSubview($0) }
        
        [firstWinnerCountTitleLabel, firstWinnerCountLabel].forEach { winnerCountStackView.addArrangedSubview($0) }
        
        [searchStackView, lottoDateLabel, resultStackView, lottoNumberStackView, prizeMoneyStackView, winnerCountStackView].forEach { view.addSubview($0) }
    }
    
    func configureData() {
        roundTextField.delegate = self
        roundTextField.inputView = roundPickerView
        
        roundPickerView.delegate = self
        roundPickerView.dataSource = self
        
        roundTextField.placeholder = "회차 입력하기"
    }
    
    //MARK: - Network
    func getLatestRound(startRound round: Int, completion: @escaping (Int) -> Void) {
        print("round:", round)
        
        let url = APIURL.lottoURL + String(round)
        
        AF.request(url).responseDecodable(of: LottoDTO.self) { dataResponse in
            switch dataResponse.result {
            case .success(_):
                print("--- success ---")
                self.getLatestRound(startRound: round + 1, completion: completion)
            case .failure(_):
                print("--- failure ---")
                completion(round - 1)
            }
        }
    }
}

extension LottoResultsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return latestRound
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(roundList[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        roundTextField.text = String(roundList[row])
    }
}

//MARK: - Configure UI
extension LottoResultsViewController {
    func configureLayout() {
        searchStackView.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(50)
            $0.height.equalTo(40)

            showKeyboardButton.snp.makeConstraints {
                $0.leading.equalTo(searchStackView)
                $0.width.equalTo(40)
            }
            roundTextField.snp.makeConstraints {
                $0.centerX.equalTo(searchStackView)
            }
            roundSearchButton.snp.makeConstraints {
                $0.trailing.equalTo(searchStackView)
                $0.width.equalTo(40)
            }
        }

        lottoNumberStackView.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.centerY.equalTo(view) //임시
            
            lottoNumbers.forEach {
                $0.snp.makeConstraints { $0.size.equalTo(42) }
            }
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        [showKeyboardButton, roundTextField, roundSearchButton].forEach {
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 1.5
            $0.backgroundColor = .white
            roundSearchButton.backgroundColor = .main
            $0.layer.borderColor = UIColor(resource: .main).cgColor
            showKeyboardButton.layer.borderColor = UIColor.systemGray4.cgColor
        }
        roundTextField.tintColor = .clear
        roundTextField.textColor = .black
        roundTextField.textAlignment = .center
        roundTextField.font = .systemFont(ofSize: 15, weight: .semibold)
        showKeyboardButton.tintColor = .systemGray
        roundSearchButton.tintColor = .white
        showKeyboardButton.setImage(UIImage(systemName: "keyboard.fill"), for: .normal)
        roundSearchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        
        lottoNumbers.forEach {
            $0.text = "21" //임시 번호
            $0.backgroundColor = .no11To20 //임시 색상
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 17, weight: .semibold)
            $0.layer.cornerRadius = 21
            $0.layer.masksToBounds = true
            plusLabel.textColor = .black
            plusLabel.text = "+"
            plusLabel.backgroundColor = .clear
        }
    }
    
    func setLottoNumberColor(_ lottoNum: Int) -> UIColor {
        switch lottoNum {
        case 1...10:
            return .no1To10
        case 11...20:
            return .no11To20
        case 21...30:
            return .no21To30
        case 31...40:
            return .no31To40
        case 41...45:
            return .no41To45
        default:
            return .clear
        }
    }
    
    func assignLottoNumbersToLabels() {
        
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
