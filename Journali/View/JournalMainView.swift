
import SwiftUI

struct JournalMainView: View {

    

    @State private var searchText = ""

   
    var body: some View {

        NavigationStack {

            ZStack {
                
                Color.backgroundPrimary
                    .ignoresSafeArea()

              
                EmptyStateView()
            }

            

            .navigationTitle("Journal")
            .navigationBarTitleDisplayMode(.large)

            
            .toolbar {

                ToolbarItemGroup(placement: .topBarTrailing) {

                    
                    Button {
                        
                        
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }

                 
                    Button {
                         
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }

            .toolbarBackground(.hidden, for: .navigationBar)

            

            .safeAreaInset(edge: .bottom) {

                HStack(spacing: 12) {

                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 24))
                        .foregroundStyle(.secondary)

                    TextField("Search", text: $searchText)
                        .disabled(true)

                    Spacer()

                    Button {
                        
                        
                    } label: {
                        Image(systemName: "mic")
                            .font(.system(size: 24))
                            .foregroundStyle(.secondary)
                    }
                    .disabled(true)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .glassEffect(.regular, in: Capsule())
                .padding(.horizontal, 24)
                .padding(.bottom, 12)
            }
        }
        .tint(.textPrimary)
        .preferredColorScheme(.dark)
    }
}



#Preview {
    JournalMainView()
}
