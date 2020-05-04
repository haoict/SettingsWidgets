#import "SWBatteryWidgetView.h"

@implementation SWBatteryWidgetView

extern CFTypeRef IOPSCopyPowerSourcesByType(int type);
static int getBatteryHealth() {
	NSArray *maxCapacityPercent = (__bridge NSArray *)IOPSCopyPowerSourcesByType(1);
	return [[maxCapacityPercent[0] objectForKey:@"Maximum Capacity Percent"] intValue];
}

-(void)setup {

	int batteryHealth = getBatteryHealth();
	NSString *batteryHealthAvailableString = [NSString stringWithFormat: @"%@%%", [@(batteryHealth) stringValue]];
    _healthLabel = [[UILabel alloc] init];
	_healthLabel.text = [NSString stringWithFormat:@"Max Capacity: %@", batteryHealth ? batteryHealthAvailableString : @"―"];
	_healthLabel.font = [UIFont boldSystemFontOfSize:13];
    _healthLabel.textAlignment = NSTextAlignmentCenter;
	_healthLabel.translatesAutoresizingMaskIntoConstraints = NO;

    _batteryHeaderLabel = [[UILabel alloc] init];
	_batteryHeaderLabel.text = @"Battery Health";
	_batteryHeaderLabel.font = [UIFont boldSystemFontOfSize:15];
	_batteryHeaderLabel.adjustsFontSizeToFitWidth = YES;
	_batteryHeaderLabel.minimumScaleFactor = 0.6;
	_batteryHeaderLabel.numberOfLines = 1;
	_batteryHeaderLabel.textAlignment = NSTextAlignmentLeft;
	_batteryHeaderLabel.translatesAutoresizingMaskIntoConstraints = NO;

	NSBundle *bundle = [[NSBundle alloc] initWithPath:@"/Library/Application Support/SettingsInfo"];
	NSString *imagePath = [bundle pathForResource:@"batteryicon" ofType:@"png"];
	UIImage *batteryIconImage = [UIImage imageWithContentsOfFile:imagePath];
	UIImage *batteryIconImageScaled =  [UIImage imageWithCGImage:[batteryIconImage CGImage] scale:(batteryIconImage.scale * 3) orientation:(batteryIconImage.imageOrientation)];

	_batteryIconImageView = [[UIImageView alloc] initWithImage:batteryIconImageScaled];
	_batteryIconImageView.layer.masksToBounds = YES;
	_batteryIconImageView.layer.cornerRadius = 14.5;
	_batteryIconImageView.translatesAutoresizingMaskIntoConstraints = NO;

	[self addSubview: _batteryIconImageView];
	[self addSubview: _batteryHeaderLabel];
	[self addSubview: _healthLabel];

	[_batteryHeaderLabel.leadingAnchor constraintEqualToAnchor: _batteryIconImageView.trailingAnchor constant:7.5].active = YES;
	//[_batteryHeaderLabel.topAnchor constraintEqualToAnchor:]
	[_batteryHeaderLabel.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant:-7.5].active = YES;

	[_batteryHeaderLabel.centerYAnchor constraintEqualToAnchor: _batteryIconImageView.centerYAnchor].active = YES;

	[_batteryIconImageView.topAnchor constraintEqualToAnchor: self.topAnchor constant: 10].active = YES;
	[_batteryIconImageView.bottomAnchor constraintEqualToAnchor: self.topAnchor constant: 10 + batteryIconImageScaled.size.height].active = YES;
	[_batteryIconImageView.leadingAnchor constraintEqualToAnchor: self.leadingAnchor constant:10].active = YES;
	[_batteryIconImageView.trailingAnchor constraintEqualToAnchor: self.leadingAnchor constant: 10 + batteryIconImageScaled.size.width].active = YES;

	[_healthLabel.bottomAnchor constraintEqualToAnchor: self.bottomAnchor constant: -15].active = YES;
	[_healthLabel.centerXAnchor constraintEqualToAnchor: self.centerXAnchor].active = YES;

}

@end

//super void *** integer pionter go suck oin