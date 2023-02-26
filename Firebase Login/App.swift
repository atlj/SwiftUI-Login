import SwiftUI

@main
struct FirebaseLoginApp: App {
	@StateObject private var loginModel = LoginModel()

	var body: some Scene {
		WindowGroup {
			NavigationView {
				if !loginModel.isLoggedIn {
					RegisterView()
				} else {
					LoggedInView()
				}
			}.environmentObject(loginModel)
		}
	}
}
