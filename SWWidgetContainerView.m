#import "SWWidgetContainerView.h"
#import <objc/runtime.h>
#define ALERT(x) [[[UIAlertView alloc] initWithTitle:@"Alert!" message:x delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show]

@implementation SWWidgetContainerView
-(CGSize)intrinsicContentSize {
	return CGSizeMake(0, 120);
}
-(void)setupWidgets {
	_batteryWidgetView = [[SWBatteryWidgetView alloc] init];
	_batteryWidgetView.layer.cornerRadius = 16;
	_batteryWidgetView.translatesAutoresizingMaskIntoConstraints = NO;
	UITapGestureRecognizer *batteryTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openBatteryPage)];
	[_batteryWidgetView addGestureRecognizer:batteryTapGestureRecognizer];
	[_batteryWidgetView setup];

	_storageWidgetView = [[SWStorageWidgetView alloc] init];
	_storageWidgetView.layer.cornerRadius = 16;
	_storageWidgetView.translatesAutoresizingMaskIntoConstraints = NO;

	UITapGestureRecognizer *storageTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openStoragePage)];
	[_storageWidgetView addGestureRecognizer:storageTapGestureRecognizer];
	[_storageWidgetView setup];

	[self addSubview: _batteryWidgetView];
	[self addSubview: _storageWidgetView];

	[_batteryWidgetView.leadingAnchor constraintEqualToAnchor: self.leadingAnchor constant:15].active = YES;
	[_batteryWidgetView.trailingAnchor constraintEqualToAnchor: self.centerXAnchor constant:-7.5].active = YES;
	[_batteryWidgetView.topAnchor constraintEqualToAnchor: self.topAnchor constant:5].active = YES;
	[_batteryWidgetView.bottomAnchor constraintEqualToAnchor: self.bottomAnchor constant:-15].active = YES;

	[_storageWidgetView.leadingAnchor constraintEqualToAnchor: self.centerXAnchor constant:7.5].active = YES;
	[_storageWidgetView.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant:-15].active = YES;
	[_storageWidgetView.topAnchor constraintEqualToAnchor: self.topAnchor constant:5].active = YES;
	[_storageWidgetView.bottomAnchor constraintEqualToAnchor: self.bottomAnchor constant:-15].active = YES;
}
-(void)openBatteryPage {
	//TODO: jump to battery page
}
-(void)openStoragePage {
	//TODO: jump to storage page
}
-(void)setWidgetBackgrounds {
	if (@available(iOS 13, *)) {
		if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark) {
			_batteryWidgetView.backgroundColor = [UIColor colorWithRed:38.f/255.f green:38.f/255.f blue:38.f/255.f alpha:1.0];
			_storageWidgetView.backgroundColor = [UIColor colorWithRed:38.f/255.f green:38.f/255.f blue:38.f/255.f alpha:1.0];
			return;
		}
	}
	_batteryWidgetView.backgroundColor = [UIColor whiteColor];
	_storageWidgetView.backgroundColor = [UIColor whiteColor];
}

@end