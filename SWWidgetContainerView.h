#import "SWBatteryWidgetView.h"
#import "SWStorageWidgetView.h"

@interface SWWidgetContainerView : UIView {
	SWStorageWidgetView *_storageWidgetView;
	SWBatteryWidgetView *_batteryWidgetView;
}
-(void)setupWidgets;
-(void)setWidgetBackgrounds;
@end