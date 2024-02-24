import SwiftUI
import MobileCoreServices

struct ReportView: View {
    @EnvironmentObject var pvm: CardSelectionViewModel
    @State private var xOffset: CGFloat = 0.0
    @State private var direction: CGFloat = 1.0
    @State private var showAlert = false
    
    
   
    
    
    var body: some View {
        ZStack{
            Image("backRep")
                .resizable()
                .ignoresSafeArea()
            Image("starsblurred")
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
            scrollView
        }
    }
    
    
    
    func copyTextToClipboard() {
            var textToCopy = "Your Tarotale:\n"
            if let protagonist = pvm.protagonistCard {
                textToCopy += "\nProtagonist: \(protagonist.name)\n\(protagonist.description)"
            }
            if let antagonist = pvm.antagonistCard {
                textToCopy += "\n\nAntagonist: \(antagonist.name)\n\(antagonist.description)"
            }
            if let deuteragonist = pvm.DeuteragonistCard {
                textToCopy += "\n\nDeuteragonist: \(deuteragonist.name)\n\(deuteragonist.description)"
            }
            if let actOne = pvm.ActOneCard {
                textToCopy += "\n\nAct One: \(actOne.name)\n\(actOne.description)"
            }
            if let actTwo = pvm.ActTwoCard {
                textToCopy += "\n\nAct Two: \(actTwo.name)\n\(actTwo.description)"
            }
            if let actThree = pvm.ActThreeCard {
                textToCopy += "\n\nAct Three: \(actThree.name)\n\(actThree.description)"
            }

            // Copy text to clipboard
            UIPasteboard.general.setValue(textToCopy, forPasteboardType: kUTTypePlainText as String)
            showAlert = true
        }

}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
            .environmentObject(CardSelectionViewModel()) // Provide a sample environment object for preview
    }
}

struct CardView: View {
    let card: TarotCard
    
    var body: some View {
        VStack {
            HStack {
                Image(card.imageName)
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 20)
                    .frame(width: 180, height:300)
                
                VStack(alignment: .leading) {
                    Text(card.name)
                        .font(Font.custom("Basteleur-Bold", size: 18))
                        .foregroundColor(Color(red: 95/255, green: 38/255, blue:38/255))
                        .padding(.vertical, 6)
                    
                    Text(card.description)
                        .foregroundColor(.black)
                        .fontWeight(.regular)
                        .font(.system(size: 15))
                        
                }
                .padding()
                .frame(width: 350, height: 260, alignment: .topLeading)
                .background(.ultraThinMaterial.opacity(0.3))
                .cornerRadius(10)
            }
        }
    }
    
}
extension ReportView {
    private var scrollView : some View {
        ScrollView{
            VStack {
                Image("triquetre")
                    .resizable()
                    .scaledToFit()
                    .frame(width:90)
                    .shadow(color: .white,radius: 5)
                
                Text("Your Tarotale has been Drawn")
                    .font(Font.custom("Basteleur-Moonlight", size: 24))
                    .foregroundStyle(.white)
                    .shadow(color: Color.white.opacity(0.4), radius: 20)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                Spacer()
                VStack{
                    
                    // Protagonist Card
                    if let prot = pvm.protagonistCard {
                        VStack{
                            Text("Your Protagonist")
                                .font(Font.custom("Basteleur-Bold", size: 24))
                                .foregroundStyle(Color(red: 95/255, green: 59/255, blue:59/255))
                            
                            Divider().background(Color(red: 95/255, green: 59/255, blue:59/255))
                            
                            
                            CardView(card: prot)
                        }.padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                    } else {
                        Text("No protagonist card selected")
                    }
                    
                    // Antagonist Card
                    if let ant = pvm.antagonistCard {
                        VStack{
                            Text("Your Antagonist")
                                .font(Font.custom("Basteleur-Bold", size: 24))
                                .foregroundStyle(Color(red: 95/255, green: 59/255, blue:59/255))
                            Divider().background(Color(red: 95/255, green: 59/255, blue:59/255))
                            
                            CardView(card: ant)}.padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
                    } else {
                        Text("No antagonist card selected")
                    }
                    
                    // Deuteragonist Card
                    if let deut = pvm.DeuteragonistCard {
                        VStack{
                            Text("Your Deuteragonist")
                                .font(Font.custom("Basteleur-Bold", size: 24))
                                .foregroundStyle(Color(red: 95/255, green: 59/255, blue:59/255))
                            Divider().background(Color(red: 95/255, green: 59/255, blue:59/255))
                            CardView(card: deut)}.padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
                    } else {
                        Text("No deuteragonist card selected")
                    }
                    
                    Image("divider2")
                        .resizable()
                        .scaleEffect(0.8)
                        .scaledToFill()
                        .saturation(1.5)
                        .shadow(radius: 5)
                        .frame(height: 50)
                    
                    
                    // Act One Card
                    if let actOne = pvm.ActOneCard {
                        VStack{
                            Text("Your Past")
                                .font(Font.custom("Basteleur-Bold", size: 24))
                                .foregroundStyle(Color(red: 95/255, green: 59/255, blue:59/255))
                            Divider().background(Color(red: 95/255, green: 59/255, blue:59/255))
                            
                            CardView(card: actOne)}.padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
                    } else {
                        Text("No Act One card selected")
                    }
                    
                    // Act Two Card
                    if let actTwo = pvm.ActTwoCard {
                        VStack{
                            Text("Your Present")
                                .font(Font.custom("Basteleur-Bold", size: 24))
                                .foregroundStyle(Color(red: 95/255, green: 59/255, blue:59/255))
                            Divider().background(Color(red: 95/255, green: 59/255, blue:59/255))
                            CardView(card: actTwo)}.padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
                    } else {
                        Text("No Act Two card selected")
                    }
                    
                    // Act Three Card
                    if let actThree = pvm.ActThreeCard {
                        VStack{
                            Text("Your Future")
                                .font(Font.custom("Basteleur-Bold", size: 24))
                                .foregroundStyle(Color(red: 95/255, green: 59/255, blue:59/255))
                            Divider().background(Color(red: 95/255, green: 59/255, blue:59/255))
                            CardView(card: actThree)}.padding(EdgeInsets(top: 10, leading: 0, bottom: 30, trailing: 0))
                    } else {
                        Text("No Act Three card selected")
                    }
                    
                    Image("divider2")
                        .resizable()
                        .scaleEffect(0.8)
                        .scaledToFill()
                        .frame(height: 50)
                        .saturation(1.5)
                        .shadow(radius: 5)
                    
                    Text("Now it's time to tell your story,\n so grab a pen and paper and start writing")
                        .font(Font.custom("Basteleur-Bold", size: 24))
                        .foregroundStyle(Color(red: 95/255, green: 59/255, blue:59/255))
                        .padding(.vertical, 50)
                        .multilineTextAlignment(.center)
                    
                        
                        Button(action: {
                            showAlert = true
                            copyTextToClipboard()
                            
                        }) {
                            Image("DownloadBut")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90)
                                .shadow(radius: 5)
                        }
                        .padding()
                        .alert(isPresented: $showAlert){Alert(title:Text( "Your Tarotale has been saved in your clipboard!"))}
                        
                        
                        
                    
                    
                }.frame(width: 650)
                    .padding(40)
                    .background(Image("Report").resizable().scaledToFill().offset(CGSize(width: 10.0, height: 10.0)).saturation(0.4))
                
                
                
            }
        }.padding(.vertical, 30)
    }}
