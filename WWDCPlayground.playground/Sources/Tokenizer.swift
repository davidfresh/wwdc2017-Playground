import Foundation


public struct Tokenizer: Analyzer {
    let seed: Seed
    
    var scheme: String {
        return NSLinguisticTagSchemeNameTypeOrLexicalClass
    }
    
    public init(seed: Seed = Seed()) {
        self.seed = seed
    }
    
    public func tokenize(_ text: String, options: NSLinguisticTagger.Options? = nil) -> [String] {
        return analyze(self, text: text, options: options).map { (token, tag) in token }
    }
}
