#!/bin/bash
#============== 路径信息 ========================#
#工程名
project_name=WJXAlertView
#工程绝对路径
project_path=$(dirname $0)
#project工程文件路径
folder_ProjectPath=${project_path}/${project_name}/${project_name}.xcodeproj/project.pbxproj
#infor文件路径
folder_InfoPath=${project_path}/${project_name}/${project_name}/Supporting\ Files/info.plist


#============== 选择模式 ========================#
#模式
echo " "
echo "设置:[1:正式包 2:马甲包]"
read APPNumber
while([[ $APPNumber != 1 ]] && [[ $APPNumber != 2 ]])
do
echo " "
echo "设置:[1:正式包 2:马甲包]"
read APPNumber
done

#如果是上传app store version版本号
echo " "
echo "上传的版本号："
read versionCode
while([ "$versionCode" == "" ])
do
echo " "
echo "上传的版本号："
read versionCode
done

#如果是上传app store build构建号
echo " "
echo "上传的构建号："
read buildCode
while([ "$buildCode" == "" ])
do
echo " "
echo "上传的构建号："
read buildCode
done

echo ${folder_InfoPath}

/usr/libexec/PlistBuddy -c "Set CFBundleShortVersionString ${versionCode}" ${folder_InfoPath}
/usr/libexec/PlistBuddy -c "Set CFBundleVersion ${buildCode}" ${folder_InfoPath}

##修改参数
if [ $APPNumber == 2 ] ;then
   #马甲包
   sed -i -r 's/ASSETCATALOG_COMPILER_APPICON_NAME.*$/ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon-1;/g' ${folder_ProjectPath}
   sed -i -r 's/ASSETCATALOG_COMPILER_LAUNCHIMAGE_NAME.*$/ASSETCATALOG_COMPILER_LAUNCHIMAGE_NAME = LaunchImage-1;/g' ${folder_ProjectPath}
else
   ##正式包
   sed -i -r 's/ASSETCATALOG_COMPILER_APPICON_NAME.*$/ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;/g' ${folder_ProjectPath}
   sed -i -r 's/ASSETCATALOG_COMPILER_LAUNCHIMAGE_NAME.*$/ASSETCATALOG_COMPILER_LAUNCHIMAGE_NAME = LaunchImage;/g' ${folder_ProjectPath}
fi
if [[ -f ${folder_InfoPath}-r ]]; then
   rm -rf ${folder_InfoPath}-r
fi
if [[ -f ${folder_ProjectPath}-r ]]; then
   rm -rf ${folder_ProjectPath}-r
fi

exit 0
