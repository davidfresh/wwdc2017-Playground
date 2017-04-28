import Foundation

public struct Lemmatizer: Analyzer {
    let seed: Seed
    
    var scheme: String {
        return NSLinguisticTagSchemeLemma
    }
    
    public init(seed: Seed = Seed()) {
        self.seed = seed
    }
    
    /**
     Returns the lemmatized tokens for the input text using the specified linguistic tagger options.
     */
    public func lemmatizeWordsInText(_ text: String, options: NSLinguisticTagger.Options? = nil) -> [String] {
        return analyze(self, text: text, options: options).map { (token, lemma) in lemma.lowercased() }.filter {
            !$0.isEmpty
        }
    }
    
//    public func partOfSpeech(_ text: String, options: NSLinguisticTagger.Options? = nil) -> [String]{
//        return analyze(self, text: text, options: NSLinguis)
//    }
    
    
    
    
}


public struct PartSpeach: Analyzer {
    let seed: Seed
    
    var scheme: String {
        return NSLinguisticTagSchemeLexicalClass
    }
    
    public init(seed: Seed = Seed()) {
        self.seed = seed
    }
    
    /**
     Returns the lemmatized tokens for the input text using the specified linguistic tagger options.
     
   
     */
    public func partOfWordsInText(_ text:String, options: NSLinguisticTagger.Options? = nil) -> [String] {
        return analyze(self, text: text, options: options).map { (token, part) in part.lowercased() }.filter {
            !$0.isEmpty
        }
    }
    
    //    public func partOfSpeech(_ text: String, options: NSLinguisticTagger.Options? = nil) -> [String]{
    //        return analyze(self, text: text, options: NSLinguis)
    //    }
    
    
    
    
}
