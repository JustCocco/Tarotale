import SwiftUI

public struct MyFont {
    public static func registerFonts() {
        registerFont(bundle: Bundle.main , fontName: "Basteleur-Moonlight", fontExtension: ".ttf")
        registerFont(bundle: Bundle.main, fontName: "Basteleur-Bold", fontExtension: ".ttf")//change according to your ext.
    }
    fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
        
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from data")
        }
        
        var error: Unmanaged<CFError>?
        
        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}

struct ContentView: View {
    
    @State private var isSheetPresented = false
    
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                Image("Na11")
                    .resizable()
                    .scaledToFill()
                    .background(Image("Background").resizable().ignoresSafeArea())
                
                
                
                ZStack {
                    
                    
                    
                    Button(action: {
                        self.isSheetPresented.toggle()
                    }) {
                        
                        
                        
                        Image("Scroll") // Replace "YourButtonImageName" with the name of your button image
                            .resizable()
                            .scaledToFit()
                        
                            .rotationEffect(.degrees(-20))
                            .frame(width: 200, height: 500) // Adjust size as needed
                            .shadow(radius: 30, y:20)
                        
                    }
                    .sheet(isPresented: $isSheetPresented, content: {
                        
                        
                        Image("Modal")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(1.5)
                            .ignoresSafeArea()
                            .presentationBackground(.clear)
                            .padding(30)
                        Button{
                            isSheetPresented = false
                        } label: {
                            Image("Cera")
                                .resizable()
                                .frame(width:80, height: 80)
                            
                        }
                        
                        .ignoresSafeArea()
                    })
                }.position(x: 300, y: 940)
                
                
                
                VStack {
                    // Push the NavigationLink to the bottom
                    
                    NavigationLink(destination: ProtCardView()) {
                        Image("cardBack")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 330)
                    }
                    .padding(.top,330)
                    .shadow(color: Color.black.opacity(0.8), radius: 10)
                    
                    
                }
                .foregroundColor(.white)
                .padding()
            }
            .navigationBarHidden(true) // Hide the navigation bar
        }
        .navigationViewStyle(StackNavigationViewStyle()) //
        
    }
    
}


