# Forked from https://github.com/dievri/diktor
# diktor
Ukrainian Diktor + Typewriter Layout

![Diktor](https://raw.githubusercontent.com/dievri/diktor/master/diktor.jpg)

# Installation on windows
Just run setup.exe from diktorru directory. It will install layout to the Russian layouts with name "diktorru"
(i didn't setup it for ukrainian for now)

# Installation on Ubuntu/Debian

For manual installation, follow this steps:

1. Copy content of the file `diktor` into `/usr/share/X11/xkb/symbols/ua` file. 

After chunk
```
default partial alphanumeric_keys
xkb_symbols "unicode" {

    include "ua(legacy)"

    name[Group1]= "Ukrainian";

    key <TLDE>	{[      apostrophe,           U02BC,          U0301,          asciitilde ]};  // Apostrophe and Stress symbol
    key <AE01>	{[               1,          exclam,    onesuperior                      ]};
    key <AE02>	{[               2,        quotedbl,    twosuperior,               U2019 ]};  // Single quote, used often as an apostrophe (deprecated)
    key <AE03>	{[               3,      numerosign,        section,               U20B4 ]};  // Paragraph and Hryvnia sign
    key <AE04>	{[               4,       semicolon,         dollar,            EuroSign ]};
    key <AE05>	{[               5,         percent,         degree                      ]};
    key <AE06>	{[               6,           colon,           less                      ]};
    key <AE07>	{[               7,        question,        greater                      ]};
    key <AE08>	{[               8,        asterisk, enfilledcircbullet                  ]};  // •
    key <AE09>	{[               9,       parenleft,    bracketleft,           braceleft ]};
    key <AE10>	{[               0,      parenright,   bracketright,          braceright ]};
    key <AE11>	{[           minus,      underscore,         emdash,              endash ]};
    key <AE12>	{[           equal,            plus,       notequal,           plusminus ]};

    key <AD01>	{[ Cyrillic_shorti, Cyrillic_SHORTI,    Cyrillic_je,         Cyrillic_JE ]};
    key <AD02>	{[    Cyrillic_tse,    Cyrillic_TSE,  Cyrillic_dzhe,       Cyrillic_DZHE ]};
    key <AD03>	{[      Cyrillic_u,      Cyrillic_U, Byelorussian_shortu, Byelorussian_SHORTU ]};
    key <AD04>	{[     Cyrillic_ka,     Cyrillic_KA,     registered                      ]};  // ®
    key <AD05>	{[     Cyrillic_ie,     Cyrillic_IE,    Cyrillic_io,         Cyrillic_IO ]};
    key <AD06>	{[     Cyrillic_en,     Cyrillic_EN,   Cyrillic_nje,        Cyrillic_NJE ]};
    key <AD07>	{[ Cyrillic_ghe, Cyrillic_GHE, Ukrainian_ghe_with_upturn, Ukrainian_GHE_WITH_UPTURN ]};
    key <AD12>	{[    Ukrainian_yi,    Ukrainian_YI, Cyrillic_hardsign,Cyrillic_HARDSIGN ]};

    key <AC02>	{[     Ukrainian_i,     Ukrainian_I,  Cyrillic_yeru,       Cyrillic_YERU ]};
    key <AC08>	{[     Cyrillic_el,     Cyrillic_EL,   Cyrillic_lje,        Cyrillic_LJE ]};
    key <AC09>	{[     Cyrillic_de,     Cyrillic_DE,    Serbian_dje,         Serbian_DJE ]};
    key <AC11>	{[    Ukrainian_ie,    Ukrainian_IE,     Cyrillic_e,          Cyrillic_E ]};

    key <BKSL>	{[ Ukrainian_ghe_with_upturn, Ukrainian_GHE_WITH_UPTURN, backslash,  bar ]};

    key <AB02>	{[    Cyrillic_che,    Cyrillic_CHE,   Serbian_tshe,        Serbian_TSHE ]};
    key <AB03>	{[     Cyrillic_es,     Cyrillic_ES,      copyright                      ]};  // ©
    key <AB06>	{[     Cyrillic_te,     Cyrillic_TE,      trademark                      ]};  // ™
    key <AB08>	{[     Cyrillic_be,     Cyrillic_BE,  guillemotleft,  doublelowquotemark ]};
    key <AB09>	{[     Cyrillic_yu,     Cyrillic_YU, guillemotright, leftdoublequotemark ]};
    key <AB10>	{[          period,           comma,          slash,            ellipsis ]};

    include "level3(ralt_switch)"
};
```


place the following
```
//   DIKTOR        TPWRT, Russian

default partial alphanumeric_keys
xkb_symbols "basic" {

    name[Group1]= "DIKTOR";

    // Alphanumeric section
    key <TLDE> {	[     	equal,		bar	]	};
    key <AE01> {	[	question, 	1	]	};
    key <AE02> {	[	minus, 		2	]	};
    key <AE03> {	[	numerosign,	3	]	};
    key <AE04> {	[	colon,		4	]	};
    key <AE05> {	[	comma,		5	]	};
    key <AE06> {	[	parenleft,	6	]	};
    key <AE07> {	[	parenright,	7	]	};
    key <AE08> {	[	period,		8	]	};
    key <AE09> {	[	semicolon,	9	]	};
    key <AE10> {	[	percent,	0	]	};
    key <AE11> {	[     	quotedbl, underscore	]	};
    key <AE12> {	[     	exclam,		plus	]	};

    key <AD01> {	[ Cyrillic_tse, Cyrillic_TSE	]	};
    key <AD02> {	[ Cyrillic_softsign, Cyrillic_SOFTSIGN	]	};
    key <AD03> {	[ Cyrillic_ya, Cyrillic_YA	]	};
    key <AD04> {	[ Cyrillic_yu, Cyrillic_YU	]	};
    key <AD05> {	[ Cyrillic_io, Cyrillic_IO	]	};
    key <AD06> {	[ Cyrillic_ze, Cyrillic_ZE	]	};
    key <AD07> {	[ Cyrillic_ve, Cyrillic_VE	]	};
    key <AD08> {	[ Cyrillic_ka, Cyrillic_KA	]	};
    key <AD09> {	[ Cyrillic_de, Cyrillic_DE	]	};
    key <AD10> {	[ Cyrillic_che, Cyrillic_CHE]	};
    key <AD11> {	[ Cyrillic_sha, Cyrillic_SHA	]	};
    key <AD12> {	[ Cyrillic_shcha, Cyrillic_SHCHA	]	};

    key <AC01> {	[ Cyrillic_u, Cyrillic_U	]	};
    key <AC02> {	[ Cyrillic_i, Cyrillic_I	]	};
    key <AC03> {	[ Cyrillic_ie, Cyrillic_IE	]	};
    key <AC04> {	[ Cyrillic_o, Cyrillic_O	]	};
    key <AC05> {	[ Cyrillic_a, Cyrillic_A	]	};
    key <AC06> {	[ Cyrillic_el, Cyrillic_EL	]	};
    key <AC07> {	[ Cyrillic_en, Cyrillic_EN 	]	};
    key <AC08> {	[ Cyrillic_te, Cyrillic_TE	]	};
    key <AC09> {	[ Cyrillic_es, Cyrillic_ES	]	};
    key <AC10> {	[ Cyrillic_er, Cyrillic_ER	]	};
    key <AC11> {	[ Cyrillic_shorti, Cyrillic_SHORTI	]	};

    key <AB01> {	[ Cyrillic_ef, Cyrillic_EF	]	};
    key <AB02> {	[ Cyrillic_e, Cyrillic_E	]	};
    key <AB03> {	[ Cyrillic_ha , Cyrillic_HA	]	};
    key <AB04> {	[ Cyrillic_yeru, Cyrillic_YERU	]	};
    key <AB05> {	[ Cyrillic_hardsign, Cyrillic_HARDSIGN	]	};
    key <AB06> {	[ Cyrillic_be, Cyrillic_BE	]	};
    key <AB07> {	[ Cyrillic_em, Cyrillic_EM	]	};
    key <AB08> {	[ Cyrillic_pe, Cyrillic_PE	]	};
    key <AB09> {	[ Cyrillic_ghe, Cyrillic_GHE 	]	};
    key <AB10> {	[ Cyrillic_zhe, Cyrillic_ZHE	]	};

    key <BKSL> {	[ slash,	backslash	]	};
    
    // End alphanumeric section

};
```

2. To the file `/usr/share/X11/xkb/rules/base.lst` and `/usr/share/X11/xkb/rules/evdev.lst` under section `! variant`, add following line
```
diktor 	  ua: Ukrainian (diktor)
```
3. To the file `/usr/share/X11/xkb/rules/base.xml` and `/usr/share/X11/xkb/rules/evdev.xml` add diktor as a variant to the Russian language
```
<variant>
  <configItem>
    <name>diktor</name>
    <description>Ukrainian (diktor)</description>
  </configItem>
</variant>
```
This should be placed somewhere after 
```
<layout>
  <configItem>
    <name>ua</name>
    <!-- Keyboard indicator for Ukrainian ayouts -->
    <shortDescription>ua</shortDescription>
    <description>Ukrainian</description>
    <languageList>
      <iso639Id>ukr</iso639Id>
    </languageList>
  </configItem>
  <variantList>
```

4. For iBus, add into file `/usr/share/ibus/component/simple.xml` somewhere under section `engines` 

```
 <engine>
    <name>xkb:ua:diktor:ukr</name>
    <language>uk</language>
    <license>GPL</license>
    <author>Oleksandr Dievri</author>
    <layout>ua</layout>
    <layout_variant>diktor</layout_variant>
    <longname>Ukrainian (diktor)</longname>
    <description>Ukrainian (diktor)</description>
    <icon>ibus-keyboard</icon>
    <rank>1</rank>
</engine>
``` 
For more information, visit https://ubuntu-mate.community/t/make-your-own-custom-keyboard-layout-for-linux/19733

# Editing
You can edit this layour for your own needs, using [Microsoft Keyboard Layout Creator](https://www.microsoft.com/en-us/download/details.aspx?id=22339) and the file base.klc from "file for MKLC" directory.



Author of russian diktor on klavogonki.ru: [http://klavogonki.ru/u/#/139358/](http://klavogonki.ru/u/#/139358/)
