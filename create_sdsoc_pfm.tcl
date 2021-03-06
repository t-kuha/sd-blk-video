# May have to delete existing platform directory

# Platform name
set PFM_NAME            sd_blk_video
set SRC_DIR             pfm_files
set PREBUILT_DATA_DIR   ${SRC_DIR}/_prebuilt
set BOOT_DIR            ${SRC_DIR}/_boot
set IMG_DIR             ${SRC_DIR}/_image
set PREBUILT_DIR        ${SRC_DIR}/_prebuilt
set INIT_PRJ_DIR        _prj_0
set PLNX_ROOT           petalinux

# Check whether prebuilt data folder exists
set HAS_PREBUILT [file exists ${INIT_PRJ_DIR}]

if { ${HAS_PREBUILT} } then {
    set OUTDIR  _pfm
    file delete -force ${PREBUILT_DIR}
    file mkdir ${PREBUILT_DIR}

    # system.bit file should be renamed to bitstream.bit
    file copy ${INIT_PRJ_DIR}/_sds/p0/vpl/system.bit    ${PREBUILT_DIR}/bitstream.bit

    # system.hdf file should be renamed to <platform>.hdf
    file copy ${INIT_PRJ_DIR}/_sds/p0/vpl/system.hdf    ${PREBUILT_DIR}/${PFM_NAME}.hdf
    file copy ${INIT_PRJ_DIR}/_sds/.llvm/partitions.xml ${PREBUILT_DIR}
    file copy ${INIT_PRJ_DIR}/_sds/.llvm/apsys_0.xml    ${PREBUILT_DIR}
    file copy ${INIT_PRJ_DIR}/_sds/swstubs/portinfo.c   ${PREBUILT_DIR}
    file copy ${INIT_PRJ_DIR}/_sds/swstubs/portinfo.h   ${PREBUILT_DIR}
} else {
    set OUTDIR  _pfm_0
}

# Remove existing directory
file delete -force ${OUTDIR}
file delete -force ${BOOT_DIR}
file delete -force ${IMG_DIR}

file mkdir ${BOOT_DIR}
file mkdir ${IMG_DIR}

# Copy necessary output products
file copy ${PLNX_ROOT}/images/linux/u-boot.elf      ${BOOT_DIR}
file copy ${PLNX_ROOT}/images/linux/zynq_fsbl.elf   ${BOOT_DIR}
file copy ${PLNX_ROOT}/images/linux/image.ub        ${IMG_DIR}

# Create platform
platform create -name ${PFM_NAME} -hw ${PFM_NAME}.dsa -out ${OUTDIR}


# ----- Linux -----
# Create system configuration
sysconfig create -name "linux" -display-name "linux" -desc "Linux / Zynq-7000" 

sysconfig config -boot ${BOOT_DIR}
sysconfig config -bif {pfm_files/sdsoc_linux.bif}
sysconfig config -readme {pfm_files/generic.readme}

domain create -name {linux} -os {linux} -proc {ps7_cortexa9_0} -display-name {linux} -desc "Linux" -runtime "C++"

# Add prebuilt data
if { ${HAS_PREBUILT} } then {
    domain config -prebuilt-data ${PREBUILT_DATA_DIR}
}

::scw::set_linux_configured true

domain config -image ${IMG_DIR}
platform write


# Generate platform
platform generate
