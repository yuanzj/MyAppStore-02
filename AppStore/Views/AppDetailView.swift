//
//  AppDetailView.swift
//  AppStore
//
//  Created by 袁志健 on 2022/3/12.
//

import SwiftUI

struct AppDetailView: View {
    
    var appInfo: AppInfo = appList[0]
    var namespace: Namespace.ID
    @Binding var show: Bool
    @Binding var selectedId: UUID
    @State var appear = [false]
  
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                content
            }
            
            Button(action: {
                withAnimation(.closeCard) {
                    show = false
                    selectedId = UUID()
                }
            }) {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(Color.white)
                    .frame(width: 24, height: 24)
                    .padding(8)
                
            }
            .frame( maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding( 20)
            
        }
        .mask(RoundedRectangle(cornerRadius: 20, style: .continuous)
                .matchedGeometryEffect(id: "mask\(appInfo.id)", in: namespace, isSource: true))
        .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Color.white).shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                        .matchedGeometryEffect(id: "background\(appInfo.id)", in: namespace, isSource: true)
        )
        .ignoresSafeArea()
        .onAppear {
            fadeIn()
        }
        .onChange(of: show, perform: { newValue in
            fadeOut()
        })
    }
    
    func fadeIn() {
        withAnimation(.easeOut.delay(0.3)) {
            appear[0] = true
        }
    }
    
    func fadeOut() {
        appear[0] = false
    }
    
    var content: some View {
        
        VStack(alignment: .leading) {
            
            Image(appInfo.cover)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "cover\(appInfo.id)", in: namespace, isSource: true)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                
            Text(appInfo.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.primary)
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                .matchedGeometryEffect(id: "title\(appInfo.id)", in: namespace, isSource: true)
            
            Text(appInfo.description)
                .font(.callout)
                .foregroundColor(Color.secondary)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                .opacity(appear[0] ? 1.0 : 0.0)
            
            Color.clear.frame(height: 500)
            
        }
    }
}

struct AppDetailView_Previews: PreviewProvider {
    
    @Namespace static var namespace
    
    static var previews: some View {
        AppDetailView(namespace: namespace, show: .constant(false), selectedId: .constant(UUID()))
    }
}
