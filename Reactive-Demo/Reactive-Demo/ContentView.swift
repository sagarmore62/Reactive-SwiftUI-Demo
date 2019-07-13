//
//  ContentView.swift
//  Reactive-Demo
//
//  Created by Sagar More on 13/07/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import SwiftUI

//SwiftUI Reactive Demo : State Management and Bindings
struct ContentView : View {
    /* SwiftUI automatically watch for changes of variable type @State
      and update any parts of our views that use that state. */
    @State private var name = ""
    @State private var phone = ""
    @State private var users = [String]()
    @State private var isNameError = false
    @State private var isPhoneError = false
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                VStack {
                    VStack(alignment : .leading) {
                        Group {
                            //created TextField inside group, so that we can give extra padding to textfield and color to entire group.
                            //$name binds textfield text to name variable, whenever user enter text in textfield, name variable will be updated simultaneously.
                            TextField($name, placeholder: Text("Enter your name")).padding(10)
                                .tapAction {
                                    self.isNameError = false
                            }
                        }
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        //Name error text
                        Text(isNameError ? "Please enter name" : "").color(Color.red).padding(.bottom)

                        Group {
                            //$phone binds textfield text to phone variable, whenever user enter text in textfield, phone variable will be updated simultaneously.
                            TextField($phone, placeholder: Text("Enter your mobile")).padding(10)
                                .tapAction {
                                    self.isPhoneError = false
                            }
                        }
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        //Phone error text
                        Text(isPhoneError ? "Please enter mobile" : "").color(Color.red)

                        HStack { // Create user & Delete All user button Container
                            Button(action: {
                                self.isNameError = false
                                self.isPhoneError = false
                                if !self.name.isEmpty, !self.phone.isEmpty {
                                    self.users.append(self.name + ", " + self.phone)
                                    self.name = ""
                                    self.phone = ""
                                } else {
                                    if self.name.isEmpty {
                                        self.isNameError = true
                                    }
                                    if self.phone.isEmpty {
                                        self.isPhoneError = true
                                    }
                                }
                            }) {
                                //created button label
                                Group {
                                    Text("Create User")
                                    .bold()
                                    .padding(10)
                                }
                                .background(Color.orange)
                                .foregroundColor(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 5))

                            }
                            Button(action: {
                                self.users.removeAll()
                            }) {
                                Group {
                                    Text("Delete All User")
                                        .bold()
                                        .padding(10)
                                    }
                                    .background(Color.red)
                                    .foregroundColor(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))

                            }
                        }.padding()
                    }
                   
                }.padding(12)
                .background(Color.secondary)
                
                Text("User Details").bold().padding(.leading)
                //Binding of user list to List.
                //On users array update, List will update automatically
                List(users.identified(by: \.self)) { user in
                    Text(user)
                }
                
            }
            .navigationBarTitle(Text("User Details Form").color(Color.black))
                .navigationBarItems(leading : HStack {
                    //Navigation item, for real time textfield changes.
                    Text("Name:")
                    Text(name).color(.red)
                    Text(" Phone:")
                    Text(phone).color(.red)
                })
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif


