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
    
    lazy var lottoNumberLabels = [lottoNo1Label, lottoNo2Label, lottoNo3Label, lottoNo4Label, lottoNo5Label, lottoNo6Label, plusLabel, lottoBonusLabel]
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
    
        configureHierarchy()
        configureData()
        configureLayout()
        configureUI()
        
        settingNavigation()
        
        getLatestRound(startRound: 1115) { latestRound in
            self.latestRound = latestRound
            
            for round in (1...latestRound).reversed() {
                self.roundList.append(round)
            }
            
            self.requestLottoData(round: latestRound)
        }
    }
}

//MARK: - Configure
extension LottoResultsViewController {
    func configureHierarchy() {
        [showKeyboardButton, roundTextField, roundSearchButton].forEach { searchStackView.addArrangedSubview($0) }
        
        [lottoRoundLabel, resultLabel].forEach { resultStackView.addArrangedSubview($0) }
        
        lottoNumberLabels.forEach { lottoNumberStackView.addArrangedSubview($0) }
        
        [firstPrizeMoneyTitleLabel, firstPrizeMoneyLabel].forEach { prizeMoneyStackView.addArrangedSubview($0) }
        
        [firstWinnerCountTitleLabel, firstWinnerCountLabel].forEach { winnerCountStackView.addArrangedSubview($0) }
        
        [searchStackView, lottoDateLabel, resultStackView, lottoNumberStackView, prizeMoneyStackView, winnerCountStackView].forEach { view.addSubview($0) }
    }
    
    func configureData() {
        roundTextField.delegate = self
        roundTextField.placeholder = "회차 입력하기"
        roundTextField.inputView = roundPickerView
        roundTextField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(textFieldTapped(_:))))
        
        roundSearchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        
        roundPickerView.delegate = self
        roundPickerView.dataSource = self
    }
    
    @objc func textFieldTapped(_ sender: UITapGestureRecognizer) {
        roundTextField.text = nil
        roundTextField.becomeFirstResponder()
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
    
    @objc func searchButtonClicked() {
        guard let input = roundTextField.text, !input.isEmpty else {
            roundTextField.text = "⛔️ 회차 입력하기"
            return
        }
        
        let isInputInt = Int(input) != nil
        guard isInputInt else { roundTextField.text = "⛔️ 숫자 입력하기" ; return }
        
        requestLottoData(round: Int(input)!)
    }
    
    func requestLottoData(round: Int) {
        let url = APIURL.lottoURL + String(round)
        
        AF.request(url).responseDecodable(of: LottoDTO.self) { dataResponse in
            switch dataResponse.result {
            case .success(let lotto):
                let lottoNumbers = [lotto.drwtNo1, lotto.drwtNo2, lotto.drwtNo3, lotto.drwtNo4, lotto.drwtNo5, lotto.drwtNo6, 0, lotto.bnusNo]
                self.setLottoData(lottoNumbers, lotto.drwNoDate, lotto.drwNo, lotto.firstWinamnt, lotto.firstPrzwnerCo)
            case .failure(_):
                self.roundTextField.text = "💬 다시 입력하기"
            }
        }
    }
    
    func setLottoData(_ numbers: [Int], _ date: String, _ round: Int, _ money: Int, _ winner: Int) {
        for (index, label) in lottoNumberLabels.enumerated() {
            label.text = "\(numbers[index])"
            label.backgroundColor = setLottoNumberColor(numbers[index])
        }
        plusLabel.text = "+"
        lottoDateLabel.text = "\(date) 추첨"
        lottoRoundLabel.text = "\(round)회"
        firstPrizeMoneyLabel.text = "\(money)원"
        firstWinnerCountLabel.text = "\(winner)명"
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
            
            lottoNumberLabels.forEach {
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
        
        lottoNumberLabels.forEach {
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
