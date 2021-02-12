//
//  ProjectDetailView.swift
//  Add Save Project
//
//  Created by Scott on 2/11/21.
//

import SwiftUI
import CoreData

struct ProjectDetailView: View {
    let project: Project
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    let presentDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .autoupdatingCurrent
        formatter.dateFormat = "MMM dd, h:m a"
        return formatter
    }()
    
    // MARK: - Main View
    
    var body: some View {
        
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        ZStack {
                            Color("back")
                                .frame(width: 25, height: 25)
                                .clipShape(Circle())
                            Image(systemName: "chevron.left")
                                .imageScale(.medium)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.leading, 10)
                    Spacer()
                    Text("Created Project")
                        .font(.poppins(size: 24))
                        .foregroundColor(.black)
                        .padding(.trailing, 10)
                    Spacer()
                }
                Spacer()
                ScrollView {
                    cardView
                    dateTimeView
                        .padding(.top, 20)
                    titleView
                        .padding(.top, 20)
                    descriptionView
                        .padding(.top, 20)
                }
                .padding(.top, 42)
            }
            .navigationBarHidden(true)
        }
    }
    
    // MARK: - Accessory Views
    
    var cardView: some View {
        ZStack {
            VStack {
                if project.color == "0" {
                    Image("\(project.image ?? "engineering")")
                        .resizable()
                } else {
                    Color("\(project.color ?? "")")
                        .frame(width: 343, height: 163)
                }
            }
            .frame(width: 343, height: 163)
            .overlay(
                Rectangle()
                    .stroke(Color("borderColor"), lineWidth: 1)
            )
            .background(Color.white)
            .cornerRadius(10)
        }
    }
    
    var dateTimeView: some View {
        ZStack {
            VStack {
                HStack {
                    Image(systemName: "calendar")
                        .imageScale(.small)
                    Text("\(project.date ?? Date(), formatter: presentDateFormat)")
                        .font(.custom("Avenir", size: 14))
                        .fontWeight(.heavy)
                }
                .padding(8)
                .datePickerStyle(CompactDatePickerStyle())
                .foregroundColor(Color("orangeColor"))
                .frame(width: 343, height: 43)
                .overlay(
                    Rectangle()
                        .stroke(Color("borderColor"), lineWidth: 1)
                )
                .background(Color.white)
                .cornerRadius(10)
            }
        }
    }
    
    var titleView: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Title")
                    .font(.custom("Avenir", size: 16))
                    .fontWeight(.heavy)
                Spacer()
            }
            .padding(.leading, 20)
            
            HStack {
                Text("\(project.title ?? "")")
                    .font(.custom("Avenir", size: 14))
                Spacer()
            }
            .padding(.leading, 20)
        }
    }
    
    var descriptionView: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Description")
                    .font(.custom("Avenir", size: 16))
                    .fontWeight(.heavy)
                Spacer()
            }
            .padding(.leading, 20)
            
            HStack {
                Text("\(project.detail ?? "")")
                    .font(.custom("Avenir", size: 14))
                Spacer()
            }
            .padding(.leading, 20)
        }
    }
}

struct ProjectDetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let project = Project(context: moc)
        project.title = "iOS Dev Challenge"
        project.date = Date()
        project.detail = "Fun fact about me inserted here"
        project.image = "engineering"
        project.color = "0"
        
        return ProjectDetailView(project: project)
    }
}
