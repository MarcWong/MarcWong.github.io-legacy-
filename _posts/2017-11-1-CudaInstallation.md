---
layout: post
title:  "[备忘] Ubuntu16.04显卡驱动及Cuda安装"
date:   2017-11-1
excerpt: "Ubuntu16.04显卡驱动及Cuda安装的踩坑记录"
---

# ubuntu 16.04安装

### 启动选项

安装时，选择"install ubuntu"后，按"e"进入编辑模式，进入命令行模式, 然后去掉"--"后，依照不同显卡进行不同显卡驱动选项的添加

- 1.Intel 82852/82855 或8系列显示晶片：i915.modeset=1或i915.modeset=0
- 2.Nvidia：nomodeset
- 3.其它厂牌(如ATI，技嘉)：xforcevesa或radeon.modeset=0 xforcevesa

> 按下 F10 / CTRL+X 继续安装

### 如果当安装结束后，启动系统出现黑画面

- 1.开机，进入grub画面(如果硬碟没有别的OS,请开机时按住shift不放才会有grub画面)
- 2.按'''e''' 进入编辑开机指令的模式, 同样找到'''quite splash''' 并在后面加上对应的字。
- 3.按 ''F10''启动系统.
- 4.进去系统之后编辑'''/etc/default/grub''' 这个档案(要管理者权限sudo)。Ubuntu>打开终端机，输入sudo vi /etc/default/grub
- 5.找到这一行:GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"，修改为：GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nomodeset"
- 6.更新GRUB： sudo update-grub
- 7.存档，并重新开机。

### 更改启动分辨率：

- 方法一：
```
sudo gedit /etc/default/grub
```
将set gfxmode改成目标分辨率，去掉注释

- 方法二：
```
sudo gedit　/boot/grub/grub.cfg
```
将GRUB_GFXPAYLOAD_LINUX改成目标分辨率，去掉注释

# nvidia driver/cuda安装

## 0.卸载指令（如有老版本，需要先进行卸载）：

### 1) 卸载所有驱动

```
sudo apt-get purge nvidia-cuda*
sudo apt-get purge nvidia-*
```

### 2) 卸载安装包

```
NVIDIA-Linux-x86_64-xxxxxx.run —uninstall
```

### 3) 卸载cuda

```
/usr/local/cuda/bin/uninstall_cuda_x.x.pl
```

## 1.NVIDIA 驱动安装

### 1) 下载驱动

请移步[英伟达官网](https://www.nvidia.com/Download/index.aspx)

### 2) Ctrl+alt+F1 进入字符界面,关闭图形界面
```
sudo service lightdm stop
```

### 3) 安装NVIDIA驱动

单显卡的16.04机器可以考虑直接apt安装，我的微星GE72和装970的台式机都安装成功了

```
sudo apt-get update
sudo apt-get install nvidia-xxx
```

如多卡，或者是14.04，建议通过run文件安装

```
sudo chmod 777 NVIDIA-Linux-x86_64-384xxx.run
sudo ./NVIDIA-Linux-x86_64-384xxx.run  –-no-opengl-files　//避免循环登陆
```

### 3) 重启图形界面
```
sudo service lightdm start
sudo reboot　//重启 
nvidia-smi //开机后查看是否安装成功
```

## 2.安装CUDA 8.0/9.x(14.04最高支持8.0)

### 1) 下载Cuda

请移步[英伟达官网](https://www.nvidia.com/Download/index.aspx)

或者在终端运行指令(以cuda 8.0为例):

```
wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run

wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/patches/2/cuda_8.0.61.2_linux-run

chmod 777 cuda_***.run
sudo sh cuda_***.run --no-opengl-libs
```

### 2) 在提示是否安装显卡驱动时，选择no，其他各项提示选择是，并默认安装路径。安装结果提示少库的话，按提示安装。

### 3) 修改命令行配置

```sudo vim /etc/profile```

在文件中输入以下两行：

```
export PATH=$PATH:/usr/local/cuda-x.x/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-x.x/lib64
```

之后

```
source /etc/profile
sudo ldconfig //使环境变量立即生效
```

### 4) 验证安装是否完成

nvcc -V

## 3.安装cudnn 6.0/7.0

### 1 cudnn下载 

- 6.0
```
wget http://developer.download.nvidia.com/compute/redist/cudnn/v6.0/cudnn-8.0-linux-x64-v6.0.tgz
```
- 7.0(membership required)
```
https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v7.0.5/prod/9.1_20171129/cudnn-9.1-linux-x64-v7
```

### ２) cudnn安装(以6.0为例)

```
tar -xvf cudnn-8.0-linux-x64-v6.0-rc.tgz

cd $dir/cuda/include 

sudo cp cudnn.h /usr/local/cuda/include/

cd $dir/cuda/lib64

sudo cp libcudnn* /usr/local/cuda/lib64/

cd /usr/local/cuda/lib64

sudo chmod a+r libcudnn* /usr/local/cuda/include/cudnn.h

sudo ln -sf libcudnn.so.6.x.x libcudnn.so.6

sudo ln -sf libcudnn.so.6 libcudnn.so

sudo ldconfig -v
```

## 4.安装tensorflow&keras

```
sudo pip install -U --pre pip setuptools wheel
sudo pip install -U --pre numpy scipy matplotlib scikit-learn scikit-image
sudo pip install -U --pre tensorflow-gpu 
sudo pip install -U --pre keras
```

常用Tensorflow-gpu 参数:

==1.4.0： 指定安装版本，cuda8.0最多只支持到1.4.0

--ingore-installed：　解决报错``Cannot uninstall 'xxx'. It is a distutils installed project and thus we cannot accurately determine which files belong to it which would lead to only a partial uninstall.``