//
//  LearnView.swift
//  Manitas Mx
//

import SwiftUI

// MARK: - Letter Model
struct LSMLetter: Identifiable {
    let id = UUID()
    let letter: String
    let description: String
    let tips: String
}

// MARK: - Data
let lsmLetters: [LSMLetter] = [
    LSMLetter(letter: "A", description: "Con la mano cerrada, se muestran las uñas y se estira el dedo pulgar hacia un lado.", tips: "La palma mira al frente. El pulgar queda paralelo al costado de la mano."),
    LSMLetter(letter: "B", description: "Los dedos índice, medio, anular y meñique se estiran bien unidos y el pulgar se dobla hacia la palma.", tips: "La palma mira al frente. Los cuatro dedos deben quedar perfectamente juntos y rectos."),
    LSMLetter(letter: "C", description: "Los dedos índice, medio, anular y meñique se mantienen bien unidos en posición cóncava; el pulgar también se pone en esa posición.", tips: "La palma mira a un lado. Imagina que sostienes una pelota pequeña."),
    LSMLetter(letter: "D", description: "Los dedos medio, anular, meñique y pulgar se unen por las puntas y el dedo índice se estira.", tips: "La palma mira al frente. El índice apunta hacia arriba formando una D."),
    LSMLetter(letter: "E", description: "Se doblan los dedos completamente, y se muestran las uñas.", tips: "La palma mira al frente. Todos los dedos doblan hacia la palma mostrando las uñas."),
    LSMLetter(letter: "F", description: "Con la mano abierta y los dedos bien unidos, se dobla el índice hasta que su parte lateral toque la yema del pulgar.", tips: "La palma mira a un lado. Los otros tres dedos quedan extendidos y juntos."),
    LSMLetter(letter: "G", description: "Se cierra la mano y los dedos índice y pulgar se estiran apuntando hacia el lado.", tips: "La palma mira hacia ti. El índice y pulgar forman una L horizontal."),
    LSMLetter(letter: "H", description: "Con la mano cerrada y los dedos índice y medio bien estirados y unidos, se extiende el pulgar señalando hacia arriba.", tips: "La palma mira hacia ti. El índice y medio apuntan horizontalmente hacia el lado."),
    LSMLetter(letter: "I", description: "Con la mano cerrada, el dedo meñique se estira señalando hacia arriba.", tips: "La palma se pone de lado. Solo el meñique queda extendido."),
    LSMLetter(letter: "J", description: "Con la mano cerrada y el meñique estirado señalando hacia arriba, se dibuja una J en el aire.", tips: "La palma queda a un lado. Traza la forma de la letra J con el meñique haciendo un movimiento curvo."),
    LSMLetter(letter: "K", description: "Se cierra la mano con los dedos índice, medio y pulgar estirados. La yema del pulgar se pone entre el índice y el medio.", tips: "Se mueve la muñeca hacia arriba. El pulgar queda entre los dos dedos extendidos."),
    LSMLetter(letter: "L", description: "Con la mano cerrada y los dedos índice y pulgar estirados, se forma una L.", tips: "La palma mira al frente. El índice apunta arriba y el pulgar apunta hacia el lado."),
    LSMLetter(letter: "M", description: "Con la mano cerrada, se ponen los dedos índice, medio y anular sobre el pulgar.", tips: "Los tres dedos cubren el pulgar. La palma mira al frente."),
    LSMLetter(letter: "N", description: "Con la mano cerrada, se ponen los dedos índice y medio sobre el pulgar.", tips: "Solo dos dedos cubren el pulgar, a diferencia de la M que usa tres."),
    LSMLetter(letter: "Ñ", description: "Con la mano cerrada, se ponen los dedos índice y medio sobre el pulgar. Se mueve la muñeca a los lados.", tips: "Es igual que la N pero con un movimiento lateral de muñeca que simula la tilde de la Ñ."),
    LSMLetter(letter: "O", description: "Con la mano se forma una letra O. Todos los dedos se tocan por las puntas.", tips: "Todos los dedos y el pulgar se curvan y sus puntas se unen formando un óvalo."),
    LSMLetter(letter: "P", description: "Con la mano cerrada y los dedos índice, medio y pulgar estirados, se pone la yema del pulgar entre el índice y el medio.", tips: "La mano apunta hacia abajo. Similar a la K pero orientada hacia abajo."),
    LSMLetter(letter: "Q", description: "Con la mano cerrada, se ponen los dedos índice y pulgar en posición de garra. La palma mira hacia abajo.", tips: "Se mueve la muñeca hacia los lados. El índice y pulgar apuntan hacia el suelo."),
    LSMLetter(letter: "R", description: "Con la mano cerrada, se estiran y entrelazan los dedos índice y medio.", tips: "La palma mira al frente. Los dos dedos se cruzan uno sobre el otro."),
    LSMLetter(letter: "S", description: "Con la mano cerrada, se pone el pulgar sobre los otros dedos.", tips: "La palma mira al frente. El pulgar queda cruzado por encima de los demás dedos cerrados."),
    LSMLetter(letter: "T", description: "Con la mano cerrada, el pulgar se pone entre los dedos índice y el medio.", tips: "La palma mira al frente. El pulgar asoma entre el índice y el medio."),
    LSMLetter(letter: "U", description: "Con la mano cerrada, se estiran los dedos índice y medio unidos.", tips: "La palma mira al frente. Los dos dedos van juntos y rectos hacia arriba."),
    LSMLetter(letter: "V", description: "Con la mano cerrada, se estiran los dedos índice y medio separados.", tips: "La palma mira al frente. Es la clásica V de victoria con los dos dedos abiertos."),
    LSMLetter(letter: "W", description: "Con la mano cerrada, se estiran los dedos índice, medio y anular separados.", tips: "La palma mira al frente. Tres dedos extendidos y separados formando una W."),
    LSMLetter(letter: "X", description: "Con la mano cerrada, el índice y el pulgar en posición de garra, la palma dirigida a un lado.", tips: "Se realiza un movimiento al frente y de regreso. El índice se dobla como un gancho."),
    LSMLetter(letter: "Y", description: "Con la mano cerrada, se estira el dedo meñique y el pulgar.", tips: "La palma mira hacia ti. Es el gesto de 'te llamo' o 'llámame'."),
    LSMLetter(letter: "Z", description: "Con la mano cerrada, el dedo índice estirado y la palma al frente, se dibuja una letra Z en el aire.", tips: "Traza la forma de la Z con el índice: horizontal, diagonal y horizontal de nuevo.")
]

