#import "Development.h"

@protocol RPCProtocol <NSObject>
-(void) createConversationWithMessage:(NSString *)message parameters:(NSDictionary *)params;
-(void) addMessageToConversation:(NSString*) message forConversationId:(NSString*)conversationId;

//call button custom cloud code
-(void) setRatingFor:(NSString*)notificationId withValue:(int)rating;
-(void) buttonPressed:(NSString*) buttonId;

-(void) loadAuthZonesForDevelopment:(NSString *) developmentId  withCallback: (void(^)(NSArray* zones)) callback;

-(void) registerUser: (NSDictionary *) duser withApartmentName:(NSString*) apartmentName withFloor:(NSString*) floor withDevelopment:(Development*) development  withBlock:(Block*)blk withCallback: (void(^)(BOOL succeeded, NSError *error)) callback;

@end