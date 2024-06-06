//
//  LottoDTO.swift
//  Lotto
//

import Foundation

struct LottoDTO: Decodable {
    let returnValue: String //요청 결과
    let drwNoDate: String //로또 당첨 날짜
    let drwNo: Int //로또 회차
    let drwtNo1, drwtNo2, drwtNo3, drwtNo4, drwtNo5, drwtNo6, bnusNo: Int //당첨 번호
    let totSellamnt, firstAccumamnt: Int //총 당첨 금액, 1등 총 당첨 금액
    let firstWinamnt, firstPrzwnerCo: Int //1등 당첨 금액, 1등 당첨 인원
}
