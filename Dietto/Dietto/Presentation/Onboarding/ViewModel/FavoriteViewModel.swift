//
//  FavoriteViewModel.swift
//  Dietto
//
//  Created by InTak Han on 5/22/25.
//
import SwiftUI
class FavoriteViewModel : ObservableObject{
    @Published var name : String = "lee" //임시 이름 데이터
    @Published var favorite : [String] = [] //관심사 부분
}
