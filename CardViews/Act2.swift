import SwiftUI

struct Act2: View {
   @EnvironmentObject var pvm: CardSelectionViewModel
    @State private var isAct3CardViewActive = false
    @State private var xOffset: CGFloat = 0.0
    @State private var direction: CGFloat = 1.0
    let beigeColor = Color(red: 245/255, green: 245/255, blue: 220/255)
    @State private var randomSecondAct1: TarotCard
    @State private var randomSecondAct2: TarotCard
    
    init() {
        let secondActCategory = "act2" // Category for second act cards
        let secondActCards = TarotCardDataService.shared.tarotCards.filter { $0.category == secondActCategory }
        let randomIndexSecondAct1 = Int.random(in: 0..<secondActCards.count)
        var randomIndexSecondAct2 = Int.random(in: 0..<secondActCards.count)
        
        while randomIndexSecondAct2 == randomIndexSecondAct1 {
            randomIndexSecondAct2 = Int.random(in: 0..<secondActCards.count)
        }
        
        self._randomSecondAct1 = State(initialValue: secondActCards[randomIndexSecondAct1])
        self._randomSecondAct2 = State(initialValue: secondActCards[randomIndexSecondAct2])
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
                NavigationLink(destination: Act3().environmentObject(pvm), 
                               isActive: $isAct3CardViewActive) {
                    EmptyView()
                }
                VStack{
                    Text("the Present").font(Font.custom("Basteleur-Moonlight", size: 24))
                        .foregroundColor(.white)
                        .shadow(color: Color.white.opacity(0.6), radius: 10)
                    Text("During the second act, characters face obstacles and conflicts that escalate the tension\n and drive the narrative forward, leading to a climax or turning point.")
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                }.offset(y: -50)
                
                
                Button(action: {
                    saveSecondAct(secondActCard: randomSecondAct1)
                    isAct3CardViewActive = true
                }) {
                    VStack {
                        HStack {
                            Image(randomSecondAct1.imageName)
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 20)
                            VStack(alignment: .leading) { // Aligns content to the leading edge (left) of the VStack
                                Text(randomSecondAct1.name)
                                    .font(Font.custom("Basteleur-Bold", size: 18))
                                    .foregroundColor(beigeColor)
                                    .padding(.vertical,6)
                                
                                Text(randomSecondAct1.description)
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
                    saveSecondAct(secondActCard: randomSecondAct2)
                    isAct3CardViewActive = true
                }) {
                    VStack {
                        HStack {
                            Image(randomSecondAct2.imageName)
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 20)
                            VStack(alignment: .leading) { // Aligns content to the leading edge (left) of the VStack
                                Text(randomSecondAct2.name)
                                    .font(Font.custom("Basteleur-Bold", size: 18))
                                    .foregroundColor(beigeColor)
                                    .padding(.vertical,6)
                                
                                Text(randomSecondAct2.description)
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
    
    
    
    func saveSecondAct(secondActCard: TarotCard) {
        pvm.ActTwoCard = secondActCard
        // Here you can perform any additional actions with the protagonistCard, like saving it to a database or performing further logic
    }
    
}






