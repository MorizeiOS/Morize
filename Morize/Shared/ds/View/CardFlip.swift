//
//  CardFlip.swift
//  Morize (iOS)
//
//  Created by judongseok on 2022/01/05.
//

import SwiftUI

struct CardFlip: View {
    @ObservedObject var viewModel = CardFlipVM()
    var body: some View {
        ZStack{
            Color(hex: "eaefe5")
                .ignoresSafeArea()
                .zIndex(-10)
            
            ForEach(0..<viewModel.getWordsCount()) { i in
                Flashcard(front: {
                    Text(viewModel.words[i])
                }, back: {
                    Text(viewModel.means[i])
                }, color: viewModel.getColor(index: i), click: true, tutorial: false)
                .offset(viewModel.dragOffset[i])
                .zIndex(viewModel.zIndexs[i])
                .modifier(AnimatableModifierDouble(bindedValue: viewModel.dragOffset[i].height, completion: {
                    withAnimation(Animation.easeIn(duration: 0.2)) {
                        viewModel.zIndexs = viewModel.zindexsArr[(viewModel.currentIdx % 4)]
                        viewModel.dragOffset[i] = CGSize(width: 0, height: 0)
                    }
                }))
                .disabled(viewModel.currentIdx == i ? false : true)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            if viewModel.currentIdx == i {
                                viewModel.dragOffset[i] = CGSize(width: 0, height: gesture.translation.height)
                            }
                        }
                        .onEnded { gesture in
                            // 위로 넘어가는 애니메이션
                            if viewModel.dragOffset[i].height <= -100 {
                                print(viewModel.currentIdx)
                                viewModel.currentIdx = (viewModel.currentIdx + 1) % 4
                                withAnimation(Animation.easeOut(duration: 0.2)) {
                                    viewModel.dragOffset[i] = CGSize(width: 0, height: -200)
                                }
                            }
                            // 제자리로
                            else{
                                withAnimation(Animation.easeInOut(duration: 0.2)) {
                                    viewModel.dragOffset[i] = .zero
                                }
                            }
                        }
                )
            }
        }
    }
}

struct CardFlip_Previews: PreviewProvider {
    static var previews: some View {
        CardFlip()
    }
}
