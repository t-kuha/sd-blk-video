# sd-blk-video

## Generate HW

- Pattern Generator IP

```shell-session
# Generate IP
$ vivado_hls -f gen_hls_pattern_gen.tcl

# Extract IP's .zip
$ mkdir -p _ip/hls_pattern_gen_axis
$ unzip _vhls/solution1/impl/ip/xilinx_com_hls_petten_gen_axis_1_0.zip \
-d _ip/hls_pattern_gen_axis
```

- Result

```text
#=== Post-Implementation Resource usage ===
SLICE:           39
LUT:            124
FF:             111
DSP:              0
BRAM:             0
SRL:              0
#=== Final timing ===
CP required:    6.700
CP achieved post-synthesis:    3.281
CP achieved post-implementation:    3.165
Timing met
```

- Generate HW & .dsa file

```shell-session
$ vivado -mode batch -source create_vivado_project.tcl
```

## Generate PetaLinux project

```shell-session
$ export PRJ=petalinux
$ petalinux-config --project ${PRJ}

# Build project
$ petalinux-build --project ${PRJ}
```

## Create BOOT.bin

- Resultant BOOT.BIN will be in: ``petalinux/images/linux/BOOT.BIN``

```shell-session
$ petalinux-package -p ${PRJ} --boot --format BIN \
--fsbl ${PRJ}/images/linux/zynq_fsbl.elf \
--u-boot ${PRJ}/images/linux/u-boot.elf \
--fpga _vivado/sd_blk_video.runs/impl_1/sd_blk_video_wrapper.bit
```

***

## Creating PetaLinux project from scratch

```shell-session
$ export PRJ=petalinux

$ petalinux-create -t project -n ${PRJ} --template zynq
$ petalinux-config --project ${PRJ} --get-hw-description=.

# Add libsdslib*.so
$ petalinux-create -p ${PRJ} -t apps --template install --name sdslib --enable
$ rm ${PRJ}/project-spec/meta-user/recipes-apps/sdslib/files/sdslib
$ cp -R ${XILINX_SDX}/target/aarch32-linux/lib/libsds_lib*.so \
${PRJ}/project-spec/meta-user/recipes-apps/sdslib/files
$ cp src/sdslib.bb petalinux/project-spec/meta-user/recipes-apps/sdslib/sdslib.bb

# Kernel config
$ petalinux-config -p ${PRJ} -c kernel

# u-boot config
$ petalinux-config -p ${PRJ} -c u-boot

# rootfs config
$ petalinux-config -p ${PRJ} -c rootfs

# Build project
$ petalinux-build --project ${PRJ}

# Generate SDK (optional)
# Build project
$ petalinux-build --project ${PRJ} --sdk
```
