//
//  OnboardController2.swift
//  g-erms
//
//  Created by Tan Wei Liang on 11/10/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit
import Onboard

class OnboardController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateStandardOnboardingVC()
    }
    
    func onboardingCompletionHandler() {
        
        let authStoryboard = UIStoryboard(name: "Auth", bundle: nil)
        guard let targetVC = authStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        
        self.dismiss(animated: true, completion: nil)
        present(targetVC, animated: true)
    }
    
    func generateStandardOnboardingVC() {
        let firstPage = OnboardingContentViewController.content(
            withTitle: "For Gamers",
            body: "You don't have to be the best to get sponsored, sponsors are looking for all types of gamers, at all levels.",
            image: UIImage(named: "console"),
            buttonText: "", action: {() -> Void in
                
        })
        
        firstPage.movesToNextViewController = true
        
        let secondPage = OnboardingContentViewController.content(
            withTitle: "For Teams",
            body: "You don't have to be the best team to get sponsored, sponsors are looking for all types of teams, at all levels.",
            image: UIImage(named: "team"),
            buttonText: "", action: {() -> Void in
                
        })
        
        secondPage.movesToNextViewController = true
        
        let thirdPage = OnboardingContentViewController.content(
            withTitle: "For Tournaments",
            body: "Looking to grow your tournaments prize money and attract the best teams in the region to play in your tournament? Use attractive sponsors to contribute to your prize money.",
            image: UIImage(named: "tournament"),
            buttonText: "", action: {() -> Void in
                
        })
        
        let fourthPage = OnboardingContentViewController.content(
            withTitle: "For Sponsors",
            body: "Sponsorship of gaming influencers is one of the most effective means of brand building that you can participate in today.",
            image: UIImage(named: "sponsor"),
            buttonText: "Get Started", action: {() -> Void in
                self.onboardingCompletionHandler()
        })
        
        guard let onboardingVC = OnboardingViewController(backgroundImage: UIImage(named: "bg_1"), contents: [firstPage, secondPage, thirdPage, fourthPage]) else { return }
        
        onboardingVC.shouldFadeTransitions = true
        onboardingVC.fadePageControlOnLastPage = true
        onboardingVC.fadeSkipButtonOnLastPage = true
        
        // Customization
        onboardingVC.allowSkipping = true
        onboardingVC.skipHandler = {() -> Void in
            self.onboardingCompletionHandler()
        }
        
        present(onboardingVC, animated: true, completion: nil)
        
    }
    
}
