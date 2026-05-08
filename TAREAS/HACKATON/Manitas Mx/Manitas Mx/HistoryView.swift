//
//  HistoryView.swift
//  Manitas Mx
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var history: HistoryStore
    @State private var showDeleteAlert = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color("FondoOscuro").ignoresSafeArea()
                VStack(spacing: 0) {
                    // Header
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Historial")
                                .font(.system(size: 32, weight: .black))
                                .foregroundColor(.white)
                            Text("\(history.items.count) traducción\(history.items.count != 1 ? "es" : "")")
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        if !history.items.isEmpty {
                            Button(action: { showDeleteAlert = true }) {
                                Label("Borrar todo", systemImage: "trash.fill")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(Color("Rosa"))
                                    .padding(.horizontal, 14).padding(.vertical, 8)
                                    .background(Color("Rosa").opacity(0.10))
                                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("Rosa").opacity(0.32), lineWidth: 1))
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 60)
                    .padding(.bottom, 16)

                    // Content
                    if history.items.isEmpty {
                        emptyState
                    } else {
                        historyList
                    }
                }
            }
            .navigationBarHidden(true)
            .alert("¿Borrar todo el historial?", isPresented: $showDeleteAlert) {
                Button("Borrar", role: .destructive) { withAnimation { history.deleteAll() } }
                Button("Cancelar", role: .cancel) {}
            } message: {
                Text("Esta acción no se puede deshacer.")
            }
        }
    }

    // MARK: - Empty State
    private var emptyState: some View {
        VStack {
            Spacer()
            VStack(spacing: 16) {
                ZStack {
                    Circle().fill(Color("Azul").opacity(0.08)).frame(width: 96, height: 96)
                    Image(systemName: "clock.arrow.circlepath")
                        .font(.system(size: 38))
                        .foregroundColor(Color("Azul").opacity(0.42))
                }
                Text("Sin traducciones aún")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.gray.opacity(0.6))
                Text("Las señas y letras LSM traducidas\naparecerán aquí automáticamente.")
                    .font(.system(size: 14))
                    .foregroundColor(.gray.opacity(0.4))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
            }
            Spacer()
        }
    }

    // MARK: - History List
    private var historyList: some View {
        List {
            ForEach(history.grouped, id: \.0) { hour, groupItems in
                Section {
                    ForEach(groupItems) { item in
                        historyRow(item)
                            .listRowBackground(Color("Superficie").opacity(0.6))
                            .listRowSeparatorTint(Color("Naranja").opacity(0.12))
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    withAnimation { history.delete(item) }
                                } label: {
                                    Label("Borrar", systemImage: "trash")
                                }
                            }
                            .swipeActions(edge: .leading) {
                                Button { shareItem(item) } label: {
                                    Label("Compartir", systemImage: "square.and.arrow.up")
                                }
                                .tint(Color("Azul"))
                            }
                    }
                } header: {
                    Label(hour, systemImage: "clock")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.gray)
                        .textCase(nil)
                        .padding(.leading, 4)
                }
            }
            Color.clear.frame(height: 20).listRowBackground(Color.clear).listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .background(Color("FondoOscuro"))
        .scrollContentBackground(.hidden)
    }

    // MARK: - Row
    private func historyRow(_ item: LSMResult) -> some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color("Naranja").opacity(0.18))
                    .frame(width: 50, height: 50)
                    .shadow(color: Color("Naranja").opacity(0.25), radius: 8)
                Text(item.sena.prefix(1))
                    .font(.system(size: 22, weight: .black))
                    .foregroundColor(Color("Naranja"))
            }
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 6) {
                    Text(item.sena)
                        .font(.system(size: 17, weight: .black))
                        .foregroundColor(.white)
                    Text("ABC")
                        .font(.system(size: 8, weight: .black))
                        .foregroundColor(Color("Naranja"))
                        .padding(.horizontal, 5).padding(.vertical, 2)
                        .background(Color("Naranja").opacity(0.13))
                        .clipShape(Capsule())
                    Spacer()
                    Text(item.timeString)
                        .font(.system(size: 10, design: .monospaced))
                        .foregroundColor(.gray)
                }
                if !item.significado.isEmpty {
                    Text(item.significado)
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                if !item.manos.isEmpty {
                    HStack(spacing: 4) {
                        Image(systemName: "hand.raised.fill")
                            .font(.system(size: 9)).foregroundColor(Color("Morado"))
                        Text(item.manos)
                            .font(.system(size: 11))
                            .foregroundColor(.gray.opacity(0.62))
                            .lineLimit(1)
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }

    // MARK: - Share
    private func shareItem(_ item: LSMResult) {
        let text = "🤟 Seña detectada: \(item.sena)\n📖 \(item.significado)\n⏰ \(item.timeString)\n\nDetectado con \(APP_NAME)"
        let av = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let root = scene.windows.first?.rootViewController {
            root.present(av, animated: true)
        }
    }
}