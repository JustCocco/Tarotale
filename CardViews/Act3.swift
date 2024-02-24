import SwiftUI

struct Act3: View {
    
   @EnvironmentObject var pvm: CardSelectionViewModel
    @State private var isRepViewActive = false
    @State private var xOffset: CGFloat = 0.0
    @State private var direction: CGFloat = 1.0
    let beigeColor = Color(red: 245/255, green: 245/255, blue: 220/255)
    @State private var randomThirdAct1: TarotCard
    @State private var randomThirdAct2: TarotCard
    
    init() {
        let thirdActCategory = "act3" // Category for third act cards
        let thirdActCards = TarotCardDataService.shared.tarotCards.filter { $0.category == thirdActCategory }
        let randomIndexThirdAct1 = Int.random(in: 0..<thirdActCards.count)
        var randomIndexThirdAct2 = Int.random(in: 0..<thirdActCards.count)
        
        while randomIndexThirdAct2 == randomIndexThirdAct1 {
            randomIndexThirdAct2 = Int.random(in: 0..<thirdActCards.count)
        }
        
        self._randomThirdAct1 = State(initialValue: thirdActCards[randomIndexThirdAct1])
        self._randomThirdAct2 = State(initialValue: thirdActCards[randomIndexThirdAct2])
    }
    
    var body: some View {
        ZStack{
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            Image("stars")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .offset(x: xOffset, y: 0)
                .animation(.linear(duration: 4.0))
                .onAppear {
                    // Start a timer to update the xOffset periodically
                    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                        // Update the xOffset based on the direction
                        xOffset += 1.0 * direction // Adjust the multiplier based on desired speed
                        
                        // Change direction if xOffset reaches boundary
                        if xOffset <= -50 {
                            direction = 1.0
                        } else if xOffset >= 50 {
                            direction = -1.0
                        }
                    }
                }
            VStack(spacing:10){
                NavigationLink(destination: ReportView().environmentObject(pvm), 
                               isActive: $isRepViewActive) {
                    EmptyView()
                }
                VStack{
                    Text("the Future").font(Font.custom("Basteleur-Moonlight", size: 24))
                        .foregroundColor(.white)
                        .shadow(color: Color.white.opacity(0.6), radius: 10)
                    Text("The third act is where the story's conflicts reach their peak,\n leading to the resolution of the main plotlines and the conclusion of the story.")
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                }.offset(y: -50)
                
                
                Button(action: {
                    saveThirdAct(thirdActCard: randomThirdAct1)
                    isRepViewActive = true
                }) {
                    VStack {
                        HStack {
                            Image(randomThirdAct1.imageName)
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 20)
                            VStack(alignment: .leading) { // Aligns content to the leading edge (left) of the VStack
                                Text(randomThirdAct1.name)
                                    .font(Font.custom("Basteleur-Bold", size: 18))
                                    .foregroundColor(beigeColor)
                                    .padding(.vertical,6)
                                
                                Text(randomThirdAct1.description)
                                    .foregroundColor(.white)
                                    .fontWeight(.light)
                                    .font(.system(size: 15))
                                .multilineTextAlignment(.leading)
                                
                            }
                            .padding()
                            .frame(width: 350, height: 280, alignment: .topLeading)
                            .background(.ultraThinMaterial.opacity(0.3)) // Use Color.ultraThinMaterial instead of .ultraThinMaterial
                            .cornerRadius(10)
                        }
                    }
                }
                
                Image("divider")
                    .resizable()
                    .scaleEffect(0.5)
                    .scaledToFill()
                    .frame(height: 50)
                
                Button(action: {
                    saveThirdAct(thirdActCard: randomThirdAct2)
                    isRepViewActive = true
                }) {
                    VStack {
                        HStack {
                            Image(randomThirdAct2.imageName)
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 20)
                            VStack(alignment: .leading) { // Aligns content to the leading edge (left) of the VStack
                                Text(randomThirdAct2.name)
                                    .font(Font.custom("Basteleur-Bold", size: 18))
                                    .foregroundColor(beigeColor)
                                    .padding(.vertical,6)
                                
                                Text(randomThirdAct2.description)
                                    .foregroundColor(.white)
                                    .fontWeight(.light)
                                    .font(.system(size: 15))
                                .multilineTextAlignment(.leading)
                                
                            }
                            .padding()
                            .frame(width: 350, height: 280, alignment: .topLeading)
                            .background(.ultraThinMaterial.opacity(0.3)) // Use Color.ultraThinMaterial instead of .ultraThinMaterial
                            .cornerRadius(10)
                        }
                    }
                    
                }
                
            }.padding(100)
            Spacer() 
            
        }
        
    }
    
    
    func saveThirdAct(thirdActCard: TarotCard) {
        pvm.ActThreeCard = thirdActCard
        // Here you can perform any additional actions with the protagonistCard, like saving it to a database or performing further logic
    }
    
}






