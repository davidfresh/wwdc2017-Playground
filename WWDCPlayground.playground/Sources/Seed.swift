import Foundation

public struct Seed {
    
    typealias Language = String
    
    fileprivate let language: Language = "en"
    let linguisticTaggerOptions: NSLinguisticTagger.Options = [.omitWhitespace, .omitPunctuation, .omitOther, .joinNames]
    let orthography = NSOrthography(dominantScript: "Latn", languageMap: ["Latn" : ["en"]])
    
    func linguisticTaggerWithOptions(_ options: NSLinguisticTagger.Options) -> NSLinguisticTagger {
        let tagSchemes = NSLinguisticTagger.availableTagSchemes(forLanguage: self.language)
        
        return NSLinguisticTagger(tagSchemes: tagSchemes, options: Int(options.rawValue))
    }
    
}
