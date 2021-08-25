#!/bin/bash

#
#    Copyright (C) 2021-QualityTeam_yeliqin666
#    2021-08-25 18:39:06 
#


LOCAL_DIR=$(pwd)
PROJECT_DIR=$LOCAL_DIR/$1
SHELL=$(readlink -f "$0")
SHELL_DIR=$(dirname $SHELL)
SYSTEM_DIR="${PROJECT_DIR}/system/system"
export USER=$(echo "$(whoami | gawk '{ print $1 }')")
# Fstab patches
FSTABS="$(find $PROJECT_DIR/vendor/etc -type f \( -name "fstab*" -o -name "*.fstab" \) | sed "s|^./||")"

# Fstab patches
echo -en "\n开始去除AVB校验与data加密..."

if [ -f "$PROJECT_DIR/boot/ramdisk/init" ]; then
   sed -i 's/fileencryption=ice/encryptable=ice/g' $FSTABS
   sed -i 's/,avb_keys=\/avb\/q-gsi.avbpubkey:\/avb\/r-gsi.avbpubkey:\/avb\/s-gsi.avbpubkey//g' $FSTABS
   sed -i 's/,avb//g' $FSTABS
   sed -i 's/=vbmeta_system//g' $FSTABS
   cp -afrv $PROJECT_DIR/vendor/etc/fstab.qcom $PROJECT_DIR/boot/ramdisk
   echo -en "\n成功！"
else
   echo -en "\n未解包boot！操作已停止！"
fi
echo -en "\n开始系统精简与调整操作..."
rm -fr $SYSTEM_DIR/app/mab
rm -fr $SYSTEM_DIR/app/MSA
rm -fr $SYSTEM_DIR/data-app/Youpin
rm -fr $SYSTEM_DIR/data-app/VipAccount
rm -fr $SYSTEM_DIR/data-app/Userguide
rm -fr $SYSTEM_DIR/data-app/SmartTravel
rm -fr $SYSTEM_DIR/data-app/NewHome
rm -fr $SYSTEM_DIR/data-app/MiShop
rm -fr $SYSTEM_DIR/data-app/Huanji
rm -fr $SYSTEM_DIR/app/Updater
rm -fr $SYSTEM_DIR/data-app/MiLiveAssistant
rm -fr $SYSTEM_DIR/data-app/MIFinance
rm -fr $SYSTEM_DIR/data-app/MIUIHuanji
rm -fr $SYSTEM_DIR/data-app/com.dragon.read*
rm -fr $SYSTEM_DIR/data-app/com.ss.android.article.news*
rm -fr $SYSTEM_DIR/data-app/com.zhihu.android*
rm -fr $SYSTEM_DIR/data-app/tv.danmaku.bili*
rm -fr $SYSTEM_DIR/data-app/MIUIGameCenter
rm -fr $SYSTEM_DIR/data-app/GameCenter
rm -fr $PROJECT_DIR/vendor/data-app/XMRemoteController
rm -fr $PROJECT_DIR/vendor/data-app/SmartHome
rm -fr $PROJECT_DIR/vendor/data-app/Health
mv -f $PROJECT_DIR/product/app/aiasst_service/ $SYSTEM_DIR/data-app/
mv -f $PROJECT_DIR/product/app/talkback/ $SYSTEM_DIR/data-app/
mv -f $SYSTEM_DIR/priv-app/Browser/ $SYSTEM_DIR/data-app/
mv -f $SYSTEM_DIR/priv-app/MIUIVideo/ $SYSTEM_DIR/data-app/
mv -f $SYSTEM_DIR/priv-app/MiuiVideo/ $SYSTEM_DIR/data-app/
mv -f $SYSTEM_DIR/app/Music/ $SYSTEM_DIR/data-app/
rm -fr $SYSTEM_DIR/data-app/MiuiVideo/oat
rm -fr $SYSTEM_DIR/data-app/Music/oat
rm -fr $SYSTEM_DIR/data-app/MIUIYoupin
rm -fr $SYSTEM_DIR/data-app/MIGalleryLockscreen
rm -fr $SYSTEM_DIR/data-app/MIUINewHome
rm -fr $SYSTEM_DIR/data-app/MIUISmartTravel
echo -en "\n精简与结构调整完成！"

