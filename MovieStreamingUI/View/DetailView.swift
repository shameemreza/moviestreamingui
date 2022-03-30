//
//  DetailView.swift
//  MovieStreamingUI
//
//  Created by Shameem Reza on 31/3/22.
//

import SwiftUI

struct DetailView: View {
    var movie: Movie
    @Binding var showMovieDetail: Bool
    @Binding var movieDeatil: Movie?
    @Binding var currentCardSieze: CGSize
    
    var animation: Namespace.ID
    
    @State var showDetailContent: Bool = false
    @State var offset: CGFloat = 0
    
    var body: some View {
        //MARK: MOVIE DETAIL
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        withAnimation{
                            showMovieDetail = false
                        }
                    } label: {
                        Image(systemName: "xmark.circle")
                            .font(.title2)
                            .foregroundColor(.pink)
                    } // END DRAWER MENU
                }
                
                
                Image(movie.movieThumb)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: currentCardSieze.width, height: currentCardSieze.height)
                    .cornerRadius(15)
                    .matchedGeometryEffect(id: movie.id, in: animation)
                // MARK: - MOVIE DETAILS
                VStack(spacing: 15) {
                    
                    Text(movie.movieTitle)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.top, 25)
                    
                    
                    Text("Storyline")
                        .font(.title)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.top, 25)
                    
                    Text(movie.movieStory)
                        .multilineTextAlignment(.leading)
                    
                    Button {
                        
                    } label: {
                        Text("WATCH NOW")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.pink)
                            }
                    }
                    .padding(.top, 20)
                } // END DETAILS VSTACK
                .opacity(showDetailContent ? 1 : 0)
                .offset(y: showDetailContent ? 0 : 200)
            } //END VSTACK
            .padding()
            .modifier(OffsetModifier(offset: $offset))
        } //END SCROLL VIEW
        .coordinateSpace(name: "SCROLL")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
        }
        .onAppear {
            withAnimation(.easeInOut) {
                showDetailContent = true
            }
        }
        .onChange(of: offset) { newValue in
            if newValue > 120 {
                withAnimation(.easeInOut) {
                    showDetailContent = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    withAnimation(.easeInOut) {
                        showMovieDetail = false
                    }
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
