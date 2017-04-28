import Foundation

private let smoothingParameter = 1.0

open class NaiveBayesClassifier {
    public typealias Word = String
    public typealias Category = String
    
    fileprivate let tokenizer: Tokenizer
    fileprivate let lemmatizer: Lemmatizer
    fileprivate let partofSpech: PartSpeach
    
    fileprivate var categoryOccurrences: [Category: Int] = [:]
    fileprivate var wordOccurrences: [Word: [Category: Int]] = [:]
    fileprivate var trainingCount = 0
    fileprivate var wordCount = 0
    
    public init() {
        self.tokenizer = Tokenizer()
        self.lemmatizer = Lemmatizer()
        self.partofSpech = PartSpeach()
    }
    
    public init(tokenizer: Tokenizer, lemmatizer: Lemmatizer, partSpeach: PartSpeach) {
        self.tokenizer = tokenizer
        self.lemmatizer = lemmatizer
        self.partofSpech = partSpeach
    }
    
    
    // MARK: - Training
    
    /**
     Trains the classifier with text and its category.
   
     */
    open func trainWithText(_ text: String, category: Category) {
        let tokens = lemmatizer.lemmatizeWordsInText(text)
       
        
        trainWithTokens(tokens, category: category)
      
        
    }
    
    
    
    /**
     Trains the classifier with tokenized text and its category.
     This is useful if you wish to use your own tokenization method.
     
   
     */
    open func trainWithTokens(_ tokens: [Word], category: Category) {
        let words = Set(tokens)
        for word in words {
            incrementWord(word, category: category)
        }
        incrementCategory(category)
        trainingCount += 1
    }
    
    // MARK: - Classifying
    
    /**
     Classifies the given text based on its training data.
     
     
     */
    open func classify(_ text: String) -> Category? {
        let tokens = tokenizer.tokenize(text)
        //print(tokens)
        
        return classifyTokens(tokens)
    }
    
    func argmax<T, U: Comparable>(_ elements: [(T, U)]) -> T? {
        if let start = elements.first {
           
            return elements.reduce(start) { $0.1 > $1.1 ? $0 : $1 }.0
            
        }
        return nil
    }
    
    
    /**
     Classifies the given tokenized text based on its training data.
     
     */
    open func classifyTokens(_ tokens: [Word]) -> Category? {
        // Compute argmax_cat [log(P(C=cat)) + sum_token(log(P(W=token|C=cat)))]
        return argmax(categoryOccurrences.map { (category, count) -> (Category, Double) in
            let pCategory = self.P(category)
            let score = tokens.reduce(log(pCategory)) { (total, token) in
                total + log((self.P(category, token) + smoothingParameter) / (pCategory + smoothingParameter + Double(self.wordCount)))
            }
            
            return (category, score)
            
        })
    }
    
    // MARK: - Probabilites
    
    fileprivate func P(_ category: Category, _ word: Word) -> Double {
        if let occurrences = wordOccurrences[word] {
            let count = occurrences[category] ?? 0
            return Double(count) / Double(trainingCount)
        }
        return 0.0
    }
    
    fileprivate func P(_ category: Category) -> Double {
        return Double(totalOccurrencesOfCategory(category)) / Double(trainingCount)
    }
    
    // MARK: - Counting
    
    fileprivate func incrementWord(_ word: Word, category: Category) {
        if wordOccurrences[word] == nil {
            wordCount += 1
            wordOccurrences[word] = [:]
        }
        
        let count = wordOccurrences[word]?[category] ?? 0
        wordOccurrences[word]?[category] = count + 1
    }
    
    fileprivate func incrementCategory(_ category: Category) {
        categoryOccurrences[category] = totalOccurrencesOfCategory(category) + 1
    }
    
    fileprivate func totalOccurrencesOfWord(_ word: Word) -> Int {
        if let occurrences = wordOccurrences[word] {
            return Array(occurrences.values).reduce(0, +)
        }
        return 0
    }
    
    fileprivate func totalOccurrencesOfCategory(_ category: Category) -> Int {
        return categoryOccurrences[category] ?? 0
    }
}

