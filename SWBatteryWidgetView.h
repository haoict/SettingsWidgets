@interface SWBatteryWidgetView : UIView {
    UIImageView *_batteryIconImageView;
}
@property (nonatomic, strong) UILabel *batteryHeaderLabel;
@property (nonatomic, strong) UILabel *healthLabel;
-(void)setup;
@end