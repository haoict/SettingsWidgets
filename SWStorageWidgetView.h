#import "SWDiskUsageView.h"

@interface SWStorageWidgetView : UIView {
    UILabel *_storageHeaderLabel;
    UILabel *_usageLabel;
    SWDiskUsageView *_diskUsageView;
    UIImageView *_settingsIconImageView;
}
-(void)setup;

@end