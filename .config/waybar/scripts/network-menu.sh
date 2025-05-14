#!/usr/bin/env bash

# Ensure nmcli and wofi are installed
if ! command -v nmcli &> /dev/null || ! command -v wofi &> /dev/null; then
    echo "Error: nmcli and/or wofi not found. Please install them." >&2
    notify-send "Network Menu Error" "nmcli and/or wofi not found."
    exit 1
fi

# Wofi configuration (optional, customize as needed)
WOFI_PARAMS="--dmenu --insensitive --prompt Network --width 500 --lines 15 --style $HOME/.config/wofi/style.css --conf $HOME/.config/wofi/config"
# WOFI_PARAMS="--dmenu --insensitive --prompt Network --width 500 --lines 15" # Simpler alternative

show_notification() {
    # Title, Message, Icon (optional)
    notify-send "Network Menu" "$1" -i "$2"
}

# Get current active Wi-Fi SSID
active_ssid=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes:' | cut -d':' -f2)

# Get current active VPN connection names
mapfile -t active_vpns < <(nmcli -t -f NAME,TYPE con show --active | grep ':vpn$' | sed 's/:vpn$//')

# --- Build Menu Options ---
options=""

# 1. Wi-Fi Networks
# Rescan first, but don't wait too long or show errors if it fails quickly
nmcli dev wifi rescan &> /dev/null &
# Give a moment for rescan to populate, but don't block script for too long
# sleep 0.5 # Optional: uncomment if list seems stale

wifi_list=$(nmcli -t -f SSID,BARS,SECURITY,ACTIVE dev wifi list --rescan no)
# --rescan no here because we triggered one above. Use 'yes' if you remove the background rescan.

while IFS= read -r line; do
    ssid=$(echo "$line" | cut -d':' -f1)
    bars=$(echo "$line" | cut -d':' -f2)
    security=$(echo "$line" | cut -d':' -f3)
    is_active=$(echo "$line" | cut -d':' -f4)

    if [ -z "$ssid" ]; then
        continue
    fi

    # Mark active SSID
    prefix="[WIFI]"
    suffix=""
    if [ "$is_active" == "yes" ] || [ "$ssid" == "$active_ssid" ]; then
        suffix=" [*]"
    fi

    # Security indicator
    sec_indicator=""
    if [ -n "$security" ] && [ "$security" != "--" ] && [ "$security" != "open" ]; then
        sec_indicator=" 🔒"
    fi
    options+="${prefix} ${ssid} (${bars})${sec_indicator}${suffix}\n"
done <<< "$wifi_list"


# 2. Configured VPN Connections
vpn_configs=$(nmcli -t -f NAME,TYPE connection show | grep ':vpn$' | sed 's/:vpn$//')
while IFS= read -r vpn_name; do
    if [ -z "$vpn_name" ]; then
        continue
    fi
    prefix="[VPN]"
    suffix=""
    for active_vpn in "${active_vpns[@]}"; do
        if [ "$vpn_name" == "$active_vpn" ]; then
            suffix=" [*]"
            break
        fi
    done
    options+="${prefix} ${vpn_name}${suffix}\n"
done <<< "$vpn_configs"

# 3. Actions
options+="[ACTN] Rescan Wi-Fi\n"

wifi_radio_status=$(nmcli radio wifi)
if [ "$wifi_radio_status" == "enabled" ]; then
    options+="[ACTN] Disable Wi-Fi Radio\n"
else
    options+="[ACTN] Enable Wi-Fi Radio\n"
fi

# Option to disconnect current Wi-Fi if connected
if [ -n "$active_ssid" ]; then
    options+="[ACTN] Disconnect Wi-Fi ($active_ssid)\n"
fi

networking_status=$(nmcli networking)
if [[ "$networking_status" == "enabled" ]]; then
    options+="[ACTN] Disable All Networking\n"
else
    options+="[ACTN] Enable All Networking\n"
fi


# --- Show Wofi Menu ---
# Remove trailing newline for wofi
chosen_option=$(echo -e "${options%\\n}" | wofi $WOFI_PARAMS)

# --- Handle Selection ---
if [ -z "$chosen_option" ]; then
    echo "No option selected."
    exit 0
fi

type=$(echo "$chosen_option" | awk '{print $1}')
name_and_details=$(echo "$chosen_option" | sed 's/^\[[^]]*\] //') # Remove [TYPE] prefix

