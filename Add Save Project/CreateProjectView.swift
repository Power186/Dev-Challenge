//
//  CreateProjectView.swift
//  Add Save Project
//
//  Created by Scott on 2/11/21.
//

import SwiftUI

struct CreateProjectView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    
    @State private var title = " "
    @State private var description = ""
    @State private var date = Date()
    @State private var color = "0"
    @State private var image = "engineering"
    
    @State private var headerImagePressed = false
    
    let colorColumns = [
        GridItem(.adaptive(minimum: 30), spacing: 20)
    ]
    
    // MARK: - Main View
    
    var body: some View {
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Create Project")
                    .font(.poppins(size: 24))
                    .foregroundColor(.black)
                    .padding(.top, 34)
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
                
                saveButton
                    .padding(.bottom, 10)
                    .shadow(radius: 6)
            }
        }
    }
    
    // MARK: - Accessory Views
    
    var backgroundToggle: some View {
        VStack {
            if headerImagePressed == false {
                Color(color)
            } else {
                Image("\(image)")
                    .resizable()
                    .onAppear(perform: {
                        color = "0"
                    })
            }
        }
    }
    
    var cardView: some View {
        ZStack {
            VStack {
                Button(action: {
                    headerImagePressed.toggle()
                }) {
                    Image("share")
                }
                .padding(.top, 35)
                
                Text("Upload header image or choose color")
                    .font(.custom("Avenir", size: 12))
                    .fontWeight(.medium)
                    .foregroundColor(Color("cardTextColor"))
                    .padding(.bottom, 10)
                
                colorSelectionView
                    .padding(.bottom, 10)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
            }
            .frame(width: 343, height: 163)
            .overlay(
                Rectangle()
                    .stroke(Color("borderColor"), lineWidth: 1)
            )
            .background(backgroundToggle)
            .cornerRadius(10)
        }
    }
    
    var colorSelectionView: some View {
        LazyVGrid(columns: colorColumns) {
            ForEach(Project.colors, id: \.self, content: colorButton)
        }
    }
    
    var dateTimeView: some View {
        ZStack {
            VStack {
                DatePicker(selection: $date, label: {
                    Image(systemName: "calendar")
                        .imageScale(.small)
                    Text("Date & time")
                        .font(.custom("Avenir", size: 14))
                        .fontWeight(.heavy)
                })
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
        VStack {
            HStack {
                Text("Title")
                    .font(.custom("Avenir", size: 16))
                    .fontWeight(.heavy)
                Spacer()
            }
            .padding(.leading, 20)
            TextField(" Type here", text: $title)
                .frame(width: 343, height: 38)
                .background(Color.white)
                .overlay(
                    Rectangle()
                        .stroke(Color("borderColor"), lineWidth: 1)
                )
                .background(Color.white)
                .cornerRadius(10)
        }
    }
    
    var descriptionView: some View {
        VStack {
            HStack {
                Text("Description")
                    .font(.custom("Avenir", size: 16))
                    .fontWeight(.heavy)
                Spacer()
            }
            .padding(.leading, 20)
            TextEditor(text: $description)
                .frame(width: 343, height: 57)
                .overlay(
                    Rectangle()
                        .stroke(Color("borderColor"), lineWidth: 1)
                )
                .background(Color.white)
                .cornerRadius(10)
        }
    }
    
    var saveButton: some View {
        Button(action: {
            let newProjet = Project(context: moc)
            newProjet.title = title
            newProjet.detail = description
            newProjet.color = color
            newProjet.image = image
            newProjet.date = date
            
            try? moc.save()
            presentationMode.wrappedValue.dismiss()
        }) {
            VStack {
                Text("Save")
                    .font(.poppins(size: 16))
                    .foregroundColor(.white)
                    .frame(width: 300, height: 43)
                    .overlay(
                        Rectangle()
                            .stroke(Color("borderColor"), lineWidth: 1)
                    )
                    .background(Color("blueColor"))
                    .cornerRadius(10)
            }
        }
    }
    
    // MARK: - Methods
    
    func colorButton(for item: String) -> some View {
        ZStack {
            Color(item)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(25)
            if item == color {
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .font(.headline)
                Image(systemName: "circle")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
            }
        }
        .onTapGesture {
            headerImagePressed = false
            color = item
        }
    }
}



struct CreateProjectView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProjectView()
    }
}
