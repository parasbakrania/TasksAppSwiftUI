//
//  AddTaskView.swift
//  TasksApp
//
//  Created by AdminFS on 27/07/23.
//

import SwiftUI

struct AddTaskView<T: CollectionProtocol>: View {
    
    @ObservedObject var observer: T
    @Binding var isPresented: Bool
    @Binding var newTaskAdded: Bool
    
    @State var currentDate: Date = Date()
    @State private var isShowingPicker = false
    @State private var offset: CGFloat = 550
    
    @State private var title: String = ""
    @State private var description: String = ""
    
    @State private var showAlert = false
    @State var alertMessage = ""
    
    @State private var isCompleted = false
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 30) {
                        
//                        CustomDatePicker(currentDate: $currentDate, isShowingPicker: $isShowingPicker)
                        
                        TextField(CommonString.title, text: $title)
                            .padding(.horizontal, 20)
                            .textFieldStyle(.roundedBorder)
                        
//                        TextField(CommonString.description, text: $description)
//                            .padding(.horizontal, 20)
//                            .textFieldStyle(.roundedBorder)
                        
                        Toggle("Completed", isOn: $isCompleted)
                            .padding(.horizontal, 20)
                        
                        Button {
                            addTask()
                        } label: {
                            Text(CommonString.save)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                                .font(.title.bold())
                                .foregroundColor(Color.white)
                                .background(RoundedRectangle(cornerRadius: 10).fill(.blue))
                        }
                    }
                    .padding(.vertical)
                }
                .disabled(isShowingPicker)
                
                MonthAndYearPicker(currentDate: $currentDate, isShowing: $isShowingPicker)
                    .frame(height: 250)
                    .offset(y: offset)
                    .animation(.linear, value: offset)
                
                if observer.state == .loading {
                    ProgressView()
                }
            }
            .navigationTitle(AddTaskVWString.addTask)
            .navigationBarTitleDisplayMode(.inline)
        }
        .alert(alertMessage, isPresented: $showAlert) {
            Button(CommonString.OK, role: .cancel) {
                if newTaskAdded {
                    isPresented = false
                }
            }
        }
        .onChange(of: isShowingPicker) { newValue in
            offset = self.isShowingPicker ? 250 : 550
        }
        .onChange(of: observer.state) { newValue in
            switch observer.state {
            case .added(let response):
                alertMessage = response as? String ?? ""
                newTaskAdded = true
                showAlert = true
                
            case .failed(let error):
                alertMessage = (error as? CommonError)?.reason ?? error.localizedDescription
                showAlert = true
                
            default:
                break
            }
        }
    }
    
    private func addTask() {
        if let task = Task(id: nil, todo: title, completed: isCompleted, userID: 5) as? T.Item {
            observer.add(item: task)
        }
    }
}

//struct AddTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTaskView(observer: <#_#>)
//    }
//}