case "$type" in
    "[WIFI]")
        ssid=$(echo "$name_and_details" | sed -E 's/ \([^)]+\)(🔒)?( \[\*\])?$//') # Extract SSID
        is_active=$(echo "$name_and_details" | grep -q '[*]' && echo "yes" || echo "no")
        is_secure=$(echo "$name_and_details" | grep -q '🔒' && echo "yes" || echo "no")

        if [ "$is_active" == "yes" ]; then
            show_notification "Already connected to $ssid." "network-wireless-acquiring"
            exit 0
        fi

        # Check if connection profile exists
        if nmcli con show "$ssid" &>/dev/null; then
            show_notification "Connecting to $ssid..." "network-wireless-acquiring"
            if nmcli con up id "$ssid"; then
                show_notification "Connected to $ssid." "network-wireless-linked"
            else
                show_notification "Failed to connect to $ssid." "network-wireless-disconnected"
            fi
        elif [ "$is_secure" == "yes" ]; then
            password=$(wofi $WOFI_PARAMS --password --prompt "Password for ${ssid}:")
            if [ -n "$password" ]; then
                show_notification "Connecting to $ssid..." "network-wireless-acquiring"
                if nmcli dev wifi connect "$ssid" password "$password"; then
                    show_notification "Connected to $ssid." "network-wireless-linked"
                else
                    show_notification "Failed to connect to $ssid (check password)." "network-wireless-disconnected"
                fi
            else
                show_notification "Connection to $ssid cancelled (no password)." "dialog-cancel"
            fi
        else # Open network
            show_notification "Connecting to $ssid..." "network-wireless-acquiring"
            if nmcli dev wifi connect "$ssid"; then
                show_notification "Connected to $ssid." "network-wireless-linked"
            else
                show_notification "Failed to connect to $ssid." "network-wireless-disconnected"
            fi
        fi
        ;;

    "[VPN]")
        vpn_name=$(echo "$name_and_details" | sed 's/ \[\*\]$//') # Extract VPN name
        is_active="no"
        for active_vpn in "${active_vpns[@]}"; do
            if [ "$vpn_name" == "$active_vpn" ]; then
                is_active="yes"
                break
            fi
        done

        if [ "$is_active" == "yes" ]; then
            show_notification "Disconnecting from $vpn_name..." "network-vpn-acquiring"
            if nmcli con down id "$vpn_name"; then
                show_notification "Disconnected from $vpn_name." "network-vpn-offline"
            else
                show_notification "Failed to disconnect $vpn_name." "network-vpn-error"
            fi
        else
            show_notification "Connecting to $vpn_name..." "network-vpn-acquiring"
            if nmcli con up id "$vpn_name"; then
                show_notification "Connected to $vpn_name." "network-vpn"
            else
                show_notification "Failed to connect to $vpn_name." "network-vpn-error"
            fi
        fi
        ;;

    "[ACTN]")
        action="$name_and_details"
        case "$action" in
            "Rescan Wi-Fi")
                show_notification "Initiating Wi-Fi rescan..." "view-refresh"
                nmcli dev wifi rescan
                show_notification "Wi-Fi rescan complete." "view-refresh"
                # Optionally, re-run the script to show updated list immediately
                # exec "$0"
                ;;
            "Disable Wi-Fi Radio")
                show_notification "Disabling Wi-Fi radio..." "network-wireless-offline"
                nmcli radio wifi off
                show_notification "Wi-Fi radio disabled." "network-wireless-disabled"
                ;;
            "Enable Wi-Fi Radio")
                show_notification "Enabling Wi-Fi radio..." "network-wireless-acquiring"
                nmcli radio wifi on
                show_notification "Wi-Fi radio enabled." "network-wireless-enabled"
                ;;
            "Disable All Networking")
                show_notification "Disabling all networking..." "network-offline"
                nmcli networking off
                show_notification "All networking disabled." "network-error"
                ;;
            "Enable All Networking")
                show_notification "Enabling all networking..." "network-idle"
                nmcli networking on
                show_notification "All networking enabled." "network-transmit-receive"
                ;;
            "Disconnect Wi-Fi ("*)") # Matches "Disconnect Wi-Fi (SSID_NAME)"
                current_wifi_to_disconnect=$(echo "$action" | sed -n 's/Disconnect Wi-Fi (\(.*\))/\1/p')
                if [ -n "$current_wifi_to_disconnect" ]; then
                    # Find the connection name (UUID or ID) for the active SSID
                    # This is more robust than just using SSID if multiple profiles exist for one SSID
                    active_con_name=$(nmcli -t -f NAME,DEVICE,ACTIVE,SSID con show --active | grep "yes:$current_wifi_to_disconnect" | head -n1 | cut -d':' -f1)
                    if [ -n "$active_con_name" ]; then
                        show_notification "Disconnecting from $current_wifi_to_disconnect..." "network-wireless-disconnected"
                        if nmcli con down id "$active_con_name"; then
                            show_notification "Disconnected from $current_wifi_to_disconnect." "network-wireless-offline"
                        else
                            show_notification "Failed to disconnect from $current_wifi_to_disconnect." "network-wireless-error"
                        fi
                    else
                        show_notification "Could not find active connection for $current_wifi_to_disconnect." "dialog-warning"
                    fi
                else
                    show_notification "Could not determine Wi-Fi to disconnect." "dialog-error"
                fi
                ;;

        esac
        ;;
    *)
        echo "Unknown option: $chosen_option"
        ;;
esac

exit 0
