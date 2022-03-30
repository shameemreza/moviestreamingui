//
//  Home.swift
//  MovieStreamingUI
//
//  Created by Shameem Reza on 30/3/22.
//

import SwiftUI

struct Home: View {
    
    @State var currentIndex: Int = 0 //ANIMATED VIEW
    @State var currentTab: String = "English"
    @State var movieDeatil: Movie?
    @State var showMovieDetail: Bool = false
    @State var currentCardSize: CGSize = .zero
    
    @Environment(\.colorScheme) var scheme
    @Namespace var animation
    
    var body: some View {
        // MARK: ZSTACK
        ZStack {
            //MARK: BBACKGROUND
            BGView()
            
            // MARK: MAIN VIEW
            VStack {
                
                // MARK: NAV BAR
                NavBar()
                
                // MARK: SLIDER
                SnapCarousel(spacing: 20, trialingSpace: 110, index: $currentIndex, items: movies) {movie in
                    GeometryReader{proxy in
                        let size = proxy.size
                        
                        Image(movie.movieThumb)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .cornerRadius(15)
                            .matchedGeometryEffect(id: movie.id, in: animation)
                            .onTapGesture {
                                currentCardSize = size
                                movieDeatil = movie
                                withAnimation(.easeInOut) {
                                    showMovieDetail = true
                                }
                            }
                    } // END GR
                } // END SLIDER
                .padding(.top, 70)
                
                // MARK: SLIDER INDICATOR
                CustomIndicator()
                
                // MARK: POPULAR MOVIES SECTION TITLE
                HStack {
                    Text("Latest Movies")
                        .font(.title3.bold())
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("See All")
                        Image(systemName: "arrow.right")
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.pink.opacity(0.8))
                } // END POPULAR SECTION TITLE
                .padding()
                
                // MARK: POPULAR MOVIE LIST
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(movies) {movie in
                            Image(movie.movieThumb)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 120)
                                .cornerRadius(15)
                        }
                    } // END HSTACK
                } // END SCROLL VIEW
                
            } // END MAIN VIEW
            .overlay {
                if let movie = movieDeatil, showMovieDetail {
                    DetailView(movie: movie, showMovieDetail: $showMovieDetail, movieDeatil: $movieDeatil, currentCardSieze: $currentCardSize, animation: animation)
                }
            }
        } //END ZSTACK
    }
    
    // MARK: - SLIDER INDICATOR
    @ViewBuilder
    func CustomIndicator()->some View {
        HStack(spacing: 5) {
            ForEach(movies.indices, id: \.self){index in
                Circle()
                    .fill(currentIndex == index ? .pink : .gray.opacity(0.5))
                    .frame(width: currentIndex == index ? 10 : 6, height: currentIndex == index ? 10 : 6)
            }
        } //END HSTACK
        .animation(.easeInOut, value: currentIndex)
    }
    
    // MARK: CUSTOM NAV BAR
    @ViewBuilder
    func NavBar()->some View {
        HStack(spacing: 0) {
            ForEach(["English", "Hindi", "Telegu"], id: \.self){tab in
                Button {
                    withAnimation {
                        currentTab = tab
                    }
                } label: {
                    Text(tab)
                        .foregroundColor(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 20)
                        .background {
                            if currentTab == tab {
                                Capsule()
                                    .fill(.regularMaterial)
                                    .environment(\.colorScheme, .dark)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                } // END TAB BUTTON
            } // END LOOP
            
            Button {
                
            } label: {
                Image(systemName: "bell")
                    .font(.title)
                    .foregroundColor(.gray)
                    .overlay(
                        Text("2")
                            .font(.caption2.bold())
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.pink)
                            .clipShape(Circle())
                            .offset(x: 11, y: -12),
                        
                        alignment: .topTrailing
                    )
                    .offset(x: -2)
                    .padding(15)
                    .background(Color.black.opacity(0.15))
                    .clipShape(Circle())
            } // END BUTTON
        }
        .padding()
    }
    
    // MARK: - BLURRED BACKGROUND
    @ViewBuilder
    func BGView()->some View {
        GeometryReader{proxy in
            let size = proxy.size
            
            TabView(selection: $currentIndex) {
                ForEach(movies.indices, id: \.self) {index in
                    Image(movies[index].movieThumb)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipped()
                        .tag(index)
                } // END LOOP
            } // END TAB VIEW
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentIndex)
            
            // MARK: - CUSTOM GRADIENT
            let color: Color = (scheme == .dark ? .black : .white)
            
            LinearGradient(colors: [
                .black,
                .clear,
                color.opacity(0.15),
                color.opacity(0.5),
                color.opacity(0.8),
                color,
                color
            ], startPoint: .top, endPoint: .bottom) // END GRADIENT
            
            // MARK: BLURRED OVERLAY
            Rectangle()
                .fill(.ultraThinMaterial)
        } // END GEOMETRY READER
        .ignoresSafeArea()
    } // END BG VIEW
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
