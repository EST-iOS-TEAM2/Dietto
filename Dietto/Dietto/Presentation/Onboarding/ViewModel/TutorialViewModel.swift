//
//  TutorialViewModel.swift
//  Dietto
//
//  Created by InTak Han on 5/22/25.
//


import SwiftUI

class TutorialViewModel: ObservableObject {
    //@State var weigt: String = ""
    //@State var distance: String = ""
    
    @Published var name = "lee"//임시 데이터 - 모델에서 가져오기
    @Published var weights: [Int] = Array(20...100).reversed() //무게 범위
    @Published var distances: [Int] = Array(1...10).reversed() //거리 범위
}