#import <Foundation/Foundation.h>
#import <ApplicationServices/ApplicationServices.h>

#define MAX_DISPLAYS 10

static CGDisplayCount dispCount = MAX_DISPLAYS;
static CGDirectDisplayID dispOnline[MAX_DISPLAYS];

int main(int argc, const char * argv[]) {
	CGDisplayCount dispOnlineCount;
	CGDisplayErr errActive = CGGetOnlineDisplayList(dispCount, dispOnline, &dispOnlineCount);

	CGDisplayConfigRef configRef;
	CGError err = CGBeginDisplayConfiguration(&configRef);

	if(!argv[1]) {
		printf("usage: [-l | --list] [[-o | --origin] x y index] \n");
		return 0;
	}

	for(int i = 0; i < dispOnlineCount; i++) {
		if(dispOnline[i]) {
			int dispWidth = CGDisplayPixelsWide(dispOnline[i]);
			int dispHeight = CGDisplayPixelsHigh(dispOnline[i]);
			CGPoint dispOrigin = CGDisplayBounds(dispOnline[i]).origin;

			if(strcmp(argv[1], "--list") == 0 || strcmp(argv[1], "-l") == 0) {
				printf("display %d: %dx%d %ldx%ld\n", i, dispWidth, dispHeight, (long)dispOrigin.x, (long)dispOrigin.y);
			}

			if(strcmp(argv[1], "--origin") == 0 || strcmp(argv[1], "-o") == 0) {
				int posX = dispOrigin.x;
				int posY = dispOrigin.y;
				int dispInd = 1;

				if(argv[2]) {
					posX = strtol(argv[2], NULL, 0);
				}
				if(argv[3]) {
					posY = strtol(argv[3], NULL, 0);
				}
				if(argv[4]) {
					long _dispInd = strtol(argv[4], NULL, 0);

					if(_dispInd < dispOnlineCount) {
						dispInd = _dispInd;
					}
				}

				if(dispInd == i) {
					err = CGConfigureDisplayOrigin(configRef, dispOnline[i], posX, posY);
				}
			}
		}
	}

	err = CGCompleteDisplayConfiguration(configRef, kCGConfigurePermanently);
	if(err != 0) NSLog(@"Error with applying configuration: %d\n", err);

	return 0;
}
