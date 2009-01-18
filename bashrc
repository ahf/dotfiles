#
# Alexander Færøy <ahf@0x90.dk>
#
# Most recent update: Sun 18 Jan 2009 19:42:08 CET
#

# {{{ shopt's
shopt -s extglob
shopt -s cdspell
shopt -s cmdhist
shopt -s dotglob
# }}}

# {{{ Personal stuff
name="Alexander Færøy"
mail="ahf@0x90.dk"
# }}}

# {{{ Misc.
clever_source() {
    [[ -f "${1}" ]] && source "${1}"
}
# }}}

# {{{ Utilities
goatmoatse() {
    scp $@ "eroyf@goatse.baconsvin.dk:/data/www/goat.moat.se/htdocs/"
}

vga() {
    local com="${1}"

    case "${com}" in
        on)
            echo "Enabling output to the VGA port ..."
            xrandr --output LVDS --auto --output VGA --auto --same-as LVDS
            ;;
        off)
            echo "Disabling output to the VGA port ..."
            xrandr --output VGA --off
            ;;
        *)
            echo "Use either on or off ..."
            ;;
    esac
}

genpatch() {
    local patch_output="${1}"

    echo -e "Source: Written by ${name} <${mail}>\nUpstream: \nReason: " >> "${patch_output}"

    for original_file in *.orig ; do
        changed_file="${original_file/.orig}"
        diff -u "${original_file}" "${changed_file}" >> "${patch_output}"
    done
}

mkcd() {
    mkdir "${1}" && cd "${1}"
}

unpack() {
    local file="${1}"

    case "${file}" in
        *.tar)
            tar xvf "${file}"
            ;;
        *.tar.gz|*.tgz|*.tar.Z)
            tar zxfv "${file}"
            ;;
        *.tar.bz2|*.tbz2)
            tar jxvf "${file}"
            ;;
        *.zip|*.ZIP)
            unzip "${file}"
            ;;
        *.rar|*.RAR)
            unrar x "${file}"
            ;;
        *)
            echo "Unable to unpack file ..."
            ;;
    esac
}

mktar() {
    tar jcvf "${1%%/}.tar.bz2" "${1%%/}/"
}
# }}}

# {{{ What're we running on?
if [[ -z "${!my_system_*}" ]] ; then
    my_system_arch=$(uname -m 2>&1 || echo "i686")
    my_system_kernel=$(uname -s 2>&1 || echo "Linux")
fi
# }}}

# {{{ Locale
# Note: OpenBSD is retarded.
if [[ "${my_system_kernel}" != "OpenBSD" ]] ; then
    export LANG="en_GB.UTF-8"
    export LC_ALL="en_GB.UTF-8"
fi
# }}}

# {{{ Gentoo
if [[ -e /etc/gentoo-release ]] ; then
    export ECHANGELOG_USER="${name} <${mail}>"

    alias rc='repoman commit -m'
    alias rs='repoman scan'

    alias unstable="package_to_unstable"

    case "${my_system_arch}" in
        i?86)
            machine_arch=x86
            ;;
        mips*)
            machine_arch=mips
            ;;
        sparc*)
            machine_arch=sparc
            ;;
        x86_64)
            machine_arch=amd64
            ;;
        arm*)
            machine_arch=arm
            ;;
        *)
            machine_arch=${my_system_arch}
            ;;
    esac

    if [[ -z "${system_package_manager}" ]] ; then
        if [[ -f /usr/bin/paludis ]] ; then
            system_package_manager="paludis"
        elif [[ -f /usr/bin/emerge ]] ; then
            system_package_manager="portage"
        else
            system_package_manager="not_gentoo"
        fi
    fi

    package_to_unstable() {
        if [[ -z "${1}" ]] ; then
            echo "need a parameter"
            return 1
        fi

        package_to_unstable_${system_package_manager} "${1}"
    }

    package_to_unstable_paludis() {
        echo "${1} ${machine_arch} ~${machine_arch}" | sudo dd conv=notrunc oflag=append of="/etc/paludis/keywords.conf" &> /dev/null
        return 0
    }

    package_to_unstable_portage() {
        echo "${1} ~${machine_arch}" | sudo conv=notrunc oflag=append of="/etc/portage/package.keywords" &> /dev/null
        return 0
    }

    package_to_unstable_not_gentoo() {
        echo "This is not a Gentoo based system"
        return 1
    }

    if [[ "${system_package_manager}" == "paludis" ]] ; then
        paludis_resume_template="${HOME}/.paludis-resume"

        export PALUDIS_OPTIONS="--show-reasons none --show-use-descriptions none --show-package-descriptions all --resume-command-template ${paludis_resume_template}/XXXXXX"
        alias paludis="sudo paludis"
    fi

    if [[ ${system_package_manager} == "portage" ]] ; then
        alias unstable="ACCEPT_KEYWORDS=\"~${machine_arch}\""
    fi
