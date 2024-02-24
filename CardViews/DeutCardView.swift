import SwiftUI

struct DeutCardView: View {
    
@EnvironmentObject var pvm: CardSelectionViewModel
    @State private var isAct1CardViewActive = false
    @State private var xOffset: CGFloat = 0.0
    @State private var direction: CGFloat = 1.0
    let beigeColor = Color(red: 245/255, green: 245/255, blue: 220/255)
    @State private var randomCardDeut1: TarotCard 
    @State private var randomCardDeut2: TarotCard 
    
    init() {
        let deutCategory = "deut" // Category for deuteragonist cards
        let deutCards = TarotCardDataService.shared.tarotCards.filter { $0.category == deutCategory }
        
        let randomIndexDeut1 = Int.random(in: 0..<deutCards.count)
        var randomIndexDeut2 = Int.random(in: 0..<deutCards.count)
        
        while randomIndexDeut2 == randomIndexDeut1 {
            randomIndexDeut2 = Int.random(in: 0..<deutCards.count)
        }
        
        self._randomCardDeut1 = State(initialValue: deutCards[randomIndexDeut1])
        self._randomCardDeut2 = State(initialValue: deutCards[randomIndexDeut2])
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
                NavigationLink(destination: Act1().environmentObject(pvm), 
                               isActive: $isAct1CardViewActive) {
                    EmptyView()
                }
                VStack{
                    Text("Choose your Deuteragonist").font(Font.custom("Basteleur-Moonlight", size: 24))
                        .foregroundColor(.white)
                        .shadow(color: Color.white.opacity(0.6), radius: 10)
                    Text("the secondary main character in a story,\n after the protagonist; plays a supporting or contrasting role")
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                }.offset(y: -50)
                
                
                Button(action: {
                    saveDeuteragonistCard(cardDeut: randomCardDeut1)
                    isAct1CardViewActive = true
                }) {
                    VStack {
                        HStack {
                            Image(randomCardDeut1.imageName)
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 20)
                            VStack(alignment: .leading) { // Aligns content to the leading edge (left) of the VStack
                                Text(randomCardDeut1.name)
                                    .font(Font.custom("Basteleur-Bold", size: 18))
                                    .foregroundColor(beigeColor)
                                    .padding(.vertical,6)
                                
                                Text(randomCardDeut1.description)
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
                    saveDeuteragonistCard(cardDeut: randomCardDeut2)
                    isAct1CardViewActive = true
                }) {
                    VStack {
                        HStack {
                            Image(randomCardDeut2.imageName)
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 20)
                            VStack(alignment: .leading) { // Aligns content to the leading edge (left) of the VStack
                                Text(randomCardDeut2.name)
                                    .font(Font.custom("Basteleur-Bold", size: 18))
                                    .foregroundColor(beigeColor)
                                    .padding(.vertical,6)
                                
                                Text(randomCardDeut2.description)
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
    
    
    
    func saveDeuteragonistCard(cardDeut: TarotCard) {
        pvm.DeuteragonistCard = cardDeut
         print("deut card saved:", cardDeut.name)
    }
    
}





