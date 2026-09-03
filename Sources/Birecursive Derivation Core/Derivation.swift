import Corecursive_Derivation_Core
import Recursive_Derivation_Core
public import SwiftSyntax

public enum Derivation {
    public static func expansion(of declaration: EnumDeclSyntax) -> [DeclSyntax] {
        Recursive_Derivation_Core.Derivation.expansion(of: declaration)
            + Corecursive_Derivation_Core.Derivation.operation(of: declaration)
    }
}
