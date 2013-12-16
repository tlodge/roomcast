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



- (id)initWithStyle:(UITableViewStyle)style
{
   

    self = [super initWithStyle:style];
    if (self) {
        NSLog(@"custom init!");
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.composing = YES;
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"conversationUpdate" object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.conversations = [[DataManager sharedManager] conversationsForUser];
        [self.tableView reloadData];
        
    }];    
 
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"MessageView"
                                                         owner:self
                                                       options:nil];
    messageView = [nibContents objectAtIndex:0];
    
    [messageView addTarget:self action:@selector(closeKeyboard:) forControlEvents:UIControlEventAllTouchEvents];
    
    [messageView.backButton addTarget:self action:@selector(toggleMessage:)
               forControlEvents:UIControlEventTouchUpInside];
    
    [messageView.sendButton addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    
    [messageView.whotoButton addTarget:self action:@selector(pushDestination:) forControlEvents:UIControlEventTouchUpInside];
    
    
    id maindelegate = [[UIApplication sharedApplication] delegate];
    
    self.managedObjectContext = [maindelegate managedObjectContext];
    
    //[self getAllConversations];
    
    self.conversations = [[DataManager sharedManager] conversationsForUser];
    [self.tableView reloadData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}




//- (void)didReceiveSyncDidFinishNotification:(NSNotification *)notification
//{
//    [self getAllConversations];
//}

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
    
    
    //Message *message = [self.messages objectAtIndex:indexPath.row];
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
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    ChatViewController* cvc = (ChatViewController *) [segue destinationViewController];
    cvc.delegate = self;
    cvc.conversationId = self.selectedConversation.conversationId;
    //[self.selectedConversation addObserver:cvc forKeyPath:@"messages" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:NULL];
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

-(void) didSelectScope:(NSDictionary*) scope{
    NSString *type = [scope objectForKey:@"type"];
    NSLog(@"seen a %@ scope selected", [scope objectForKey:@"type"]);
    
    if ([type isEqualToString:@"apartment"]){
        NSArray *apartments = [scope objectForKey:@"scope"];
        for (Apartment* apartment in apartments){
            NSLog(@"%@ %@", apartment.apartmentId, apartment.name);
        }
    }
}



@end