fi
# }}}

# {{{ OpenBSD
if [[ "${my_system_kernel}" == "OpenBSD" ]] ; then
    export PKG_PATH="ftp://ftp.openbsd.dk/pub/OpenBSD/4.2/packages/${my_system_arch}/"
    alias pkg_add="pkg_add -v"
fi
# }}}

# {{{ Pager (vimpager > most > less)
if [[ -f /usr/bin/less ]] ; then
    export PAGER=less
    export LESS="--ignore-case --long-prompt"
fi

if [[ -f /usr/bin/most ]] ; then
    export PAGER=most
fi

if [[ -f /usr/bin/vimpager ]] ; then
    export PAGER=vimpager
    export MANPAGER=vimmanpager
fi
# }}}

# {{{ Colours
if [[ "${my_system_kernel}" == "Linux" ]] ; then
    if [[ -f /etc/DIR_COLORS ]] ; then
        eval $(dircolors -b /etc/DIR_COLORS)
    fi
fi
# }}}

# {{{ Cores and umask
ulimit -c unlimited
# }}}

# {{{ Variables
export HISTIGNORE="&:exit:logout:cd *:ls"
export EDITOR="vim"
export BROWSER="firefox"
export GIT_AUTHOR_NAME="${name}"
export GIT_COMMITTER_NAME="${GIT_AUTHOR_NAME}"
export GIT_AUTHOR_EMAIL="${mail}"
export LESSCHARSET="UTF-8"
# }}}

# {{{ Aliases
if [[ "${my_system_kernel}" == "Linux" ]] ; then
    alias grep='grep --color=auto'
    alias ls='ls --color=auto'
    alias ll='ls --color -lh'
    alias lv='ls --color -lhA'
    alias l='ls --color -lh'
elif [[ "${my_system_kernel}" == "OpenBSD" ]] ; then
    alias ll='ls -lh'
    alias l='ll'
    alias lv='ls -lhA'
fi

alias screen="screen -U"
alias g='grep'
alias lg='l|g'

if [[ -f /usr/bin/pinfo ]] ; then
    alias info="pinfo"
fi
# }}}

# {{{ Terminal
if [[ "${TERM}" == "xterm" ]] ; then
    export TERM="xterm-256color"
fi
# }}}

# {{{ SELinux
if [[ -z "${!selinux_*}" ]] ; then
    if [[ -f /usr/sbin/selinuxenabled ]] ; then
        if /usr/sbin/selinuxenabled &> /dev/null ; then
            selinux_enabled=true
        else
            selinux_enabled=false
        fi
    fi

    if ${selinux_enabled} ; then
        alias lz="ls --color -lZ"
        alias sestatus="/usr/sbin/sestatus"

        if id -Z &> /dev/null ; then
            selinux_context=$(id -Z)
        elif id -C &> /dev/null ; then
            selinux_context=$(id -C)
        fi

        selinux_role="${selinux_context#*:}"
        selinux_role="${selinux_role%%:*}"
        selinux_id="${selinux_context%%:*}"

        case "${selinux_role}" in
            staff_r)
                alias s="newrole -r sysadm_r"
                SELINUX_PROMPT='\[\033[00;35m\]${selinux_id}\[\033[00;31m\]:\[\033[00;35m\]${selinux_role}\[\033[00;31m\]'
                ;;

            sysadm_r|secadm_r)
                SELINUX_PROMPT='\[\033[00;32m\](\[\033[00;36m\]${USER}\[\033[00;32m\]) \[\033[00;31m\]${selinux_id}\[\033[00;36m\]:\[\033[00;31m\]${selinux_role}\[\033[00;36m\]@\[\033[00;31m\]\h\[\033[01;34m\]'
                ;;
        esac
    fi
fi
# }}}

# {{{ PS1
if [[ ${EUID} == 0 ]] ; then
    PS1='\[\033[00;31m\][\u@\h\[\033[00;33m\] :: \[\033[00;36m\]\w\[\033[38;5;77m\]\[\033[00m\]\[\033[00;31m\]] \[\033[00;33m\]\\$\[\033[00m\] '
else
    PS1='\[\033[00;36m\]\u\[\033[00;32m\]@\[\033[00;36m\]\h\[\033[00;32m\]\[\033[00;33m\] :: \[\033[00;36m\]\w\[\033[38;5;77m\]\[\033[00m\]\[\033[00;32m\] \[\033[00;33m\]\\$\[\033[00m\] '
fi
# }}}

# {{{ Bash completion
for file in ~/.bash_completion.d/* ; do
    clever_source "${file}"
done
# }}}

# {{{ Keychain
[ -z "${HOSTNAME}" ] && HOSTNAME="$(uname -n)"
clever_source ~/.keychain/${HOSTNAME}-sh
# }}}

# vim: set ts=4 et sts=4 foldmethod=marker :
