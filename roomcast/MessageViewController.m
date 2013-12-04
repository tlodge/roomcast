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
-(Conversation *) saveConversationWithPFObject:(PFObject *)message;
@end

@implementation MessageViewController

@synthesize conversations;
@synthesize managedObjectContext;
@synthesize selectedConversation;

MessageView* aView;
BOOL _composing = YES;

- (id)initWithStyle:(UITableViewStyle)style
{
   

    self = [super initWithStyle:style];
    if (self) {
        NSLog(@"custom init!");
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    [self getAllConversations];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Development *development = [[DataManager sharedManager] development];
    
    NSLog(@"retrieved my development as %@", development);
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"MessageView"
                                                         owner:self
                                                       options:nil];
    aView = [nibContents objectAtIndex:0];
    
    [aView addTarget:self action:@selector(closeKeyboard:) forControlEvents:UIControlEventAllTouchEvents];
    
    [aView.backButton addTarget:self action:@selector(toggleMessage:)
               forControlEvents:UIControlEventTouchUpInside];
    
    [aView.sendButton addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [aView.whotoButton addTarget:self action:@selector(pushDestination:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //self.managedObjectContext = [[[SMClient defaultClient] coreDataStore] contextForCurrentThread];
    
   //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveSyncDidFinishNotification:) name:@"FinishedSync" object:nil];
    
    
    id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) getAllConversations{
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Conversation" inManagedObjectContext:self.managedObjectContext];
    
    [fetch setEntity:entity];
    
    NSError *error;
    
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetch error:&error];
    self.conversations = [NSMutableArray arrayWithArray:fetchedObjects];
    [self.tableView reloadData];

    /*[self.managedObjectContext executeFetchRequest:fetch onSuccess:^(NSArray *results) {
        NSError *error;
        NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetch error:&error];
        self.conversations = [NSMutableArray arrayWithArray:fetchedObjects];
        [self.tableView reloadData];
    } onFailure:^(NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];*/

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
    repliesLabel.text = [NSString stringWithFormat:@"%d",[conversation.messages count]];
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
    
    NSLog(@"selected conversation is %@", selectedConversation);
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    
    dispatch_async(queue, ^{
        //this runs on background thread!
        BOOL success = [[DataManager sharedManager] syncWithConversation:self.selectedConversation];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (success){
                cvc.messages = [self.selectedConversation.messages allObjects];
                [cvc.tableView reloadData];
            }
        });
    });

    NSSet *set = [self.selectedConversation valueForKey:@"messages"];
    cvc.messages = [set allObjects];
    [cvc chatID:@"mychatid"];
}

 
- (IBAction)toggleMessage:(id)sender {
    [self toggleComposer];
}

-(void) closeKeyboard:(UIControl *) sender{
    [sender endEditing:YES];
}

-(void) pushDestination:(UIButton *) sender{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITableViewController *destination = [storyboard instantiateViewControllerWithIdentifier:@"sendto"];
    [self.navigationController pushViewController:destination animated:YES];
}

-(void) sendMessage:(UIButton *)sender{
    if ([aView.messageView.text length] == 0)
        return;
    
    NSLog(@"sending! %@", aView.messageView.text);
    //id delegate = [[UIApplication sharedApplication] delegate];
    //self.managedObjectContext = [delegate managedObjectContext];
    
    
    PFObject *co = [PFObject objectWithClassName:@"Conversation"];
    [co setObject:@"normal" forKey:@"type"];
    [co setObject:aView.messageView.text forKey:@"teaser"];
    
    PFObject *msg = [PFObject objectWithClassName:@"Message"];
    [msg setObject:aView.messageView.text forKey:@"message"];
    [msg setObject:[NSNumber numberWithBool:NO] forKey:@"anonymous"];
    [msg setObject:co forKey:@"conversation"];
    
    [msg saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        Conversation *conversation = [self saveConversationWithPFObject: msg];
        if (conversation != nil){
            [self.conversations addObject:conversation];
            [self.tableView reloadData];
            aView.messageView.text = @"";
            [self toggleComposer];
        }
    }];
    
    
}

-(Conversation*) saveConversationWithPFObject:(PFObject *) message{
    
    NSLog(@"saving %@", message);
    
    Conversation *c = [NSEntityDescription
                                  insertNewObjectForEntityForName:@"Conversation"
                                  inManagedObjectContext:self.managedObjectContext];
    
    //[conversation assignObjectId];
    PFObject* conversation = [message objectForKey:@"conversation"];
    
    [c setValue:[conversation objectId] forKey:@"conversationId"];
    [c setValue:[conversation objectForKey:@"teaser"] forKey:@"teaser"];
    [c setValue:@"1D" forKey:@"initiator"];
    [c setValue:[NSDate date] forKey:@"started"];
    
    Message *m = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Message"
                        inManagedObjectContext:self.managedObjectContext];
    
    //[message assignObjectId];
    [m setValue:[message objectId] forKey:@"messageId"];
    [m setValue:@"1D" forKey:@"from"];
    [m setValue:[message objectForKey:@"message"] forKey:@"body"];
    [m setValue:[NSDate date] forKey:@"sent"];
    [m setValue:c forKey:@"conversation"];
    
    NSError *error;
    if (![self.managedObjectContext save:&error]){
        NSLog(@"whoops! couldn't save %@", [error localizedDescription]);
        return nil;
    }
    return c;
}

-(void) toggleComposer{
    if (_composing){
        CGRect mainframe = [[UIScreen mainScreen] bounds];
        float width = mainframe.size.width;
        
        aView.frame = CGRectMake(0,-313+self.tableView.contentOffset.y,width,313); //or whatever coordinates you need
        
        [self.tableView addSubview:aView];
       
        [UIView animateWithDuration:0.5f
                              delay:0.0f
                            options:UIViewAnimationCurveEaseInOut
                         animations:^{
                             aView.frame = CGRectMake(0,self.tableView.contentOffset.y,width,313);
                             
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
                             aView.frame = CGRectMake(0,-313,width,313);
                             
                         }
                         completion:^(BOOL finished) {
                             [aView removeFromSuperview];
                         }];
        [self.composeButton setEnabled:YES];
        
    }
    _composing = !_composing;
}



#pragma textfield deligate


@end
