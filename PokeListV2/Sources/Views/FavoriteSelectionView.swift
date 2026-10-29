import SwiftUI

struct FavoriteSelectionView: View {
    let abilities: [String]
    let moves: [String]
    @Binding var selectedAbility: String?
    @Binding var selectedMoves: Set<String>
    @Environment(\ .dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Habilidade")) {
                    Picker("Selecione", selection: Binding(
                        get: { selectedAbility ?? abilities.first ?? "" },
                        set: { selectedAbility = $0 }
                    )) {
                        ForEach(abilities, id: \ .self) { ability in
                            Text(ability.capitalized).tag(ability)
                        }
                    }
                }
                Section(header: Text("Ataques (máx 4)")) {
                    List {
                        ForEach(moves, id: \ .self) { move in
                            MultipleSelectionRow(title: move.capitalized, isSelected: selectedMoves.contains(move)) {
                                if selectedMoves.contains(move) {
                                    selectedMoves.remove(move)
                                } else if selectedMoves.count < 4 {
                                    selectedMoves.insert(move)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Favoritar")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        dismiss()
                    }
                    .disabled(selectedAbility == nil || selectedMoves.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
            }
        }
    }
}

struct MultipleSelectionRow: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                Spacer()
                if isSelected { Image(systemName: "checkmark") }
            }
        }
    }
}
