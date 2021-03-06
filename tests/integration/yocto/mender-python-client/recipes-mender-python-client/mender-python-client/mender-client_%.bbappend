SYSTEMD_AUTO_ENABLE = "disable"

FILES_${PN} += "${datadir}/mender/install \
                /data/mender/device_type"

do_install_append() {
    if ${@bb.utils.contains('MENDER_FEATURES', 'mender-image', 'true', 'false', d)}; then
        # symlink /var/lib/mender to /data/mender
        rm -rf ${D}/${localstatedir}/lib/mender
        ln -s /data/mender ${D}/${localstatedir}/lib/mender

        install -m 755 -d ${D}/data/mender
        install -m 444 ${B}/device_type ${D}/data/mender/
        ln -s ${bindir}/mender-sub-updater ${D}${datadir}/mender/install
    else
        bbwarn "mender-image feature not set in MENDER_FEATURES"
    fi

}