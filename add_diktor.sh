wget -P /usr/share/X11/xkb/symbols/ ./linux/diktor
sed -i'' '/! layout/a diktor    Ukrainian Typewriter Diktor' /usr/share/X11/xkb/rules/evdev.lst /usr/share/X11/xkb/rules/base.lst
sed -i'' ' <layout> <configItem> <name>ua</name> <!-- Keyboard indicator for Ukrainian ayouts --> <shortDescription>ua</shortDescription> <description>Ukrainian</description> <languageList> <iso639Id>ukr</iso639Id> </languageList> </configItem> <variantList> ' /usr/share/X11/xkb/rules/evdev.xml /usr/share/X11/xkb/rules/base.xml
