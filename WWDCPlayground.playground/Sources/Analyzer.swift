import Foundation


typealias Pair = (String, String)

protocol Analyzer {
    var seed: Seed { get }
    var scheme: String { get }
}

internal func analyze(_ analyzer: Analyzer, text: String, options: NSLinguisticTagger.Options?) -> [Pair] {
    var pairs: [Pair] = []
    
    let range = NSRange(location: 0, length: text.characters.count)
    let options = options ?? analyzer.seed.linguisticTaggerOptions
    let tagger = analyzer.seed.linguisticTaggerWithOptions(options)
    
    tagger.string = text
    tagger.setOrthography(analyzer.seed.orthography, range: range)
    tagger.enumerateTags(in: range, scheme: analyzer.scheme, options: options) { (tag: String?, tokenRange, range, stop) in
        if let tag = tag {
            let token = (text as NSString).substring(with: tokenRange)
            let pair = (token, tag)
            pairs.append(pair)
        }
    }
    return pairs
}
