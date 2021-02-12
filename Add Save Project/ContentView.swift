//
//  ContentView.swift
//  Add Save Project
//
//  Created by Scott on 2/11/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Project.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Project.date, ascending: true)])
    var projects: FetchedResults<Project>
    
    @State private var addProjectShowing = false
    
    let presentDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .autoupdatingCurrent
        formatter.dateFormat = "MMM dd, h:m a"
        return formatter
    }()
    
    // MARK: - Main View
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("background")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Projects")
                        .font(.poppins(size: 24))
                        .foregroundColor(.black)
                    Spacer()
                    ScrollView {
                        ForEach(projects, id: \.self) { project in
                            NavigationLink(
                                destination: ProjectDetailView(project: project),
                                label: {
                                    ZStack {
                                        VStack {
                                            if project.color == "0" {
                                                Image("\(project.image ?? "engineering")")
                                                    .resizable()
                                                    .frame(width: 343, height: 117)
                                                    .cornerRadius(10)
                                                    .aspectRatio(contentMode: .fit)
                                            } else {
                                                Color("\(project.color ?? "")")
                                                    .frame(width: 343, height: 117)
                                                    .cornerRadius(10)
                                            }
                                            Spacer()
                                            HStack {
                                                Text("\(project.title ?? "")")
                                                    .font(.custom("Avenir", size: 14))
                                                    .fontWeight(.medium)
                                                    .foregroundColor(.black)
                                                    .padding(.leading, 8)
                                                Spacer()
                                                Text("\(project.date ?? Date(), formatter: presentDateFormat)")
                                                    .font(.poppins(size: 14))
                                                    .foregroundColor(Color("orangeColor"))
                                                    .padding(.trailing, 8)
                                            }
                                            .padding(.bottom, 10)
                                        }
                                        .frame(width: 343, height: 163)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color("borderColor"), lineWidth: 1)
                                        )
                                        .background(Color.white)
                                        .cornerRadius(10)
                                    }
                                }) // label
                        }
                        cardView
                    }
                    .padding(.top, 42)
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    // MARK: - Accessory View
    
    var cardView: some View {
        ZStack {
            Button(action: {
                addProjectShowing.toggle()
            }) {
                Image("PlusCircle")
            }
            .frame(width: 343, height: 163)
            .overlay(
                Rectangle()
                    .stroke(Color("borderColor"), lineWidth: 1)
            )
            .background(Color.white)
            .cornerRadius(10)
        }
        .sheet(isPresented: $addProjectShowing, content: {
            CreateProjectView()
        })
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
