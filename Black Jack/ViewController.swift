//
//  ViewController.swift
//  Black Jack
//
//  Created by Kocka Dominik on 2017. 09. 08..
//  Copyright © 2017. Kocka Dominik. All rights reserved.
//

import UIKit

var Cards = [
"ace_of_clubs", "ace_of_diamonds", "ace_of_hearts", "ace_of_spades",
"2_of_clubs", "2_of_diamonds", "2_of_hearts", "2_of_spades",
"3_of_clubs", "3_of_diamonds", "3_of_hearts", "3_of_spades",
"4_of_clubs", "4_of_diamonds", "4_of_hearts", "4_of_spades",
"5_of_clubs", "5_of_diamonds", "5_of_hearts", "5_of_spades",
"6_of_clubs", "6_of_diamonds", "6_of_hearts", "6_of_spades",
"7_of_clubs", "7_of_diamonds", "7_of_hearts", "7_of_spades",
"8_of_clubs", "8_of_diamonds", "8_of_hearts", "8_of_spades",
"9_of_clubs", "9_of_diamonds", "9_of_hearts", "9_of_spades",
"10_of_clubs", "10_of_diamonds", "10_of_hearts", "10_of_spades",
"jack_of_clubs", "jack_of_diamonds", "jack_of_hearts", "jack_of_spades",
"queen_of_clubs", "queen_of_diamonds", "queen_of_hearts", "queen_of_spades",
"king_of_clubs", "king_of_diamonds", "king_of_hearts", "king_of_spades",]

var PublicRandom: Int?
var DealerScore = 0, PlayerScore = 0
var FirstHit = true
let alert = UIAlertView()

class ViewController: UIViewController {

    let GameOver = Over()
    //Button Outlets:
    @IBOutlet weak var HitButton: UIButton!
    @IBOutlet weak var StandButton: UIButton!
    @IBOutlet weak var DealButton: UIButton!
    //Dealer Card Outlets:
    @IBOutlet weak var DealerCard1: UIImageView!
    @IBOutlet weak var DealerCard2: UIImageView!
    //Player Card Outlets:
    @IBOutlet weak var PlayerCard1: UIImageView!
    @IBOutlet weak var PlayerCard2: UIImageView!
    @IBOutlet weak var PlayerCard3: UIImageView!
    @IBOutlet weak var PlayerCard4: UIImageView!
    //Score Label Outlets
    @IBOutlet weak var DealerScoreLabel: UILabel!
    @IBOutlet weak var PlayerScoreLabel: UILabel!
    
    
    
    /*
    //pop-up alert declaration
    
    let WinAlert = UIAlertController(title: "You Won!", message: "Congratulations, you are the winner. You had more score than the dealer.", preferredStyle: UIAlertControllerStyle.alert)
    let LoseAlert = UIAlertController(title: "You Lost!", message: "Sadly, you lost. You had less score than the dealer. Better luck next time!", preferredStyle: UIAlertControllerStyle.alert)
    let BlackJackAlert = UIAlertController(title: "Black Jack!", message: "Congratulations, you wont the round with exactly 21 points!", preferredStyle: UIAlertControllerStyle.alert)
    
    // add an action (button)
    //WinAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    
    // show the alert
    //self.present(alert, animated: true, completion: nil)
    */
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.HitButton.isHidden = true
        self.StandButton.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    @IBAction func HitButton(_ sender: UIButton) {
        
        if FirstHit == true{
            let playerCard3 = Card()
            PlayerCard3.image = UIImage(named: playerCard3.CardSelection())
            PlayerScore += playerCard3.CurrentScore()
            PlayerScoreLabel.text = String(PlayerScore)
            playerCard3.AllScore += playerCard3.CurrentScore()
            FirstHit = false
        }
        else{
            let playerCard4 = Card()
            PlayerCard4.image = UIImage(named: playerCard4.CardSelection())
            PlayerScore += playerCard4.CurrentScore()
            PlayerScoreLabel.text = String(PlayerScore)
            playerCard4.AllScore += playerCard4.CurrentScore()
        }
        if PlayerScore > 21{
            GameOver.LostByMore()
            self.HitButton.isHidden = true
            self.StandButton.isHidden = true
            self.DealButton.isHidden = false
        }
    }
    
