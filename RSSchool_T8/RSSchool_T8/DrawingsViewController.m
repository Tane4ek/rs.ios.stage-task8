//
//  DrawingsViewController.m
//  RSSchool_T8
//
//  Created by Татьяна Лузанова on 17.07.2021.
//

#import "DrawingsViewController.h"

@interface DrawingsViewController ()

@property (weak, nonatomic) IBOutlet UIButton *planetButton;
@property (weak, nonatomic) IBOutlet UIButton *headButton;
@property (weak, nonatomic) IBOutlet UIButton *treeButton;
@property (weak, nonatomic) IBOutlet UIButton *landScapeButton;

@property UIColor *textBottomColor;


@end

@implementation DrawingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"FFFFF");
    
//    setupColors
    self.textBottomColor = [UIColor colorWithRed:33.0/255 green:176.0/255 blue:142.0/255 alpha:1];
    
//    setup buttons
    self.planetButton.layer.cornerRadius = 10;
    self.planetButton.layer.backgroundColor = UIColor.whiteColor.CGColor;
    self.planetButton.layer.shadowColor = UIColor.blackColor.CGColor;
    self.planetButton.layer.shadowRadius = 2;
    self.planetButton.layer.shadowOffset = CGSizeMake(0, 0);
    self.planetButton.layer.shadowOpacity = 0.25;

    self.headButton.layer.cornerRadius = 10;
    self.headButton.layer.backgroundColor = UIColor.whiteColor.CGColor;
    self.headButton.layer.shadowColor = UIColor.blackColor.CGColor;
    self.headButton.layer.shadowRadius = 2;
    self.headButton.layer.shadowOffset = CGSizeMake(0, 0);
    self.headButton.layer.shadowOpacity = 0.25;
    
    self.treeButton.layer.cornerRadius = 10;
    self.treeButton.layer.backgroundColor = UIColor.whiteColor.CGColor;
    self.treeButton.layer.shadowColor = UIColor.blackColor.CGColor;
    self.treeButton.layer.shadowRadius = 2;
    self.treeButton.layer.shadowOffset = CGSizeMake(0, 0);
    self.treeButton.layer.shadowOpacity = 0.25;
    
    self.landScapeButton.layer.cornerRadius = 10;
    self.landScapeButton.layer.backgroundColor = UIColor.whiteColor.CGColor;
    self.landScapeButton.layer.shadowColor = UIColor.blackColor.CGColor;
    self.landScapeButton.layer.shadowRadius = 2;
    self.landScapeButton.layer.shadowOffset = CGSizeMake(0, 0);
    self.landScapeButton.layer.shadowOpacity = 0.25;
    
}


- (IBAction)onPlanet:(id)sender {
    [NSUserDefaults.standardUserDefaults setInteger:1 forKey:@"Drawing"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)onHead:(id)sender {
    [NSUserDefaults.standardUserDefaults setInteger:2 forKey:@"Drawing"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)onTree:(id)sender {
    [NSUserDefaults.standardUserDefaults setInteger:3 forKey:@"Drawing"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)onLandscape:(id)sender {
    [NSUserDefaults.standardUserDefaults setInteger:4 forKey:@"Drawing"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
