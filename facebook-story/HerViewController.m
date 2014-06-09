//
//  HerViewController.m
//  facebook-story
//
//  Created by Lei Bao on 6/8/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "HerViewController.h"

@interface HerViewController ()
@property (weak, nonatomic) IBOutlet UIView *storyContainer;
@property (weak, nonatomic) IBOutlet UIImageView *imageContainer;
@property (weak, nonatomic) IBOutlet UIView *btnContainer;

@property (weak, nonatomic) IBOutlet UIImageView *tabBar;
@property (weak, nonatomic) IBOutlet UIView *commentTextfield;


- (IBAction)onTap:(id)sender;

- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;

@end

@implementation HerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Post";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
        
    }
    return self;
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
}

- (void)willShowKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.commentTextfield.frame = CGRectMake(0, self.view.frame.size.height - kbSize.height - self.commentTextfield.frame.size.height, self.commentTextfield.frame.size.width, self.commentTextfield.frame.size.height);
                     }
                     completion:nil];
}

- (void)willHideKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.commentTextfield.frame = CGRectMake(0, self.view.frame.size.height - self.commentTextfield.frame.size.height - self.tabBar.frame.size.height, self.commentTextfield.frame.size.width, self.commentTextfield.frame.size.height);
                     }
                     completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Setup story container apprearence (how to set RGB color??)
    self.storyContainer.layer.cornerRadius = 3;
    self.storyContainer.layer.shadowColor = [UIColor blackColor].CGColor;
    self.storyContainer.layer.shadowOffset = CGSizeMake(0,0);
    self.storyContainer.layer.shadowOpacity = 0.8;
    self.storyContainer.layer.shadowRadius = 1;

    
    
    // Setup image container appearence
    self.imageContainer.layer.shadowColor = [UIColor blackColor].CGColor;
    self.imageContainer.layer.shadowOffset = CGSizeMake(0,0);
    self.imageContainer.layer.shadowOpacity = 0.5;
    self.imageContainer.layer.shadowRadius = 1;
    
    // Configure the left button
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"left_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(onLeftButton:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    // Configure the right button
   UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"right_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(onRightButton:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    

    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
