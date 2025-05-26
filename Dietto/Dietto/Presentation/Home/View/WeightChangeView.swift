//
//  WeightChangeView.swift
//  Dietto
//
//  Created by 안정흠 on 5/23/25.
//

import SwiftUI
 
struct WeightChangeView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var viewModel: HomeViewModel
    @State private var value: [String] = []
    @State private var shake: CGFloat = 0
    
    var body: some View {
        VStack {
            Text("최근 몸무게 변경")
                .font(.pretendardBold32)
                .foregroundStyle(.text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            Spacer()
            
            HStack(spacing: 2) {
                ForEach(value, id: \.self) { item in
                    Text(item)
                        .contentTransition(.interpolate)
                        .transition(
                            .asymmetric(insertion: .push(from: .bottom), removal: .push(from: .top))
                        )
                }
                Text(value.isEmpty ? "0" : "")
                    .contentTransition(.numericText())
                    .padding(3)
                Text("KG")
            }
            .font(.custom("Pretendard-Bold", size: 40))
            .foregroundStyle(.text)
            .modifier(ShakeEffect(animatableData: shake))
            
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 21)
                    .ignoresSafeArea()
                    .foregroundStyle(.white)
                    .shadow(radius: 5, x: 2, y: 2)
                    
                
                CustomKeypad()
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .background(Color.backGround)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("저장") {
                    guard !value.isEmpty else { return }
                    viewModel.updateCurrentBodyScale(value.joined())
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                Button("취소") {
                    dismiss()
                }
            }
        }
    }
    
    @ViewBuilder
    func CustomKeypad() -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
            ForEach(1...9, id: \.self) { number in
                Button {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        addNumber(number: "\(number)")
                    }
                } label: {
                    Text("\(number)")
                        .frame(maxWidth: .infinity)
                        .frame(height: 70)
                        .contentShape(.rect)
                }
            }
            
            Spacer()
            
            ForEach(["0", "delete.backward.fill"], id: \.self) { number in
                Button {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        if number == "0" { addNumber(number: number) }
                        else { removeNumber() }
                    }
                } label: {
                    Group {
                        if number == "0" { Text("\(number)")}
                        else { Image(systemName: number) }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 70)
                    .contentShape(.rect)
                }
                .buttonRepeatBehavior(number == "0" ? .disabled : .enabled)
            }
        }
        .font(.pretendardBold20)
        .foregroundStyle(Color.text)
        .buttonStyle(KeypadButtonStyle())
        .padding()
    }
    
    private func addNumber(number: String) {
        guard value.count < 3, (number == "0" ? !value.isEmpty : true) else { shake += 1; return }
        value.append(number)
    }
    private func removeNumber() {
        guard !value.isEmpty else { return }
        value.removeLast()
    }
}



//#Preview {
//    WeightChangeView()
//}
