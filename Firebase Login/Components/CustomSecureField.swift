//
//  CustomTextField.swift
//  Firebase Login
//
//  Created by Burak Güner on 26.02.2023.
//

import SwiftUI

struct CustomSecureField: View {
	var title: String
	@Binding var text: String

	var body: some View {
		SecureField(title, text: $text)
			.padding(.all)
			.overlay(
				RoundedRectangle(cornerRadius: 5.0).stroke(
					Color.primary.opacity(0.5), lineWidth: 0.6))
	}
}

struct CustomSecureField_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			EmptyTest()
			FullTest()
		}
	}
}

struct CustomSecureField_EmptyTest: View {
	@State private var text = ""
	var body: some View {
		CustomTextField(title: "Test", text: $text)
	}
}

struct CustomSecureField_FullTest: View {
	@State private var text = "Look it's filled now"
	var body: some View {
		CustomTextField(title: "Test", text: $text)
	}
}
