import SwiftUI

struct Act1: View {
    @EnvironmentObject var pvm: CardSelectionViewModel
    @State private var isAct2CardViewActive = false
    @State private var xOffset: CGFloat = 0.0
    @State private var direction: CGFloat = 1.0
    let beigeColor = Color(red: 245/255, green: 245/255, blue: 220/255)
    @State private var randomFirstAct1: TarotCard
    @State private var randomFirstAct2: TarotCard
    
    init() {
        let firstActCategory = "act1" // Category for first act cards
        let firstActCards = TarotCardDataService.shared.tarotCards.filter { $0.category == firstActCategory }
        let randomIndexFirstAct1 = Int.random(in: 0..<firstActCards.count)
        var randomIndexFirstAct2 = Int.random(in: 0..<firstActCards.count)
        
        while randomIndexFirstAct2 == randomIndexFirstAct1 {
            randomIndexFirstAct2 = Int.random(in: 0..<firstActCards.count)
        }
        
        self._randomFirstAct1 = State(initialValue: firstActCards[randomIndexFirstAct1])
        self._randomFirstAct2 = State(initialValue: firstActCards[randomIndexFirstAct2])
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
                NavigationLink(destination: Act2().environmentObject(pvm), 
                               isActive: $isAct2CardViewActive) {
                    EmptyView()
                }
                VStack{
                    Text("the Past").font(Font.custom("Basteleur-Moonlight", size: 24))
                        .foregroundColor(.white)
                        .shadow(color: Color.white.opacity(0.6), radius: 10)
                    Text("the first act is the initial phase of a narrative\n where the groundwork is laid for the story's main elements")
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                }.offset(y: -50)
                
                
                Button(action: {
                    saveFirstAct(firstActCard: randomFirstAct1)
                    isAct2CardViewActive = true
                }) {
                    VStack {
                        HStack {
                            Image(randomFirstAct1.imageName)
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 20)
                            VStack(alignment: .leading) { // Aligns content to the leading edge (left) of the VStack
                                Text(randomFirstAct1.name)
                                    .font(Font.custom("Basteleur-Bold", size: 18))
                                    .foregroundColor(beigeColor)
                                    .padding(.vertical,6)
                                
                                Text(randomFirstAct1.description)
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
                    saveFirstAct(firstActCard: randomFirstAct2)
                    isAct2CardViewActive = true
                }) {
                    VStack {
                        HStack {
                            Image(randomFirstAct2.imageName)
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 20)
                            VStack(alignment: .leading) { // Aligns content to the leading edge (left) of the VStack
                                Text(randomFirstAct2.name)
                                    .font(Font.custom("Basteleur-Bold", size: 18))
                                    .foregroundColor(beigeColor)
                                    .padding(.vertical,6)
                                
                                Text(randomFirstAct2.description)
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
    
    
    func saveFirstAct(firstActCard: TarotCard) {
        pvm.ActOneCard = firstActCard
        // Here you can perform any additional actions with the protagonistCard, like saving it to a database or performing further logic
    }
    
}





