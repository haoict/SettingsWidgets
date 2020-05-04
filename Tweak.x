
#import "SWWidgetContainerView.h"

@interface UITraitCollection (iOS13)
+(UITraitCollection *)currentTraitCollection;
@end

@interface PSUIPrefsListController : UIViewController
@property (nonatomic, retain) SWWidgetContainerView *widgetContainerView;
@end

int __isOSVersionAtLeast(int major, int minor, int patch) {
	NSOperatingSystemVersion version;
	version.majorVersion = major;
	version.minorVersion = minor;
	version.patchVersion = patch;
	return [[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:version];
}

%hook PSUIPrefsListController
%property (nonatomic, retain) SWWidgetContainerView *widgetContainerView;
-(void)viewWillAppear:(BOOL)arg1 {
	%orig;
	UITableView *tblView = self.view.subviews[0];
	self.widgetContainerView.frame = CGRectMake(0, 0, tblView.frame.size.width, 120);
}
-(void)viewDidLoad {
	%orig;
	UITableView *tblView = self.view.subviews[0];

	self.widgetContainerView = [[SWWidgetContainerView alloc] init];
	self.widgetContainerView.backgroundColor = UIColor.clearColor;

	tblView.tableHeaderView = self.widgetContainerView;

	[self.widgetContainerView setupWidgets];
	[self.widgetContainerView setWidgetBackgrounds];
}

-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
	%orig;
	[self.widgetContainerView setWidgetBackgrounds];
}

%end


%ctor {
	%init(_ungrouped);
    //CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, notificationCallback, (CFStringRef)NSBundleDidLoadNotification, NULL, CFNotificationSuspensionBehaviorCoalesce);
}