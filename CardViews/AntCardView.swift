import SwiftUI

struct AntCardView: View {
    
    @EnvironmentObject var pvm: CardSelectionViewModel
    @State private var isDeutCardViewActive = false
    @State private var xOffset: CGFloat = 0.0
    @State private var direction: CGFloat = 1.0
    let beigeColor = Color(red: 245/255, green: 245/255, blue: 220/255)
    @State private var randomCardAnt1: TarotCard
    @State private var randomCardAnt2: TarotCard
    
    init() {
        let antCategory = "ant" // Category for antagonist cards
        let antCards = TarotCardDataService.shared.tarotCards.filter { $0.category == antCategory }
        
        let randomIndexAnt1 = Int.random(in: 0..<antCards.count)
        var randomIndexAnt2 = Int.random(in: 0..<antCards.count)
        
        while randomIndexAnt2 == randomIndexAnt1 {
            randomIndexAnt2 = Int.random(in: 0..<antCards.count)
        }
        
        self._randomCardAnt1 = State(initialValue: antCards[randomIndexAnt1])
        self._randomCardAnt2 = State(initialValue: antCards[randomIndexAnt2])
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
                NavigationLink(destination: DeutCardView().environmentObject(pvm), 
                               isActive: $isDeutCardViewActive) {
                    EmptyView()
                }
                VStack{
                    Text("Choose your Antagonist").font(Font.custom("Basteleur-Moonlight", size: 24))
                        .foregroundColor(.white)
                        .shadow(color: Color.white.opacity(0.6), radius: 10)
                    Text("the character or force that opposes the protagonist in a story")
                        .font(.body)
                        .foregroundColor(.white)
                    
                }.offset(y: -50)
                
                Button(action: {
                    saveAntagonistCard(cardAnt: randomCardAnt1)
                    isDeutCardViewActive = true
                }) {
                    VStack {
                        HStack {
                            Image(randomCardAnt1.imageName)
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 20)
                            VStack(alignment: .leading) { // Aligns content to the leading edge (left) of the VStack
                                Text(randomCardAnt1.name)
                                    .font(Font.custom("Basteleur-Bold", size: 18))
                                    .foregroundColor(beigeColor)
                                    .padding(.vertical,6)
                                
                                Text(randomCardAnt1.description)
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
                    saveAntagonistCard(cardAnt: randomCardAnt2)
                    isDeutCardViewActive = true
                }) {
                    VStack {
                        HStack {
                            Image(randomCardAnt2.imageName)
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 20)
                            VStack(alignment: .leading) { // Aligns content to the leading edge (left) of the VStack
                                Text(randomCardAnt2.name)
                                    .font(Font.custom("Basteleur-Bold", size: 18))
                                    .foregroundColor(beigeColor)
                                    .padding(.vertical,6)
                                
                                Text(randomCardAnt2.description)
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
    
    
    func saveAntagonistCard(cardAnt: TarotCard) {
        pvm.antagonistCard = cardAnt
        print("ant:", cardAnt.name )
        // Here you can perform any additional actions with the protagonistCard, like saving it to a database or performing further logic
    }
    
}





