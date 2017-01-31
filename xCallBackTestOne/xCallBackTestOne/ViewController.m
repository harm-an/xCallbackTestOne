//
//  ViewController.m
//  xCallBackTestOne
//
//  Created by Harman on 18/01/17.
//  Copyright © 2017 Harman. All rights reserved.
//

#import "ViewController.h"
#import "IACClient.h"
#import "UIView+Toast.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *potassium;
@property (weak, nonatomic) IBOutlet UITextField *sodium;


@end

UIGestureRecognizer *tapper;


@implementation ViewController

- (void)viewDidLoad {
    
    tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
    
    [super viewDidLoad];
    self.potassium.delegate = self;
    self.sodium.delegate = self;
    _potassium.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"potassium"];
    _sodium.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"sodium"];
    
    // Do any additional setup after loading the view, typically from a nib.
    // border radius
    [self.v.layer setCornerRadius:0.0f];
    [self.send.layer setCornerRadius:5.0f];
    [self.save.layer setCornerRadius:5.0f];
    
    
    // drop shadow
    [self.v.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.v.layer setShadowOpacity:0.8];
    [self.v.layer setShadowRadius:3.0];
    [self.v.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    [self.send.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.send.layer setShadowOpacity:0.8];
    [self.send.layer setShadowRadius:3.0];
    [self.send.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    
    [self.save.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.save.layer setShadowOpacity:0.8];
    [self.save.layer setShadowRadius:3.0];
    [self.save.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
}

- (IBAction)sendData:(UIButton *)sender {
    IACClient *client = [[IACClient alloc] initWithURLScheme:@"iamtestTwo"];
    [[NSUserDefaults standardUserDefaults] setValue:_potassium.text forKey:@"potassium"];
    [[NSUserDefaults standardUserDefaults] setValue:_sodium.text forKey:@"sodium"];
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    
    [self.v makeToast:@"Saved Successfully" duration:3.0 position:CSToastPositionBottom style:style];
    NSDictionary *values = @{@"potassium":self.potassium.text, @"sodium":self.sodium.text};
    [client performAction:@"add" parameters:values];
    NSLog(@"hello");
    
    
}


- (IBAction)saveData:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults] setValue:_potassium.text forKey:@"potassium"];
    [[NSUserDefaults standardUserDefaults] setValue:_sodium.text forKey:@"sodium"];
    
    [self resignFirstResponder];
    [self.v endEditing:YES];
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];

    [self.v makeToast:@"Saved Successfully" duration:3.0 position:CSToastPositionBottom style:style];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:(BOOL)animated];
    
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateViewNew) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    
    
}

-(void)updateViewNew{
    [self viewDidLoad];
}

- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.v endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
