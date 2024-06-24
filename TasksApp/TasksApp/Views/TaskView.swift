//
//  TaskView.swift
//  TasksApp
//
//  Created by AdminFS on 26/07/23.
//

import SwiftUI

struct TaskView: View {
    
    @State var isExpanded = false
    
    var title: String?
    var description: String?
    var date: String?
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            VStack(alignment: .leading, spacing: 5) {
                Text(title ?? "")
                    .font(.body)
                    .lineLimit(Int.max)
                
                Text(description ?? "")
                    .font(.footnote)
                    .lineLimit(isExpanded ? Int.max : 1)
            }
            
            Spacer()
            
            Text(date ?? "")
                .font(.body)
                .lineLimit(1)
            
        }
        .padding(.vertical, 5)
        .frame(maxWidth: .infinity, alignment: .leading)
        .transition(.move(edge: .bottom))
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(title: "Title", description: "Description", date: "Jul 28, 2023")
    }
}
