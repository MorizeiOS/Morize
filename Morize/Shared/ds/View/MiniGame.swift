//
//  MiniGame.swift
//  Morize (iOS)
//
//  Created by judongseok on 2021/12/29.
//

import SwiftUI

struct MiniGame: View {
    // viewModel
    @ObservedObject var viewModel = MiniGameVM()
    // timer
    @State var time: Double = 0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack{
            Text("\(String(format: "%.2f", time))")
                .font(.system(size: 30, weight: .bold, design: .monospaced))
                .onReceive(timer) { _ in
                    time += 0.1
                }
            ForEach(0..<viewModel.level){ i in
                HStack{
                    ForEach(0..<viewModel.level){ j in
                        Button {
                            if viewModel.checkArray.isEmpty{
                                viewModel.add(pos: (i * 4) + (j))
                                viewModel.buttonArray[(i * 4) + (j)] = 1
                                print(viewModel.checkArray)
                            }
                            else{
                                // 단어와 뜻이 맞으면 disable
                                if viewModel.check(a: viewModel.wordFour[viewModel.checkArray[0]], b: viewModel.wordFour[(i * 4) + (j)]) {
                                    viewModel.buttonArray[(i * 4) + (j)] = 2
                                    viewModel.buttonArray[viewModel.checkArray[0]] = 2
                                    // 게임이 끝났는지 체크
                                    if viewModel.checkEnd(){
                                        self.timer.upstream.connect().cancel()
                                    }
                                }
                                // 단어와 뜻이 다르면
                                else {
                                    for i in viewModel.checkArray{
                                        viewModel.buttonArray[i] = 0
                                    }
                                }
                                viewModel.checkArray.removeAll()
                            }
                        } label: {
                            Text(viewModel.wordFour[(i * 4) + (j)])
                                .frame(width: 70, height: 70, alignment: .center)
                        }
                        .background(viewModel.buttonArray[(i * 4) + (j)] == 0 ? Color(hex: "4E9F3D") : Color(hex: "D8E9A8"))
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                        .foregroundColor(.black)
                        .cornerRadius(8)
                        .opacity(viewModel.buttonArray[(i * 4) + (j)] == 2 ? 0 : 1)
                    }
                }
            }
        }
    }
}

struct MiniGame_Previews: PreviewProvider {
    static var previews: some View {
        MiniGame()
    }
}