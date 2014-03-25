//
//  SendRootViewController.m
//  roomcast
//
//  Created by Tom Lodge on 21/02/2014.
//  Copyright (c) 2014 Tom Lodge. All rights reserved.
//

#import "SendRootViewController.h"

//THINK THIS CAN BE DELETED!

@interface SendRootViewController ()
-(void) setText;
@end

@implementation SendRootViewController

@synthesize development;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"send a message";
    [self.sendText setDelegate:self];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendAnonPressed:(id)sender {
}

- (IBAction)sendPressed:(id)sender {
}

/*
 *Note that for embedded seques, this is called before the parent (i.e this view controller's viewDidLoad method.  So any setup has to be done in the
    prepareForSegue of the calling controller..
 */

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    self.development  = [[DataManager sharedManager] development];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"developmentsUpdate" object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.developments = [[DataManager sharedManager] neighboursForDevelopment:self.development.objectId];
        NSLog(@"SEEN THE DEVELOPMENTS UPDATE!! %@", self.development.objectId);
        NSLog(@"the developments are %@", self.developments);
       
    }];

    self.filters    = @[@"resident owners", @"landlords", @"tenants"];
    self.filterDescriptions = @[@"owners living in development", @"owners living elsewhere", @"non-owners living in development"];
    
    self.selectedFilters = [NSMutableArray array];
    
    self.scopeTypes = @[@"development", @"apartment", @"developments", @"region"];
    self.scope =  [NSMutableDictionary dictionary];
    self.totals = [NSMutableDictionary dictionary];
    
    for (NSString *type in self.scopeTypes ){
        NSMutableArray *entities = [NSMutableArray array];
        //set the default scope to whole development i.e. all blocks selected
        int total = 0;
        if ([type isEqualToString:@"development"]){
            for (Block* block in development.blocks){
                [entities addObject:block];
                total += [block.residents intValue];
            }
            [self.totals setValue:[NSNumber numberWithInt:total] forKey:@"development"];
            
        }
        [self.scope setObject:entities forKey:type];
    }

    self.developments = [[DataManager sharedManager] neighboursForDevelopment:self.development.objectId];
    
    RootAudienceViewController *ravc = (RootAudienceViewController*) [segue destinationViewController];
    
    ravc.scopedelegate      = self;
    ravc.filterdelegate     = self;
    
    ravc.development        = self.development;
    ravc.developments       = self.developments;
    
    ravc.selectedFilters    = self.selectedFilters;
    ravc.filters            = self.filters;
    ravc.filterDescriptions = self.filterDescriptions;

    ravc.scope              = self.scope;
    ravc.scopeTypes         = self.scopeTypes;
    ravc.currentScope       = self.currentScope;
    ravc.totals             = self.totals;
    
}

#pragma -- delegate methods

-(void) didSelectScope:(NSString*) scopeName withValues:(NSDictionary*) scopeValues withSummary:(NSString*) summary{

    self.currentScope = scopeName;
    [self.scope setObject:scopeValues forKey: scopeName];
    [self setText];
}

-(void) didSelectFilter:(NSString*) filterName{
    NSLog(@"very nice - got to did select filter!!");
    if ([self.selectedFilters containsObject:filterName]){
        [self.selectedFilters removeObject:filterName];
    }else{
        [self.selectedFilters addObject:filterName];
    }
    [self setText];
}

-(void) setText{
    NSMutableArray* scopeValues = [self.scope objectForKey:self.currentScope];
    NSString* filterText = @"everyone";
    
    if ([self.selectedFilters count] > 0){
        filterText = [self.selectedFilters componentsJoinedByString:@" and "];
    }
    self.whoToLabel.text = [NSString stringWithFormat:@"%@ in %@", filterText,  [[scopeValues valueForKeyPath:@"name"] componentsJoinedByString:@","]];
    
    self.audienceCount.text = [NSString stringWithFormat:@"%d", [[self.totals objectForKey:self.currentScope] intValue]];
}

#pragma -- delegate methods


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textView resignFirstResponder];
        
        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
}


@end
