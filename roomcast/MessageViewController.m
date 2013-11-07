//
//  MessageViewController.m
//  roomcast
//
//  Created by Tom Lodge on 07/11/2013.
//  Copyright (c) 2013 Tom Lodge. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

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
    
    self.messages = [NSMutableArray arrayWithCapacity: 20];
    Message *m = [[Message alloc] init];
    m.from = @"Tom";
    m.body = @"Hello everyone!";
    [self.messages addObject: m];
    
    m = [[Message alloc] init];
    m.from = @"Simon";
    m.body = @"Hello everyone again!!";
    [self.messages addObject: m];

    
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
    return [self.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MessageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Message *message = [self.messages objectAtIndex:indexPath.row];
    UILabel *fromLabel  = (UILabel*)[cell viewWithTag:1];
    UILabel *bodyLabel  = (UILabel*)[cell viewWithTag:2];
    UILabel *repliesLabel = (UILabel*)[cell viewWithTag:3];

    fromLabel.text = message.from;
    bodyLabel.text = message.body;
    repliesLabel.text = @"2";
    
  

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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"am preparing for segue!");
    DetailViewController* dv = (DetailViewController *) [segue destinationViewController];
    [dv setText:@"not convinced"];
    
}

 
- (IBAction)sendMessage:(id)sender {
    
    NSLog(@"OK AM HERE");
   
    CGRect mainframe = [[UIScreen mainScreen] bounds];
    float width = mainframe.size.width;
    [aView.testButton addTarget:self action:@selector(discardMessage:)
               forControlEvents:UIControlEventTouchUpInside];
    
    aView.frame = CGRectMake(0,-200,width,200); //or whatever coordinates you need
    [self.tableView addSubview:aView];
    
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         aView.frame = CGRectMake(0,0,width,200);
                         
                     }
                     completion:^(BOOL finished) {
                     }];

}


-(void) discardMessage:(UIButton *) sender{
    

    CGRect mainframe = [[UIScreen mainScreen] bounds];
    float width = mainframe.size.width;
    
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         aView.frame = CGRectMake(0,-200,width,200);

                     }
                     completion:^(BOOL finished) {
                         [aView removeFromSuperview];
                     }];
}


@end
