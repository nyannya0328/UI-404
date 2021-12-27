//
//  Home.swift
//  UI-404
//
//  Created by nyannyan0328 on 2021/12/27.
//

import SwiftUI

struct Home: View {
    @State var offset : CGFloat = 0
    
    @State var delegate = ScrollDeleagate()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            scrollContent()
                .padding(.top,getRect().height / 3)
                .padding(.bottom,CGFloat(links.count - 1) * 88)
                .overlay(
                    
                    GeometryReader{_ in
                        
                        
                        scrollContent(showTitle: true)
                        
                    }
                   
                    .frame(height: 80)
                        .offset(y: offset)
                    .clipped()
                   
                    .background(Color("Yellow"))
                    .padding(.top,getRect().height / 3)
                    .offset(y: -offset)
                
                    ,alignment: .top
                
                )
                .modifier(offsetModifier(offset: $offset))
            
            
         
            
            
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(Color("BG"))
        .ignoresSafeArea()
        .coordinateSpace(name: "SCROLL")
        .onAppear {
            
            UIScrollView.appearance().delegate = delegate
            UIScrollView.appearance().bounces = false
            
            
        }
        .onDisappear {
            
            UIScrollView.appearance().delegate = nil
            UIScrollView.appearance().bounces = true
            
        }
    }
    @ViewBuilder
    func scrollContent(showTitle : Bool = false)-> some View{
        
        
        VStack(spacing:0){
            
            ForEach(links){link in
                
                
                HStack{
                    
                    
                    if showTitle{
                        
                        
                
                        
                        Text(link.title)
                            .font(.title2.bold())
                            .frame(maxWidth:.infinity,alignment:.leading)
                           
                    }
                    else{
                        
                        Spacer()
                    }
                    
                    
                    Image(link.logo)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .foregroundColor(showTitle ? Color("BG") : Color("Yellow"))
                    
                }
                .padding(.horizontal,15)
                .frame(height: 80)
                
                
            }
            
            
        }
        .padding(.top,getSafeArea().top)
        .padding(.bottom,getSafeArea().bottom)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

class ScrollDeleagate : NSObject,UIScrollViewDelegate{
    @Published var snapInterval : CGFloat = 80
    
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        
        let target = scrollView.contentOffset.y
        let condition = (target / snapInterval).rounded(.toNearestOrAwayFromZero)
        
        scrollView.setContentOffset(CGPoint(x: 0, y: snapInterval * condition), animated: true)
        
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        
        let target = targetContentOffset.pointee.y
        let condition = (target / snapInterval).rounded(.toNearestOrAwayFromZero)
        
        scrollView.setContentOffset(CGPoint(x: 0, y: snapInterval * condition), animated: true)
        
        
        
    }
    
    
    
    
}

struct offsetModifier : ViewModifier{
    
    @Binding var offset : CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay(
            
                GeometryReader{proxy in
                    
                    
                    Color.clear
                        .preference(key: offsetKey.self, value: proxy.frame(in: .named("SCROLL")).minY)
                    
                }
            
            
            )
            .onPreferenceChange(offsetKey.self){value in
                
                self.offset = value
                
            }
            
    }
}

struct offsetKey : PreferenceKey{
    
    static var defaultValue: CGFloat = 0
    
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        
        value = nextValue()
    }
}
