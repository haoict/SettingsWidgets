#import "SWDiskUsageView.h"
#import <objc/runtime.h>
#define ALERT(x) [[[UIAlertView alloc] initWithTitle:@"Alert!" message:x delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show]

extern uint64_t getTotalDiskSpace(void);
extern uint64_t getFreeDiskSpace(void);

static inline UIColor *colorWithRGB(unsigned char red, unsigned char green, unsigned char blue) {
    return [UIColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:1.0];
}

static inline double GBFromBytes(double bytes) {
    return (bytes / (1000 * 1000 * 1000));
}

uint64_t getTotalDiskSpace()  {
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];  

    if (dictionary) {  
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        return [fileSystemSizeInBytes unsignedLongLongValue];
	}
	return 0;
}

uint64_t getFreeDiskSpace() {
    uint64_t totalSpace = 0;
    uint64_t totalFreeSpace = 0;
    NSError *error = nil;  
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];  

    if (dictionary) {  
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];  
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
	}

    return totalFreeSpace;
}
@interface PSCapacityBarData : NSObject
@property long long bytesUsed;
@property long long capacity;
@end

@interface STStorageController : NSObject
-(void)updateOtherDataSize;
-(void)updateCategories:(id)arg1;
@end

@interface STStorageDiskMonitor : NSObject
+(id)sharedMonitor;
-(void)updateDiskSpace;
-(long long)storageSpace;
-(long long)deviceSize;
-(long long)lastFree;
@end

@implementation SWDiskUsageView
-(CGSize)intrinsicContentSize {
    return CGSizeMake(0, 40);
}
-(void)setup {
    static dispatch_once_t dataToken;
    dispatch_once(&dataToken, ^{
        NSBundle *storageSettingsBundle = [NSBundle bundleWithPath:@"/System/Library/PreferenceBundles/StorageSettings.bundle"];
        [storageSettingsBundle load];
        STStorageDiskMonitor *monitor = [objc_getClass("STStorageDiskMonitor") sharedMonitor];
        [monitor updateDiskSpace];

        long long totalDiskSpace = monitor.deviceSize;
        long long usedDiskSpace = totalDiskSpace - monitor.lastFree;

        _totalDiskSpace = totalDiskSpace;
        _usedDiskSpace = usedDiskSpace;
        //[storageSettingsBundle unload];
    });

    _backgroundView = [UIView new];
    _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    _backgroundView.layer.cornerRadius = 3;

    _diskBarView = [UIView new];
    _diskBarView.layer.cornerRadius = 3;
    _diskBarView.translatesAutoresizingMaskIntoConstraints = NO;

    _usageLabel = [UILabel new];
    _usageLabel.text = [NSString stringWithFormat:@"%.01f GB / %llu GB", (double)GBFromBytes(_usedDiskSpace), (uint64_t)GBFromBytes(_totalDiskSpace)];
    _usageLabel.textAlignment = NSTextAlignmentCenter;
    _usageLabel.font = [UIFont boldSystemFontOfSize:9];
    _usageLabel.translatesAutoresizingMaskIntoConstraints = NO;

    [self addSubview: _backgroundView];
    [self addSubview: _diskBarView];
    [self addSubview: _usageLabel];

    [_backgroundView.leadingAnchor constraintEqualToAnchor: self.leadingAnchor constant:15].active = YES;
    [_backgroundView.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant:-15].active = YES;
    [_backgroundView.bottomAnchor constraintEqualToAnchor: self.bottomAnchor constant:-5].active = YES;
    [_backgroundView.topAnchor constraintEqualToAnchor: self.bottomAnchor constant:-12.5].active = YES;

    CGFloat diskMultiplier = (float)_usedDiskSpace / (float)_totalDiskSpace;

    [_diskBarView.leadingAnchor constraintEqualToAnchor: self.leadingAnchor constant:15].active = YES;
    [_diskBarView.widthAnchor constraintEqualToAnchor: _backgroundView.widthAnchor multiplier: diskMultiplier].active = YES;
    //[self.diskBarView.trailingAnchor constraintEqualToAnchor: self.trailingAnchor constant:-15].active = YES;
    [_diskBarView.bottomAnchor constraintEqualToAnchor: self.bottomAnchor constant:-5].active = YES;
    [_diskBarView.topAnchor constraintEqualToAnchor: self.bottomAnchor constant:-12.5].active = YES;

    [_usageLabel.centerXAnchor constraintEqualToAnchor: self.centerXAnchor].active = YES;
    [_usageLabel.bottomAnchor constraintEqualToAnchor: _backgroundView.topAnchor constant:-5].active = YES;

    [self setBarBackgroundColor];

}
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self setBarBackgroundColor];
}
-(void)setBarBackgroundColor {
    if (@available(iOS 13, *)) {
		if ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleLight) {
			_backgroundView.backgroundColor = colorWithRGB(209, 209, 209);
            _diskBarView.backgroundColor = colorWithRGB(70, 70, 70);
            
		} else {
            _backgroundView.backgroundColor = colorWithRGB(79, 79, 79);
           _diskBarView.backgroundColor = colorWithRGB(224, 224, 224);
        }
	} else {
        _backgroundView.backgroundColor = colorWithRGB(209, 209, 209);
        _diskBarView.backgroundColor = colorWithRGB(70, 70, 70);
    }
}

@end