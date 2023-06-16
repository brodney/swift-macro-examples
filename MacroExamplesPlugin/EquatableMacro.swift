import Foundation
import SwiftSyntax
import SwiftSyntaxMacros

public struct EquatableMacro {}

extension EquatableMacro: ConformanceMacro {
    public static func expansion<Declaration, Context>(
      of node: AttributeSyntax,
      providingConformancesOf declaration: Declaration,
      in context: Context
    ) throws -> [(TypeSyntax, GenericWhereClauseSyntax?)] where Declaration : DeclGroupSyntax, Context : MacroExpansionContext {
      return [ ("Equatable", nil) ]
    }
}

extension EquatableMacro: MemberMacro {
    public static func expansion(
      of node: AttributeSyntax,
      providingMembersOf declaration: some DeclGroupSyntax,
      in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let identified = declaration.asProtocol(IdentifiedDeclSyntax.self) else {
          return []
        }

        print("im here")
        let parentName = identified.identifier
        print(parentName)

        let equals: DeclSyntax =
        """
        public static func ==(lhss: \(parentName), rhs: \(parentName)) -> Bool {
            return true
        }
        """

        let another: DeclSyntax =
        """
        public func hello() -> String {
            return "world"
        }
        """
        return [equals]
    }

}
