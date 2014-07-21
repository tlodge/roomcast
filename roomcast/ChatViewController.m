//
//  ChatViewController.m
//  roomcast
//
//  Created by Tom Lodge on 08/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()
@end

@implementation ChatViewController

@synthesize messages;
@synthesize respondView;
@synthesize respondButton;
@synthesize composing;
@synthesize delegate;
@synthesize conversationId;

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

    //observe any changes to messages for this conversation
    [[NSNotificationCenter defaultCenter] addObserverForName:@"conversationUpdate" object:nil queue:nil usingBlock:^(NSNotification *note) {
        NSDictionary* userInfo = note.userInfo;
        NSString* updatedConversation = [userInfo objectForKey:@"conversationId"];
        if ([updatedConversation isEqualToString:self.conversationId]){
            self.messages = [[DataManager sharedManager] messagesForConversation:conversationId];
            [self.tableView reloadData];
        }
    }];
    
    self.composing = YES;
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"RespondView" owner:self options:nil];
    
    respondView = [nibContents objectAtIndex:0];
    
    [respondView addTarget:self action:@selector(closeKeyboard:) forControlEvents:UIControlEventAllTouchEvents];
    
    [respondView.cancelButton addTarget:self action:@selector(toggleMessage:)
               forControlEvents:UIControlEventTouchUpInside];
    
    [respondView.respondButton addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    
    self.messages = [[DataManager sharedManager] messagesForConversation:conversationId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Message *m = [self.messages objectAtIndex:indexPath.row];
 
    MessageCell * cell = [[MessageCell alloc] init];
    
    int height = 20 +  (int) (14 * [m.body length] / 21);
    
    if (indexPath.row % 2 == 0){
        [(MessageCell *) cell initWithMessage: m.body forHeight: height forOriention:0];
    }else{
        [(MessageCell *)cell initWithMessage: m.body forHeight: height forOriention:1];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Message *m = [self.messages objectAtIndex:indexPath.row];
    int height = 20 + (int)(14 * [m.body length] / 21);
    return height;
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */


-(void) closeKeyboard:(UIControl *) sender{
    [sender endEditing:YES];
}

-(void) sendMessage:(id) sender{
    
    NSLog(@"would send message to %@", conversationId);
    [[RPCManager sharedManager] addMessageToConversation:respondView.responseText.text forConversationId:conversationId];
    
         
    //[delegate didRespondToConversation:conversationId withMessage:respondView.responseText.text];
    
    [self toggleComposer];
    //append message to conversation

    
}


- (IBAction)respondClicked:(id)sender {
    [self toggleComposer];
}

- (IBAction)toggleMessage:(id)sender {
    [self toggleComposer];
}

-(void) toggleComposer{
    if (self.composing){
        
        CGRect mainframe = [[UIScreen mainScreen] bounds];
        float width = mainframe.size.width;
        
        respondView.frame = CGRectMake(0,-respondView.frame.size.height+self.tableView.contentOffset.y,width,respondView.frame.size.height);
        
        [self.tableView addSubview:respondView];
        
        [UIView animateWithDuration:0.5f
                              delay:0.0f
                            options:UIViewAnimationCurveEaseInOut
                         animations:^{
                              respondView.frame = CGRectMake(0,self.tableView.contentOffset.y,width,respondView.frame.size.height);
                             
                         }
                         completion:^(BOOL finished) {
                         }];
        [self.respondButton setEnabled:NO];
    }else{
        CGRect mainframe = [[UIScreen mainScreen] bounds];
        float width = mainframe.size.width;
        
        [UIView animateWithDuration:0.5f
                              delay:0.0f
                            options:UIViewAnimationCurveEaseInOut
                         animations:^{
                              respondView.frame = CGRectMake(0,-respondView.frame.size.height,width,respondView.frame.size.height);
                             
                         }
                         completion:^(BOOL finished) {
                             [respondView removeFromSuperview];
                         }];
        [self.respondButton setEnabled:YES];
        
    }
    self.composing = !self.composing;
}

/*
-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqual:@"messages"]){
        return;
       // [self performSelectorOnMainThread:@selector(loadData) withObject:self waitUntilDone:NO];
    }
}*/

@end
