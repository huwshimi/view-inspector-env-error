import SwiftUI
import CoreData

struct ContentView: View {
    @State private var showingCount = false
    internal var didAppear: ((Self) -> Void)?
    
    var body: some View {
        NavigationView {
            List { }
            Button("Show count") {
                showingCount = true
            }
            if showingCount {
                CountView()
            }
        }
        .onAppear { self.didAppear?(self) }
    }
}

struct CountView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        if let count = Item.count(context: viewContext) {
            Text("Count: \(count)")
        }
    }
}

extension Item {
    static func count(context: NSManagedObjectContext) -> Int? {
        do {
            return try context.count(for: self.fetchRequest())
        } catch {
            return nil
        }
    }
}

