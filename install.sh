#!/bin/bash

# Check if GNU stow is installed
dpkg -s stow > /dev/null 2>&1
STOW_INSTALLED=$?

# Uninstall
if [[ $1 = "-u" ]] || [[ $1 = "--uninstall" ]]; then
    if [[ "${STOW_INSTALLED}" -ne "0" ]]; then
        echo "You're SOL. Gonna have to remove the symlinks by hand"
    else
        for SUB_MOD in $(ls -d */)
        do
            TEMP=${SUB_MOD%/}
            ( stow -D ${TEMP} > /dev/null 2>&1 )
            RM_STATUS=$?
            if [[ "${RM_STATUS}" -ne "0" ]]; then
                echo "Failed to remove ... ${TEMP}"
            fi
        done
    fi
# Help
elif [[ $1 = "-h" ]] || [[ $1 = "--help" ]]; then
    echo -e "Description: Adds symlinks for all submodules in the ~/.dotfiles directory"
    echo -e "Options:"
    echo -e "-h, --help\tDisplay this help menu"
    echo -e "-u, --uninstall\tRemove symlinks from $HOME"
# Install
else
    if [[ "${STOW_INSTALLED}" -eq "0" ]]; then
        for SUB_MOD in $(ls -d */)
        do
            TEMP=${SUB_MOD%/}
            echo -en "Install ${TEMP} (y/n)?"
            read USERINPUT
            case $USERINPUT in
                y)
                    ( stow -R ${TEMP} )
                    ;;
                *)
                    echo "Skipping ${TEMP}"
                    ;;
            esac
        done
    fi
fi









# Stow commands
