//
//  MessageViewController.m
//  roomcast
//
//  Created by Tom Lodge on 07/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "MessageViewController.h"
#import "Conversation.h"
#import "Message.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

@synthesize conversations;
@synthesize managedObjectContext;
@synthesize selectedConversation;
@synthesize composing;
@synthesize messageView;
@synthesize scope;
@synthesize totals;

static NSArray* TYPES;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.development = [[DataManager sharedManager] development];
    TYPES = [NSArray arrayWithObjects:@"development", @"apartment", @"developments", @"region",  nil];
    
    self.composing = YES;
    
    self.scope =  [NSMutableDictionary dictionary];
    self.totals = [NSMutableDictionary dictionary];
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"MessageView"
                                                         owner:self
                                                       options:nil];
    messageView = [nibContents objectAtIndex:0];
    
    [messageView addTarget:self action:@selector(closeKeyboard:) forControlEvents:UIControlEventAllTouchEvents];
    
    [messageView.backButton addTarget:self action:@selector(toggleMessage:)
                     forControlEvents:UIControlEventTouchUpInside];
    
    [messageView.sendButton addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    
    [messageView.whotoButton addTarget:self action:@selector(pushDestination:) forControlEvents:UIControlEventTouchUpInside];

    
    for (NSString *type in TYPES){
        NSMutableDictionary *entities = [NSMutableDictionary dictionary];
        //set the default scope to whole development i.e. all blocks selected
        int total = 0;
        if ([type isEqualToString:@"development"]){
            for (Block* block in self.development.blocks){
                [entities setObject:block forKey:block.blockId];
                total += [block.residents intValue];
            }
            [self.totals setValue:[NSNumber numberWithInt:total] forKey:@"development"];
            [self.messageView.numberButton setTitle:[NSString stringWithFormat:@"%d", total] forState:UIControlStateNormal];
        }
        [self.scope setObject:entities forKey:type];
    }
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"conversationUpdate" object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.conversations = [[DataManager sharedManager] conversationsForUser];
        [self.tableView reloadData];
        
    }];    
 
    [[NSNotificationCenter defaultCenter] addObserverForName:@"conversationsUpdate" object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.conversations = [[DataManager sharedManager] conversationsForUser];
        [self.tableView reloadData];
        
    }];

    
    
    
    id maindelegate = [[UIApplication sharedApplication] delegate];
    
    self.managedObjectContext = [maindelegate managedObjectContext];
    
    self.conversations = [[DataManager sharedManager] conversationsForUser];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [conversations count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"LightGreenMessageCell";
    if (indexPath.row % 2 == 0)
        CellIdentifier = @"DarkGreenMessageCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
   Conversation *conversation = [self.conversations objectAtIndex:[conversations count] - indexPath.row - 1];
    
    UILabel *fromLabel  = (UILabel*)[cell viewWithTag:1];
    UILabel *bodyLabel  = (UILabel*)[cell viewWithTag:2];
    UILabel *repliesLabel = (UILabel*)[cell viewWithTag:3];

    fromLabel.text = conversation.initiator;
    bodyLabel.text = conversation.teaser;
    repliesLabel.text = [NSString stringWithFormat:@"%@", conversation.responses];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *ip = [self.tableView indexPathForCell: (UITableViewCell *) sender];
    self.selectedConversation = [conversations objectAtIndex: [conversations count] - ip.row - 1];
    
    ChatViewController* cvc = (ChatViewController *) [segue destinationViewController];
    cvc.delegate = self;
    cvc.conversationId = self.selectedConversation.conversationId;
}

 
- (IBAction)toggleMessage:(id)sender {
    [self toggleComposer];
}

-(void) closeKeyboard:(UIControl *) sender{
    [sender endEditing:YES];
}

-(void) pushDestination:(UIButton *) sender{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    DestinationViewController *destination = (DestinationViewController*)[storyboard instantiateViewControllerWithIdentifier:@"sendto"];
    
    destination.scopedelegate = self;
    destination.scope  = self.scope;
    destination.totals = self.totals;
    destination.scopeTypes = TYPES;
    destination.developmentName = self.development.name;
  
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    NSArray* sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    destination.blocks = [[[self.development blocks] allObjects] sortedArrayUsingDescriptors:sortDescriptors];
   
    [self.navigationController pushViewController:destination animated:YES];
}

-(void) sendMessage:(UIButton *)sender{    
    if ([messageView.messageView.text length] == 0)
        return;

    [[DataManager sharedManager ]createConversationWithMessage:messageView.messageView.text parameters:nil];
    [self toggleComposer];
}


-(void) toggleComposer{
    if (self.composing){
        CGRect mainframe = [[UIScreen mainScreen] bounds];
        float width = mainframe.size.width;
        
        messageView.frame = CGRectMake(0,-313+self.tableView.contentOffset.y,width,313); //or whatever coordinates you need
        
        [self.tableView addSubview:messageView];
       
        [UIView animateWithDuration:0.5f
                              delay:0.0f
                            options:UIViewAnimationCurveEaseInOut
                         animations:^{
                             messageView.frame = CGRectMake(0,self.tableView.contentOffset.y,width,313);
                             
                         }
                         completion:^(BOOL finished) {
                         }];
        [self.composeButton setEnabled:NO];
    }else{
        CGRect mainframe = [[UIScreen mainScreen] bounds];
        float width = mainframe.size.width;
      
        [UIView animateWithDuration:0.5f
                              delay:0.0f
                            options:UIViewAnimationCurveEaseInOut
                         animations:^{
                             messageView.frame = CGRectMake(0,-313,width,313);
                             
                         }
                         completion:^(BOOL finished) {
                             [messageView removeFromSuperview];
                         }];
        [self.composeButton setEnabled:YES];
        
    }
    self.composing = !self.composing;
}

#pragma delegate methods

-(void) didRespondToConversation:(NSString*) conversationId withMessage:(NSString*) message{
    
}

-(void) didSelectScope:(NSString*) scopeName withValues:(NSDictionary*) scopeValues{
    
    [self.scope setObject:scopeValues forKey: scopeName];
    
    if ([scopeName isEqualToString:@"apartment"]){
        [self.messageView.whotoButton setTitle:[NSString stringWithFormat:@"%d apartments", [[self.totals objectForKey:@"apartment"] intValue]] forState:UIControlStateNormal];
        
        [self.messageView.numberButton setTitle:[NSString stringWithFormat:@"%d", [[self.totals objectForKey:@"apartment"] intValue]] forState:UIControlStateNormal];
    }else if([scopeName isEqualToString:@"development"]){
      
        NSString* whoto;
        if ([scopeValues count] == [self.development.blocks count]){
            whoto = [NSString stringWithFormat:@"all of %@", self.development.name];
        }else{
            NSArray *entities = [scopeValues allValues];
            whoto = [[entities valueForKey:@"name"]componentsJoinedByString:@","];
        }
       
        [self.messageView.whotoButton setTitle:whoto forState:UIControlStateNormal];
        
        [self.messageView.numberButton setTitle:[NSString stringWithFormat:@"%d", [[self.totals objectForKey:@"development"] intValue]] forState:UIControlStateNormal];
    }
}


@end
