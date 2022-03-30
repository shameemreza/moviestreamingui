//
//  SnapCarousel.swift
//  MovieStreamingUI
//
//  Created by Shameem Reza on 31/3/22.
//

import SwiftUI

struct SnapCarousel<Content: View, T: Identifiable>: View {
    var content: (T) -> Content
    var list: [T]
    
    // MARK: PROPERTIES
    var spacing: CGFloat
    var trialingSpace: CGFloat
    @Binding var index: Int
    
    init(spacing: CGFloat = 15, trialingSpace: CGFloat = 100, index: Binding<Int>, items: [T], @ViewBuilder content: @escaping (T)->Content) {
        
        self.list = items
        self.spacing = spacing
        self.trialingSpace = trialingSpace
        self._index = index
        self.content = content
    }
    
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    var body: some View {
        GeometryReader{proxy in
            
            let width = proxy.size.width - (trialingSpace - spacing)
            let adjustmentWidth = (trialingSpace / 2) - spacing
            
            HStack(spacing: spacing) {
                ForEach(list){item in
                    content(item)
                        .frame(width: proxy.size.width - trialingSpace)
                        .offset(y: getOffset(item: item, width: width))
                }
            } // END HSTACK
            .padding(.horizontal, spacing)
            .offset(x: (CGFloat(currentIndex) * -width) + (currentIndex != 0 ? adjustmentWidth : 0) + offset)
            .gesture(
                DragGesture()
                    .updating($offset, body: {value, out, _ in
                        out = (value.translation.width / 1.5)
                    })
                    .onEnded({value in
                        let offsetX = value.translation.width
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        
                        currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                        
                        currentIndex = index
                        
                    })
                    .onChanged({value in
                        let offsetX = value.translation.width
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        
                        index = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                    })
            )
        } // END GR
        .animation(.easeInOut, value: offset == 0)
    } // END BODY
    
    // MARK: SLIDER ITEM BASED ON SCROLL
    func getOffset(item: T, width: CGFloat)->CGFloat {
        
        let progress = ((offset < 0 ? offset : -offset) / width) * 60
        let topOffset = -progress < 60 ? progress : -(progress + 120)
        let previous = getIndex(item: item) - 1 == currentIndex ? (offset < 0 ? topOffset : -topOffset) : 0
        let next = getIndex(item: item) + 1 == currentIndex ? (offset < 0 ? -topOffset : topOffset) : 0
        let checkBetween = currentIndex >= 0 && currentIndex < list.count ? (getIndex(item: item) - 1 == currentIndex ? previous : next) : 0
        
        return getIndex(item: item) == currentIndex ? -60 - topOffset : checkBetween
    }
    
    // MARK: FETCH INDEX
    func getIndex(item: T)-> Int {
        let index = list.firstIndex {currentItem in
            return currentItem.id == item.id
        } ?? 0
        return index
    }
    
}

struct SnapCarousel_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
