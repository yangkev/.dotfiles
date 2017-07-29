#!/bin/bash

# Check if GNU stow is installed
which stow > /dev/null 2>&1
STOW_INSTALLED=$?

if [[ "${STOW_INSTALLED}" -ne "0" ]]; then
    echo "stow is NOT installed"
fi

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
    OLD_FILES="$HOME/.old_dotfiles"
    mkdir -p "$OLD_FILES"
    if [[ "${STOW_INSTALLED}" -eq "0" ]]; then
        for SUB_MOD in $(ls -d */)
        do
            TEMP=${SUB_MOD%/}
            echo -en "Install ${TEMP} (y/n)?"
            read USERINPUT
            case $USERINPUT in
                y)
                    FILE=$( stow ${TEMP} 2>&1 >/dev/null | sed -ne 's/^.*directory: //p' )
                    if [[ -n ${FILE} ]]; then
                        echo -ne    "The following files could not be linked because"\
                                    "they are files/directories and already exist.\n"
                        for ITEM in ${FILE}
                        do
                            echo "${ITEM}"
                        done
                        echo -ne "Move existing files to ${OLD_FILES} and install new links (y/n)?"
                        read MOVE_FILES
                        case $MOVE_FILES in
                            y)
                                for ITEM in ${FILE}
                                do
                                    DIR_NAME=$( echo ${ITEM} | sed -ne 's/\/.*$//p' )
                                    if [[ -n ${DIR_NAME} ]]; then
                                        mv "${HOME}/${DIR_NAME}" $OLD_FILES
                                    else
                                        mv "${HOME}/${ITEM}" $OLD_FILES
                                    fi
                                done
                                ;;
                            *)
                                echo "Skipping ${TEMP}$"
                                ;;
                        esac
                    fi
                    ;;
                *)
                    echo "Skipping ${TEMP}"
                    ;;
            esac
        done
        echo "Installation ... complete!"
    else
        echo "dotfiles NOT installed"
    fi
fi









# Stow commands