    @IBAction func StandButton(_ sender: Any) {
        
        let dealerCard2 = Card()
        DealerCard2.image = UIImage(named: dealerCard2.CardSelection())
        DealerScore += dealerCard2.CurrentScore()
        DealerScoreLabel.text = String(DealerScore)
        dealerCard2.AllScore += dealerCard2.CurrentScore()
        
        if PlayerScore < 22 && PlayerScore > DealerScore{
            GameOver.Won()
            self.HitButton.isHidden = true
            self.StandButton.isHidden = true
            self.DealButton.isHidden = false
        }
        else if PlayerScore < 22 && PlayerScore < DealerScore{
            GameOver.LostByLess()
            self.HitButton.isHidden = true
            self.StandButton.isHidden = true
            self.DealButton.isHidden = false
        }
        else{
            GameOver.Equal()
            self.HitButton.isHidden = true
            self.StandButton.isHidden = true
            self.DealButton.isHidden = false
        }
        alert.addButton(withTitle: "OK")
        alert.show()
    }
    
    
    @IBAction func DealButton(_ sender: UIButton) {
        
        //Reset
        DealerScore = 0
        PlayerScore = 0
        DealerCard2.image = UIImage(named: "cardback")
        PlayerCard3.image = UIImage(named: "")
        PlayerCard4.image = UIImage(named: "")
        FirstHit = true
        
        //Object declaration:
        let dealerCard1 = Card()
        let playerCard1 = Card()
        let playerCard2 = Card()
        
        //Button change:
        self.HitButton.isHidden = false
        self.StandButton.isHidden = false
        self.DealButton.isHidden = true
        
        //Dealer First Card:
        DealerCard1.image = UIImage(named: dealerCard1.CardSelection())
        DealerScore += dealerCard1.CurrentScore()
        DealerScoreLabel.text = String(DealerScore)
        dealerCard1.AllScore += dealerCard1.CurrentScore()
        
        //Player First Card
        PlayerCard1.image = UIImage(named: playerCard1.CardSelection())
        PlayerScore += playerCard1.CurrentScore()
        playerCard1.AllScore += playerCard1.CurrentScore()
        
        //Player second card
        PlayerCard2.image = UIImage(named: playerCard2.CardSelection())
        PlayerScore += playerCard2.CurrentScore()
        PlayerScoreLabel.text = String(PlayerScore)
        playerCard2.AllScore += playerCard2.CurrentScore()
        if PlayerScore == 21{
            GameOver.BlackJack()
            self.HitButton.isHidden = true
            self.StandButton.isHidden = true
            self.DealButton.isHidden = false
        }
        else if PlayerScore > 21{
            GameOver.LostByMore()
            self.HitButton.isHidden = true
            self.StandButton.isHidden = true
            self.DealButton.isHidden = false
        }
        
    }
    
}
class Over{
    func Won(){
        alert.title = "You Won!"
        alert.message = "Congratulations, you are the winner. Your score was \(PlayerScore),which is more than the dealers \(DealerScore)."
        alert.addButton(withTitle: "OK")
        alert.show()
    }
    func LostByMore(){
        alert.title =  "You Lost!"
        alert.message = "Sadly, you lost. Your score was \(PlayerScore), which is more than 21. Better luck next time!"
        alert.addButton(withTitle: "OK")
        alert.show()
    }
    func LostByLess(){
        alert.title =  "You Lost!"
        alert.message = "Sadly, you lost. Your score was \(PlayerScore), which is less than the dealers \(DealerScore). Better luck next time!"
        alert.addButton(withTitle: "OK")
        alert.show()
    }
    func BlackJack(){
        alert.title = "Black Jack!"
        alert.message = "Congratulations, you won the round with exactly \(PlayerScore) points!"
        alert.addButton(withTitle: "OK")
        alert.show()
    }
    func Equal(){
        alert.title = "Draw!"
        alert.message = "Your's and the dealers score was equally \(PlayerScore)"
        alert.addButton(withTitle: "OK")
        alert.show()
    }
    
}
class Card{
    
    var AllScore = 0
    
    func CardSelection() -> String {
        var CurrentCard: String
        var PreviousCard: String?
        let random = Int(arc4random_uniform(UInt32(Cards.count)))
        PublicRandom = random
        CurrentCard = Cards[random]
        while CurrentCard == PreviousCard {
            CurrentCard = Cards[random]
        }
        PreviousCard = CurrentCard
        //Cards.remove(at: random)
        return CurrentCard
    }
    func CurrentScore() -> Int {
        var score = 0
        switch PublicRandom! {
        case 0, 1, 2, 3:
            //ace
            if AllScore + 11 > 21{
                score = 1
            }
            else{
                score = 11
            }
        case 4, 5, 6, 7:
            score = 2
        case 8, 9, 10, 11:
            score = 3
        case 12, 13, 14, 15:
            score = 4
        case 16, 17, 18, 19:
            score = 5
        case 20, 21, 22, 23:
            score = 6
        case 24, 25, 26, 27:
            score = 7
        case 28, 29, 30, 31:
            score = 8
        case 32, 33, 34, 35:
            score = 9
        default:
            score = 10
        }
        return score
    }
}

