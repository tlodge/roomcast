@protocol MessageScopeDelegate <NSObject>
-(void) didSelectScope:(NSString*) scopeName withValues:(NSMutableArray*) scopeValues withSummary:(NSString*) summary;
@end