// MARK: - Learn View
struct LearnView: View {
    @State private var searchText = ""
    @State private var selectedLetter: LSMLetter? = nil

    var filtered: [LSMLetter] {
        if searchText.isEmpty { return lsmLetters }
        return lsmLetters.filter { $0.letter.lowercased().contains(searchText.lowercased()) }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color("FondoOscuro").ignoresSafeArea()
                VStack(spacing: 0) {
                    // Header
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Aprender")
                                    .font(.system(size: 32, weight: .black))
                                    .foregroundColor(.white)
                                Text("Abecedario LSM")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color("Naranja"))
                            }
                            Spacer()
                            Text("🤟")
                                .font(.system(size: 36))
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 60)
                        .padding(.bottom, 12)

                        // Search bar
                        HStack(spacing: 10) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray).font(.system(size: 15))
                            TextField("Buscar letra...", text: $searchText)
                                .foregroundColor(.white)
                                .tint(Color("Naranja"))
                            if !searchText.isEmpty {
                                Button(action: { searchText = "" }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray).font(.system(size: 15))
                                }
                            }
                        }
                        .padding(.horizontal, 14).padding(.vertical, 10)
                        .background(Color("Superficie"))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .padding(.horizontal, 20)
                        .padding(.bottom, 16)
                    }
                    .background(Color("FondoOscuro"))

                    // Letter list
                    List {
                        ForEach(filtered) { item in
                            Button(action: { selectedLetter = item }) {
                                HStack(spacing: 16) {
                                    ZStack {
                                        Circle()
                                            .fill(Color("Naranja").opacity(0.18))
                                            .frame(width: 52, height: 52)
                                        Circle()
                                            .stroke(Color("Naranja").opacity(0.35), lineWidth: 1.5)
                                            .frame(width: 52, height: 52)
                                        Text(item.letter)
                                            .font(.system(size: 22, weight: .black, design: .rounded))
                                            .foregroundColor(Color("Naranja"))
                                    }
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Letra \(item.letter)")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(.white)
                                        Text(item.description)
                                            .font(.system(size: 13))
                                            .foregroundColor(.gray)
                                            .lineLimit(2)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(Color("Naranja").opacity(0.5))
                                }
                                .padding(.vertical, 6)
                            }
                            .listRowBackground(Color("Superficie").opacity(0.6))
                            .listRowSeparatorTint(Color("Naranja").opacity(0.12))
                        }
                        Color.clear.frame(height: 20).listRowBackground(Color.clear).listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .background(Color("FondoOscuro"))
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationBarHidden(true)
            .sheet(item: $selectedLetter) { letter in
                LetterDetailView(letter: letter)
            }
        }
    }
}

