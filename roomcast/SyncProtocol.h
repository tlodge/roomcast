#import "Conversation.h"
#import "Block.h"

@protocol SyncProtocol <NSObject>

-(void) syncWithConversation:(Conversation*) conversation;
-(void) syncWithConversations;
-(BOOL) syncWithDevelopment:(NSString*) objectId;
-(void) syncWithDevelopments: (NSString*)objectId;
-(void) syncWithBlock:(Block *)block;
-(void) syncWithNotifications;
-(void) syncWithButtons;

@end
