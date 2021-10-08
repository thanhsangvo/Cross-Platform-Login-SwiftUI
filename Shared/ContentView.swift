//
//  ContentView.swift
//  Shared
//
//  Created by Vo Thanh Sang on 08/10/2021.
//

import SwiftUI

struct SignInView: View {
    
    @State private var email = ""
    @State private var pass = ""
    @State private var show = false
    
    
    var body: some View {
        
        HStack {
            
            VStack(spacing: 20) {
                
                #if os(iOS)
                VStack {
                    
                    Image("SignIn")
                        .resizable()
                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 230, alignment: .center)
                    Text("Notions")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading)
                }
                #endif
                
                TextField("Enter email", text: $email)
                    .padding(.horizontal)
                    .frame(width: isMacOS() ? getRect().width / 8 : getRect().width - 30, height: 44, alignment: .center)
                    .background(Color("Neutral3").opacity(0.2))
                    .cornerRadius(10)
                    .textFieldStyle(PlainTextFieldStyle())
                
                // pass
                ZStack(alignment: .trailing) {

                    if show {
                
                        SecureField("Enter password", text: $pass)
                            .frame(width: isMacOS() ? getRect().width / 9 : getRect().width - 56, height: 44, alignment: .center)
                            .padding(.horizontal)
                            .background(Color("Neutral3").opacity(0.2))
                            .cornerRadius(10)
                            .textFieldStyle(PlainTextFieldStyle())

                    } else {

                        TextField("Enter password", text: $pass)
                            .frame(width: isMacOS() ? getRect().width / 9 : getRect().width - 56, height: 44, alignment: .center)
                            .padding(.horizontal)
                            .background(Color("Neutral3").opacity(0.2))
                            .cornerRadius(10)
                            .textFieldStyle(PlainTextFieldStyle())

                    }

                    Button {
                        self.show.toggle()

                    } label: {
                        Image(systemName: self.show ? "eye.fill" : "eye.slash.fill")

                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.trailing, 20)

                }
                .frame(width: getRect().width - 56, height: 44, alignment: .center)

                //Fogot your password?
                Button {
                    
                } label: {
                    Text("Fogot your password?")
                        .font(.caption)
                        .foregroundColor(Color("Neutral3"))
                }
                .buttonStyle(PlainButtonStyle())

                // Sign Up
                Button {
                    
                } label: {
                    Text("Sign In")
                        .foregroundColor(Color("Neutral4"))

                }
                .buttonStyle(SignInButton(foreground: .black, background: Color("Primary")))
                .cornerRadius(10)
                
                #if os(iOS)
                    Spacer()
                #endif

                Text("----- Or -----")
                    .foregroundColor(Color("Neutral3"))
                
                // FB button
                HStack(spacing: 15) {

                    HStack {
                        Button {
                            
                        } label: {

                            Label("Facebook", image: "f")
                                .foregroundColor(Color.white)
                        }
                    }
                    .buttonStyle(FBButton())
                    .cornerRadius(10)

                    HStack {
                        Button {

                        } label: {
                            Label("Google", image: "google-plus")
                                .foregroundColor(Color.white)

                        }
                    }
                    .buttonStyle(GGButton())
                    .cornerRadius(10)
                }
                .frame(width: isMacOS() ? 245 : getRect().width - 56, height: 30, alignment: .center)

                HStack {
                    Button {

                    } label: {
                        Text("Don't have account?")
                            .font(.callout)
                            .foregroundColor(Color.gray)
                    }
                    .buttonStyle(PlainButtonStyle())

                    Button {

                    } label: {
                        Text("Sign Up")
                            .foregroundColor(Color("Primary"))
                            .fontWeight(.bold)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            
            #if os(iOS)
                Spacer()
            #endif
                
            }
            #if os(macOS)
            .frame(width: 320, alignment: .center)
            
            #endif
            
            
            #if os(macOS)
            ZStack {
                Image("SignIn")
                    .resizable()
//                    .frame(width: 250)
                VStack {
                    Text("Notions")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading)
                }
            }
            #endif

        }
        #if os(macOS)
        .frame(maxWidth: isMacOS() ? getRect().width / 1.7 : .infinity, maxHeight: isMacOS() ? getRect().height - 180 : .infinity, alignment: .leading)
        .ignoresSafeArea(.all, edges: .all)
        #else
        .ignoresSafeArea(.all, edges: .top)
        #endif
        .background(Color.white)
        .preferredColorScheme(.light)

    }
    
    @ViewBuilder
    func MainContent() -> some View {
        
        VStack {
            
        }
    }

}

#if os(macOS)
extension NSTextField {
    open override var focusRingType : NSFocusRingType {
        get{.none}
        set{}
    }
}
#endif

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

struct SignInButton: ButtonStyle {
    var foreground: Color
    var background: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 245, height: 44, alignment: .center)
        #if os(iOS)
            .frame(width: UIScreen.main.bounds.width - 56, height: 44)
        #endif
            .background(background)
            .foregroundColor(foreground)

    }
}

struct FBButton: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        #if os(iOS)
            .frame(width: UIScreen.main.bounds.width / 2.5, height: 44)
        #else
            .frame(width: 110, height: 30, alignment: .center)
        #endif
            .background(Color(red: 0.208, green: 0.35, blue: 0.619))
    }
}

struct GGButton: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 110, height: 30, alignment: .center)
        #if os(iOS)
            .frame(width: UIScreen.main.bounds.width / 2.5, height: 44)
        #else
            .frame(width: 110, height: 30, alignment: .center)
        #endif
            .background(Color("Red"))
    }
}


extension View {
    
    func getRect() -> CGRect {
        #if os(iOS)
        return UIScreen.main.bounds
        #else
        return NSScreen.main!.visibleFrame
        #endif
        
    }
    
    func isMacOS() -> Bool {
        #if os(iOS)
        return false
        #endif
        return true
    }
}
