import SwiftUI

struct PokemonImageView: View {
    var url: String
    var background: Color
    var size: CGFloat = CGFloat(120)
 
    
    var body: some View {
        
        // Loads the URLSession instance + displays it
        // until it loads, the view displays a placeholder
        // phase is object of AsyncImagePhase -> current pahse of
        // the asynchronous image loading operation
        AsyncImage(url: URL(string: url)){phase in
            if let image = phase.image{
                image.resizable()
                    .frame(width: 120, height: 120)
            }else if phase.error != nil {
                Color.red
            } else {
                ProgressView()
            }
        }
        .frame(width: size, height: size)
        .background(background.opacity(0.2))
        .clipShape(Circle())
    }
}

#Preview {
    PokemonImageView(url:"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png", background: Color.gray)
}

    
        
        
        