if [ -f "$PROJECT_DIR/vendor/etc/device_features/lmi.xml" ]; then
	echo -en "\n针对K30pro进行马达驱动更新..."
	cp -rfa $SHELL_DIR/lmi/haptic/* $PROJECT_DIR/vendor/firmware
	echo -en "\n完成！"
else
	echo -en "\n非k30Pro,跳过此项调整"
fi
if [ -f "$PROJECT_DIR/vendor/etc/device_features/lmi.xml" ]; then
	echo -en "\nK30P刷新率超频中(66hz)..."
	cp -rfa $SHELL_DIR/lmi/dtbo/* $PROJECT_DIR/vendor/firmware
	echo -en "\n完成！"
else
	echo -en "\n非k30Pro,跳过此项调整"
fi
if [ -f "$PROJECT_DIR/vendor/etc/device_features/lmi.xml" ]; then
	echo -en "\n针对K30pro进行33W与温控调整..."
	cp -rfa $SHELL_DIR/lmi/thermal/* $PROJECT_DIR/vendor/etc
	echo -en "\n完成！"
else
	echo -en "\n非k30Pro,跳过此项调整"
fi
echo -en "\n功能补全中..."

if [[ $(uname -m) == "aarch64" ]]; then
    su=" "
    export PATH=$PATH:$SHELL_DIR/Insides/Droid
else
    su="sudo "
    export PATH=$PATH:$SHELL_DIR/Insides/Linux
fi


ApkTool="java -jar $SHELL_DIR/Insides/Errors/apktool/apktool.jar"

if [[ -x $(command -v apt) ]]; then
	if [[ ! -x "$(command -v java)" ]]; then
		${su}apt install openjdk-14-jdk
	fi
fi

sed -i '1 i\#Made by QualityTeam-Yeliqin666' $SYSTEM_DIR/build.prop
sed -i '1 i\persist.sys.miui.pcmode=1' $SYSTEM_DIR/build.prop
sed -i 's/Errors/Yeliqin666/g' $SYSTEM_DIR/build.prop
sed -i 's/D.N.A-Linux@x86_64/QualityTeam/g' $SYSTEM_DIR/build.prop
cp -afrv $SHELL_DIR/add/* $SYSTEM_DIR
echo -en "\n完成！"
echo -en "\n去除10s限制和主题破解项需要微调，暂不放置"
#去除10s限制和主题破解项需要微调，暂不放置
echo -en "\n开始破解卡米..."
export USER=$(echo "$(whoami | gawk '{ print $1 }')")


if [[ $(uname -m) == "aarch64" ]]; then
    su=" "
    export PATH=$PATH:$SHELL_DIR/Insides/Droid
else
    su="sudo "
    export PATH=$PATH:$SHELL_DIR/Insides/Linux
fi


ApkTool="java -jar $SHELL_DIR/Insides/Errors/apktool/apktool.jar"

if [[ -x $(command -v apt) ]]; then
	if [[ ! -x "$(command -v java)" ]]; then
		${su}apt install openjdk-14-jdk
	fi
fi


if [[ -f ${PROJECT_DIR}/system/system/build.prop ]]; then
	SYSTEM_DIR="${PROJECT_DIR}/system/system"
elif [[ -f ${PROJECT_DIR}/system/build.prop ]]; then
	SYSTEM_DIR="${PROJECT_DIR}/system"
else
	read -p "  WRONG !"
	exit
fi


${su}rm -rf $SHELL_DIR/services 2>/dev/null


if [[ -f $SYSTEM_DIR/framework/services.jar ]]; then
	if [[ $(grep "classes.dex" $SYSTEM_DIR/framework/services.jar) != "" ]]; then
		if [[ $(find $SYSTEM_DIR/ -name miui.apk 2>/dev/null) && $(find $SYSTEM_DIR/ -name miuisystem.apk) ]]; then

			$ApkTool d -r -o $SHELL_DIR/services $SYSTEM_DIR/framework/services.jar -f

			if [ -d $SHELL_DIR/services ]; then
				Crack_File=$(find $SHELL_DIR/services/ -type f -name '*.smali' 2>/dev/null | xargs grep -rl '.method private checkSystemSelfProtection(Z)V' | sed 's/^\.\///' | sort)
				sed -i '/^.method private checkSystemSelfProtection(Z)V/,/^.end method/{//!d}' $Crack_File
				sed -i -e '/^.method private checkSystemSelfProtection(Z)V/a\    .locals 1\n\n    return-void' $Crack_File

				$ApkTool b -o $SYSTEM_DIR/framework/services.jar $SHELL_DIR/services -f
				${su}rm -rf $SHELL_DIR/services 2>/dev/null
				${su}chown -hR $USER:$USER $SYSTEM_DIR/framework/services.jar
				${su}chmod -R a+rwX $SYSTEM_DIR/framework/services.jar
			fi


		else
			read -p "This ROM is not MIUI ???"
			exit
		fi
	else
		read -p "Not Devdex ??? "
		exit
	fi
else
	read -p "Not Found services.jar !"
	exit
fi

echo -en "\n破解完成！"
echo -en "\nQT纯净包制作完成，任意键返回 ..."
read

