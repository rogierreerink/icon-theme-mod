#!/bin/bash
# Generate icon set from theme

THEME_FOLDER="$HOME/.icons/Papirus"
MOD_FOLDER="$HOME/.icons/Mod-Papirus"

if [ ! -f "$MOD_FOLDER/selection.conf" ]; then
	echo "Error: no icon selection file found."
	exit 1
fi

ICON_SELECTION=($(cat $MOD_FOLDER/selection.conf))

if [ ! -d "$THEME_FOLDER" ]; then
	echo "Error: '$THEME_FOLDER' is not present."
	exit 1
fi

TOP_FOLDERS=(16x16 22x22 24x24 32x32 48x48 64x64 symbolic)
for TOP_FOLDER in ${TOP_FOLDERS[@]}; do

	if [ -d "$MOD_FOLDER/$TOP_FOLDER" ]; then
		rm -r "$MOD_FOLDER/$TOP_FOLDER"
	fi

	mkdir -p "$MOD_FOLDER/$TOP_FOLDER"
	
	for ICON_SELECT in ${ICON_SELECTION[@]}; do
		
		if [[ $ICON_SELECT =~ [A-Za-z]+\* ]]; then
			ln -s "$THEME_FOLDER/$TOP_FOLDER/${ICON_SELECT%?}" "$MOD_FOLDER/$TOP_FOLDER/${ICON_SELECT%?}"
			continue
		fi

		if [ -d "$THEME_FOLDER/$TOP_FOLDER/$ICON_SELECT" ]; then
			mkdir "$MOD_FOLDER/$TOP_FOLDER/$ICON_SELECT"
			continue
		fi

		if [ -f "$THEME_FOLDER/$TOP_FOLDER/$ICON_SELECT" ]; then
			ln -s "$THEME_FOLDER/$TOP_FOLDER/$ICON_SELECT" "$MOD_FOLDER/$TOP_FOLDER/$ICON_SELECT"
		fi

	done

done

TOP_2XFOLDERS=(16x16 22x22 24x24 32x32 48x48 64x64)
for TOP_2XFOLDER in ${TOP_2XFOLDERS[@]}; do
	
	if [ -d "$MOD_FOLDER/$TOP_2XFOLDER" ]; then
		if [ ! -e "$MOD_FOLDER/$TOP_2XFOLDER@2x" ]; then
			ln -s "$MOD_FOLDER/$TOP_2XFOLDER" "$MOD_FOLDER/$TOP_2XFOLDER@2x"
		fi
	fi

done

gtk-update-icon-cache "$MOD_FOLDER"

exit 0
