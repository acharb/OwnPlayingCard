
import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeckModel()
    
    
    @IBOutlet weak var playingCardView: PlayingCardView! {
        didSet{
            //swipe gesture
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
            swipe.direction = [.left,.right]
            playingCardView.addGestureRecognizer(swipe)
            
            let tap = UISwipeGestureRecognizer(target: self, action: #selector(flipCard))
            
        }
    }
    
    @objc func flipCard() {
        
    }
    
    @objc func nextCard()  {
        if let next = deck.draw() {
            playingCardView.suit = next.suit.rawValue
            playingCardView.rank = next.rank.order
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
}

