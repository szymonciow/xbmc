#!/bin/bash

echo "copy root files"

if [ "$ACTION" = build ] ; then

# for external testing
#TARGET_NAME=XBMC.app
#SRCROOT=/Users/Shared/xbmc_svn/XBMC
#TARGET_BUILD_DIR=/Users/Shared/xbmc_svn/XBMC/build/Debug

# rsync command with exclusions for items we don't want in the app package
SYNC="rsync -aq --exclude .git* --exclude .DS_Store* --exclude *.dll --exclude *.DLL --exclude *linux.* --exclude *arm-osx.* --exclude *.zlib --exclude *.a"

# rsync command for excluding pngs and jpgs as well. Note that if the skin itself is not compiled
# using XBMCTex then excluding the pngs and jpgs will most likely make the skin unusable 
SYNCSKIN="rsync -aq --exclude .git* --exclude CVS* --exclude .svn* --exclude .cvsignore* --exclude .cvspass* --exclude .DS_Store* --exclude *.dll  --exclude *.DLL --exclude *linux.* --exclude *.png --exclude *.jpg --exclude *.bat"

# rsync command for including everything but the skins
ADDONSYNC="rsync -aq --exclude .git* --exclude .DS_Store* --exclude skin.confluence --exclude skin.touched"

mkdir -p "$TARGET_BUILD_DIR/$TARGET_NAME/Contents/Resources/XBMC"
mkdir -p "$TARGET_BUILD_DIR/$TARGET_NAME/Contents/Resources/XBMC/addons"
mkdir -p "$TARGET_BUILD_DIR/$TARGET_NAME/Contents/Resources/XBMC/language"
mkdir -p "$TARGET_BUILD_DIR/$TARGET_NAME/Contents/Resources/XBMC/media"
mkdir -p "$TARGET_BUILD_DIR/$TARGET_NAME/Contents/Resources/XBMC/sounds"
mkdir -p "$TARGET_BUILD_DIR/$TARGET_NAME/Contents/Resources/XBMC/system"
mkdir -p "$TARGET_BUILD_DIR/$TARGET_NAME/Contents/Resources/XBMC/userdata"
mkdir -p "$TARGET_BUILD_DIR/$TARGET_NAME/Contents/Resources/XBMC/media"
mkdir -p "$TARGET_BUILD_DIR/$TARGET_NAME/Contents/Resources/XBMC/tools/darwin/runtime"
mkdir -p "$TARGET_BUILD_DIR/$TARGET_NAME/Contents/Resources/XBMC/extras/user"

${SYNC} "$SRCROOT/LICENSE.GPL" 	"$TARGET_BUILD_DIR/$TARGET_NAME/Contents/Resources/"
${SYNC} "$SRCROOT/xbmc/osx/Credits.html" 	"$TARGET_BUILD_DIR/$TARGET_NAME/Contents/Resources/"
${SYNC} "$SRCROOT/tools/darwin/runtime"	"$TARGET_BUILD_DIR/$TARGET_NAME/Contents/Resources/XBMC/tools/darwin"
${ADDONSYNC} "$SRCROOT/addons"		"$TARGET_BUILD_DIR/$TARGET_NAME/Contents/Resources/XBMC"
${SYNC} "$SRCROOT/language"		"$TARGET_BUILD_DIR/$TARGET_NAME/Contents/Resources/XBMC"
${SYNC} "$SRCROOT/media" 		"$TARGET_BUILD_DIR/$TARGET_NAME/Contents/Resources/XBMC"
${SYNCSKIN} "$SRCROOT/addons/skin.confluence" 	"$TARGET_BUILD_DIR/$TARGET_NAME/Contents/Resources/XBMC/addons"
${SYNC} "$SRCROOT/addons/skin.confluence/backgrounds" 	"$TARGET_BUILD_DIR/$TARGET_NAME/Contents/Resources/XBMC/addons/skin.confluence"
${SYNC} "$SRCROOT/addons/skin.confluence/icon.png" 	"$TARGET_BUILD_DIR/$TARGET_NAME/Contents/Resources/XBMC/addons/skin.confluence"
${SYNC} "$SRCROOT/sounds" 		"$TARGET_BUILD_DIR/$TARGET_NAME/Contents/Resources/XBMC"
${SYNC} "$SRCROOT/system" 		"$TARGET_BUILD_DIR/$TARGET_NAME/Contents/Resources/XBMC"
${SYNC} "$SRCROOT/userdata" 	"$TARGET_BUILD_DIR/$TARGET_NAME/Contents/Resources/XBMC"

# copy extra packages if applicable
if [ -d "$SRCROOT/extras/system" ]; then
	${SYNC} "$SRCROOT/extras/system/" "$TARGET_BUILD_DIR/$TARGET_NAME/Contents/Resources/XBMC"
fi

# copy extra user packages if applicable
if [ -d "$SRCROOT/extras/user" ]; then
	${SYNC} "$SRCROOT/extras/user/" "$TARGET_BUILD_DIR/$TARGET_NAME/Contents/Resources/XBMC/extras/user"
fi



# magic that gets the icon to update
touch "$TARGET_BUILD_DIR/$TARGET_NAME"

# not sure we want to do this with out major testing, many scripts cannot handle the spaces in the app name
#mv "$TARGET_BUILD_DIR/$TARGET_NAME" "$TARGET_BUILD_DIR/XBMC Media Center.app"

fi
