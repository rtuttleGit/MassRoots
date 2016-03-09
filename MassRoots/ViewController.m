//
//  ViewController.m
//  MassRoots
//
//  Created by Ryan on 3/8/16.
//  Copyright © 2016 Code With Ryan. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;
    
    UIImageView *backgroundImg = [[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImg.image = [UIImage imageNamed:@"massroots.png"];
    [self.view addSubview:backgroundImg];
    
    
    UIButton *authenticateBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    authenticateBtn.frame = CGRectMake(40, screenHeight - 170, screenWidth - 80, 40);
    [authenticateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [authenticateBtn setTitle:NSLocalizedString(@"Continue with Github",nil) forState:UIControlStateNormal];
    authenticateBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    authenticateBtn.backgroundColor = [UIColor grayColor];
    authenticateBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [authenticateBtn addTarget:self action:@selector(githubAuthenticationAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:authenticateBtn];

    
   }

- (void)githubAuthenticationAction:(UIButton*)button{
    NSString *link = @"https://github.com/login/oauth/authorize?client_id=35f39c6844e4da2ff999";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