// MARK: - Letter Detail Sheet
struct LetterDetailView: View {
    let letter: LSMLetter
    @Environment(\.dismiss) var dismiss

    private func imageAssetName(for letter: String) -> String {
        switch letter {
        case "Ñ": return "letraÑ 1"
        default:  return "letra\(letter)"
        }
    }

    var body: some View {
        ZStack {
            Color("FondoOscuro").ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 28) {
                    // Drag indicator
                    Capsule()
                        .fill(Color("Superficie"))
                        .frame(width: 40, height: 4)
                        .padding(.top, 12)

                    // Big letter display
                    ZStack {
                        Circle()
                            .fill(LinearGradient(
                                colors: [Color("Naranja").opacity(0.20), Color("Rosa").opacity(0.10)],
                                startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 160, height: 160)
                        Circle()
                            .stroke(Color("Naranja").opacity(0.40), lineWidth: 2)
                            .frame(width: 160, height: 160)
                        Text(letter.letter)
                            .font(.system(size: 80, weight: .black, design: .rounded))
                            .foregroundColor(Color("Naranja"))
                    }

                    // Title
                    VStack(spacing: 6) {
                        Text("Letra \(letter.letter)")
                            .font(.system(size: 28, weight: .black))
                            .foregroundColor(.white)
                        Text("Abecedario LSM")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(Color("Naranja"))
                            .padding(.horizontal, 12).padding(.vertical, 4)
                            .background(Color("Naranja").opacity(0.12))
                            .clipShape(Capsule())
                    }

                    // ── Recuadro de imagen ──────────────────────────────
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("Superficie"))
                            .frame(height: 240)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color("Naranja").opacity(0.25), lineWidth: 1.5)
                            )
                        if let img = UIImage(named: imageAssetName(for: letter.letter)) {
                            Image(uiImage: img)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 220)
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                        } else {
                            VStack(spacing: 10) {
                                Image(systemName: "hand.raised.fill")
                                    .font(.system(size: 46))
                                    .foregroundColor(Color("Naranja").opacity(0.3))
                                Text("Imagen próximamente")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(.gray)
                                Text("\"\(imageAssetName(for: letter.letter))\" en Assets")
                                    .font(.system(size: 11))
                                    .foregroundColor(Color("Naranja").opacity(0.5))
                            }
                        }
                    }
                    .padding(.horizontal, 20)

                    // Description card
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 8) {
                            Image(systemName: "hand.raised.fill")
                                .foregroundColor(Color("Naranja")).font(.system(size: 14))
                            Text("CÓMO HACERLA")
                                .font(.system(size: 11, weight: .black)).tracking(1.5)
                                .foregroundColor(Color("Naranja"))
                        }
                        Text(letter.description)
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .lineSpacing(6)
                    }
                    .padding(18)
                    .background(Color("Superficie"))
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .overlay(RoundedRectangle(cornerRadius: 18).stroke(Color("Naranja").opacity(0.18), lineWidth: 1))
                    .padding(.horizontal, 20)

                    // Tips card
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 8) {
                            Image(systemName: "lightbulb.fill")
                                .foregroundColor(Color("Amarillo")).font(.system(size: 14))
                            Text("CONSEJO")
                                .font(.system(size: 11, weight: .black)).tracking(1.5)
                                .foregroundColor(Color("Amarillo"))
                        }
                        Text(letter.tips)
                            .font(.system(size: 15))
                            .foregroundColor(.white.opacity(0.85))
                            .lineSpacing(5)
                    }
                    .padding(18)
                    .background(Color("Superficie"))
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .overlay(RoundedRectangle(cornerRadius: 18).stroke(Color("Amarillo").opacity(0.18), lineWidth: 1))
                    .padding(.horizontal, 20)

                    // Practice prompt
                    VStack(spacing: 10) {
                        Image(systemName: "camera.fill")
                            .font(.system(size: 28)).foregroundColor(Color("Azul"))
                        Text("¡Practica con la cámara!")
                            .font(.system(size: 15, weight: .bold)).foregroundColor(.white)
                        Text("Ve a la pestaña Cámara y muestra la seña para que la IA la reconozca.")
                            .font(.system(size: 13)).foregroundColor(.gray)
                            .multilineTextAlignment(.center).lineSpacing(4)
                    }
                    .padding(20)
                    .background(Color("Azul").opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .overlay(RoundedRectangle(cornerRadius: 18).stroke(Color("Azul").opacity(0.22), lineWidth: 1))
                    .padding(.horizontal, 20)

                    Spacer(minLength: 40)
                }
            }
        }
        .presentationDetents([.large])
        .presentationDragIndicator(.hidden)
    }
}
