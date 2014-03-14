@protocol ApartmentAddDelegate <NSObject>

-(void) didSelectApartment:(Apartment*) apartment forBlockId:(NSString*) blockId;

@end