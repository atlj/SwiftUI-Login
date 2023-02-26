import Foundation

struct Login: Codable {
	let kind, localId, email, displayName, idToken: String
	let registered: Bool
}
