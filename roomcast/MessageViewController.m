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

MessageView* aView;

- (id)initWithStyle:(UITableViewStyle)style
{
   

    self = [super initWithStyle:style];
    if (self) {
       
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
   
    
    [super viewDidLoad];
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"MessageView"
                                                         owner:self
                                                       options:nil];
    aView = [nibContents objectAtIndex:0];
    id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    

    
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Conversation" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    self.conversations = [NSMutableArray arrayWithArray:fetchedObjects];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    
   Conversation *conversation = [self.conversations objectAtIndex:indexPath.row];
    
    
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
    self.selectedConversation = [conversations objectAtIndex:ip.row];
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"am preparing for segue!");
    ChatViewController* cvc = (ChatViewController *) [segue destinationViewController];
    
    NSSet *set = [selectedConversation valueForKey:@"messages"];
    
    for (Message *m in set){
        NSLog(@"message is %@", m.body);
    }
    
    cvc.messages = [set allObjects];
    [cvc chatID:@"mychatid"];
}

 
- (IBAction)composeMessage:(id)sender {
    
    CGRect mainframe = [[UIScreen mainScreen] bounds];
    float width = mainframe.size.width;
    
    [aView addTarget:self action:@selector(closeKeyboard:) forControlEvents:UIControlEventAllTouchEvents];
    
    [aView.backButton addTarget:self action:@selector(discardMessage:)
               forControlEvents:UIControlEventTouchUpInside];
    
    [aView.sendButton addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    
    [aView.whotoButton addTarget:self action:@selector(pushDestination:) forControlEvents:UIControlEventTouchUpInside];
    
    
    aView.frame = CGRectMake(0,-313,width,313); //or whatever coordinates you need
    [self.tableView addSubview:aView];
    
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         aView.frame = CGRectMake(0,0,width,313);
                         
                     }
                     completion:^(BOOL finished) {
                     }];

}

-(void) closeKeyboard:(UIControl *) sender{
    [sender endEditing:YES];
}

-(void) pushDestination:(UIButton *) sender{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DestinationViewController *destination = [storyboard instantiateViewControllerWithIdentifier:@"destination"];
    [self.navigationController pushViewController:destination animated:YES];
}

-(void) sendMessage:(UIButton *)sender{
    NSLog(@"sending! %@", aView.messageView.text);
    id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    
    Conversation *conversation = [NSEntityDescription
                                  insertNewObjectForEntityForName:@"Conversation"
                                  inManagedObjectContext:self.managedObjectContext];
    
    [conversation setValue:aView.messageView.text forKey:@"teaser"];
    [conversation setValue:@"1D" forKey:@"initiator"];
    [conversation setValue:[NSDate date] forKey:@"started"];
    
    Message *message = [NSEntityDescription
                         insertNewObjectForEntityForName:@"Message"
                         inManagedObjectContext:self.managedObjectContext];
    
    [message setValue:@"1D" forKey:@"from"];
    [message setValue:aView.messageView.text forKey:@"body"];
    [message setValue:[NSDate date] forKey:@"sent"];
    [message setValue:conversation forKey:@"conversation"];
    
    NSError *error;
    if (![self.managedObjectContext save:&error]){
        NSLog(@"whoops! couldn't save %@", [error localizedDescription]);
    }
    
    [self.conversations addObject:conversation];
    [self.tableView reloadData];
}

-(void) discardMessage:(UIButton *) sender{

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
}

#pragma textfield deligate


@end
