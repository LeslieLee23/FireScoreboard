//
//  TaskListView.swift
//  Score1031
//
//  Created by Danting Li on 4/21/20.
//  Copyright © 2020 HULUCave. All rights reserved.
//

import SwiftUI

struct TaskListView: View {
  var tasks: [Task] = testDataTasks // (1)

  
  var body: some View {
    NavigationView { // (2)
      VStack(alignment: .leading) {
        List {
          ForEach (self.tasks) { task in // (3)
            TaskCell(task: task) // (6)
          }
          .onDelete { indexSet in // (4)
             // The rest of this function will be added later
          }
        }
        Button(action: {}) { // (7)
          HStack {
            Image(systemName: "plus.circle.fill") //(8)
              .resizable()
              .frame(width: 20, height: 20) // (11)
            Text("New Task") // (9)
          }
        }
        .padding()
        .accentColor(Color(UIColor.systemRed)) // (13)
      }
      .navigationBarTitle("Tasks")
    }
  }
}

struct TaskListView_Previews: PreviewProvider {
  static var previews: some View {
    TaskListView()
  }
}

struct TaskCell: View { // (5)
  var task: Task
  
  var body: some View {
    HStack {
      Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
        .resizable()
        .frame(width: 20, height: 20) // (12)
      Text(task.title)
    }
  }
}
