//
//  ContentView.swift
//  TasksApp
//
//  Created by AdminFS on 26/07/23.
//

import SwiftUI

struct ContentView<T: CollectionProtocol>: View {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject var observer: T
    
    @State var showSheetView = false
    @State var newTaskAdded = false
    
    @State private var showAlert = false
    @State var errorMessage = ""
    
    var body: some View {
        NavigationView {
            VStack {
                switch observer.state {
                case .loaded(let items):
                    let tasks = items as? [Task] ?? []
                    if tasks.isEmpty {
                        Text(TasksVWString.noTaskFound)
                    } else {
                        List(0..<tasks.count, id: \.self) { row in
                            let taskDetail = tasks[row]
                            TaskView(title: taskDetail.todo, description: "\(taskDetail.completed ?? false)")
                        }
                        .padding(.top, -20)
                    }
                    
                case .loading:
                    ProgressView()
                    
                default:
                    EmptyView()
                }
            }
            .navigationTitle(TasksVWString.tasks)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing:
                    Button(action: {
                        self.showSheetView.toggle()
                    }, label: {
                        Image(systemName: ImageName.plus)
                    })
            )
        }
        .alert(errorMessage, isPresented: $showAlert) {
            Button(CommonString.OK, role: .cancel) { }
        }
        .sheet(isPresented: $showSheetView) {
            if let viewModel = appDelegate.container.resolve(type: (any CollectionProtocol).self) as? TasksViewModel {
                AddTaskView(observer: viewModel, isPresented: $showSheetView, newTaskAdded: $newTaskAdded)
            }
        }
        .onAppear {
            observer.getItems()
        }
        .onChange(of: observer.state) { newValue in
            switch observer.state {
            case .failed(let error):
                errorMessage = (error as? CommonError)?.reason ?? error.localizedDescription
                showAlert = true
                
            default:
                break
            }
        }
        .onChange(of: newTaskAdded) { newValue in
            if newValue {
                observer.getItems()
                newTaskAdded = false
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
