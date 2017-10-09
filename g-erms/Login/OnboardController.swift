//
//  OnboardController.swift
//  g-erms
//
//  Created by Tan Wei Liang on 07/10/2017.
//  Copyright © 2017 Audrey Lim. All rights reserved.
//

import UIKit
import Onboard

class OnboardController: UIViewController {
    
    var window: UIWindow?
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        generateStandardOnboardingVC()
    }
    
    func onboardingCompletionHandler() {
        
        let authStoryboard = UIStoryboard(name: "Auth", bundle: nil)
        guard let targetVC = authStoryboard.instantiateViewController(withIdentifier: "AuthNavigationController") as? UINavigationController else { return }
        
        self.dismiss(animated: true, completion: nil)
        present(targetVC, animated: true)
      
    }
    
    func generateStandardOnboardingVC() {


      
        let firstPage = OnboardingContentViewController.content(
            withTitle: "Welcome to the world of G-ERMS ",
            body: "G-ERMS is a platform where you can share and watch your mobile esports gameplay with the world, and get reward by doing it!",
            image: UIImage(named: ""),
            buttonText: "", action: {() -> Void in
                
        })
        
        
        firstPage.movesToNextViewController = true
       
        
        
        let secondPage = OnboardingContentViewController.content(
            withTitle: "The Ecosystem",
            body: """
 In the world of G-ERMS, you will be known as a Human.
 
 Your main tasks is to provide food for bacteria in order to let them survive.
 """,
            image: UIImage(named: ""),
            buttonText: "", action: {() -> Void in
                
        })
        
        secondPage.movesToNextViewController = true
       
        
        let thirdPage = OnboardingContentViewController.content(
            withTitle: "HELLO",
            body: """
 A collective amount of bacteria will provide you a certain amount of SWEETS!!!

 You can use the SWEETS to redeem anything in the world of G-ERMS

 e.g. Google Gift Cards, promotion and more...
 """,
            image: UIImage(named: ""),
            buttonText: "", action: {() -> Void in
                
        })
        
        
        
        let fourthPage = OnboardingContentViewController.content(
            withTitle: "",
            body: "Get started now , we welcome you to the world of G-ERMS",
            image: UIImage(named: ""),
            buttonText: "Get Started", action: {() -> Void in
                self.onboardingCompletionHandler()
               
        })
        
        
//        firstPage.titleLabel.textColor = UIColor.black
//        firstPage.bodyLabel.textColor = UIColor.black
//        secondPage.titleLabel.textColor = UIColor.black
//        secondPage.bodyLabel.textColor = UIColor.black
//        thirdPage.titleLabel.font = UIFont.boldSystemFont(ofSize: 100)
//        thirdPage.titleLabel.textColor = UIColor.black
//        thirdPage.bodyLabel.textColor = UIColor.black
//        fourthPage.titleLabel.textColor = UIColor.black
//        fourthPage.bodyLabel.textColor = UIColor.black
        
        
        
        
        guard let onboardingVC = OnboardingViewController(backgroundImage: UIImage(named: "White2"), contents: [firstPage, secondPage, thirdPage, fourthPage]) else { return }
        

        onboardingVC.shouldFadeTransitions = true
        onboardingVC.fadePageControlOnLastPage = true
        onboardingVC.fadeSkipButtonOnLastPage = true
        
       // onboardingVC.view.backgroundColor = UIColor.white
        //onboardingVC.shouldBlurBackground = true
        
        // Customization
        onboardingVC.allowSkipping = true
        onboardingVC.skipHandler = {() -> Void in
            self.onboardingCompletionHandler()
        }
        
        present(onboardingVC, animated: true, completion: nil)
        
    }
    
}
