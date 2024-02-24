import SwiftUI
import Combine

class CardSelectionViewModel: ObservableObject {
    @Published var protagonistCard: TarotCard?
    @Published var DeuteragonistCard: TarotCard?
    @Published var antagonistCard: TarotCard?
    @Published var ActOneCard: TarotCard?
    @Published var ActTwoCard: TarotCard?
    @Published var ActThreeCard: TarotCard?
    
}


struct ProtCardView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var pvm = CardSelectionViewModel()
    @State private var isAntCardViewActive = false
    @State private var xOffset: CGFloat = 0.0
    @State private var direction: CGFloat = 1.0
    let beigeColor = Color(red: 245/255, green: 245/255, blue: 220/255)
    let randomCardProt1: TarotCard
    let randomCardProt2: TarotCard
    
    init() {
        let protCategory = "prot" // Category for protagonist cards
        let protCards = TarotCardDataService.shared.tarotCards.filter { $0.category == protCategory }
        let randomIndex1 = Int.random(in: 0..<protCards.count)
        var randomIndex2 = Int.random(in: 0..<protCards.count)
        
        while randomIndex2 == randomIndex1 {
            randomIndex2 = Int.random(in: 0..<protCards.count)
        }
        
        self.randomCardProt1 = protCards[randomIndex1]
        self.randomCardProt2 = protCards[randomIndex2]
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
                NavigationLink(destination: AntCardView().environmentObject(pvm), isActive: $isAntCardViewActive) {
                    EmptyView()
                }
                VStack{
                    Text("Choose your Protagonist").font(Font.custom("Basteleur-Moonlight", size: 24))
                        .foregroundColor(.white)
                        .shadow(color: Color.white.opacity(0.6), radius: 10)
                    Text("the main character or central figure in a story, around whom the plot revolves")
                        .font(.body)
                        .foregroundColor(.white)
                    
                }.offset(y: -50)
                
                
                Button(action: {
                    saveProtagonistCard(card: randomCardProt1)
                    isAntCardViewActive = true
                }) {
                    VStack {
                        HStack {
                            Image(randomCardProt1.imageName)
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 20)
                            VStack(alignment: .leading) { // Aligns content to the leading edge (left) of the VStack
                                Text(randomCardProt1.name)
                                    .font(Font.custom("Basteleur-Bold", size: 18))
                                .foregroundColor(beigeColor)
                                .padding(.vertical,6)
                                
                                Text(randomCardProt1.description)
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
                    saveProtagonistCard(card: randomCardProt2)
                    isAntCardViewActive = true
                }) {
                    VStack {
                        HStack {
                            Image(randomCardProt2.imageName)
                                .resizable()
                                .scaledToFit()
                            .shadow(radius: 20)
                            VStack(alignment: .leading) { // Aligns content to the leading edge (left) of the VStack
                                Text(randomCardProt2.name)
                                    .font(Font.custom("Basteleur-Bold", size: 18))
                                    .foregroundColor(beigeColor)
                                    .padding(.vertical,6)
                                
                                Text(randomCardProt2.description)
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
    func saveProtagonistCard(card: TarotCard) {
        pvm.protagonistCard = card
       print("Protagonist card saved:", card.name)
    }
    
}

        
        
       
   
