#!/bin/bash

#========================================================
#   System Required: macOS 10.13+
#   Description: Nezha Agent Install Script (macOS)
#   Github: https://github.com/naiba/nezha
#========================================================

NZ_BASE_PATH="/opt/nezha"
NZ_AGENT_PATH="${NZ_BASE_PATH}/agent"

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'
export PATH=$PATH:/usr/local/bin

pre_check() {
    # Check root
    [[ $EUID -ne 0 ]] && echo -e "${red}ERROR:${plain} This script must be run with the root user!\n" && exit 1

    # Determine architecture
    if [[ $(uname -m | grep 'x86_64') != "" ]]; then
        os_arch="amd64"
    elif [[ $(uname -m | grep 'arm64\|arm64e') != "" ]]; then
        os_arch="arm64"
    else
        echo -e "${red}ERROR:${plain} Unsupported architecture!" && exit 1
    fi

    # Detect China IP
    if [[ -z "${CN}" ]]; then
        if [[ $(curl -m 10 -s http://ip-api.com/json | grep 'country' | grep -q 'China') != "" ]]; then
            CN=true
        fi
    fi

    if [[ -n "${CN}" ]]; then
        GITHUB_RAW_URL="gitee.com/naibahq/nezha/raw/v0"
        GITHUB_URL="gitee.com"
    else
        GITHUB_RAW_URL="raw.githubusercontent.com/naiba/nezha/v0"
        GITHUB_URL="github.com"
    fi
}

install_agent() {
    echo -e "> Installing Nezha Agent"

    # Fixed version
    local version="v0.20.5"
    echo -e "Installing fixed agent version: ${version}"

    # Create agent directory
    mkdir -p "$NZ_AGENT_PATH"
    chmod -R 777 "$NZ_AGENT_PATH"

    echo -e "Downloading agent..."
    local temp_zip="nezha-agent_darwin_${os_arch}.zip"
    [[ -f "$temp_zip" ]] && rm -f "$temp_zip"

    if [[ -z $CN ]]; then
        NZ_AGENT_URL="https://${GITHUB_URL}/nezhahq/agent/releases/download/${version}/nezha-agent_darwin_${os_arch}.zip"
    else
        NZ_AGENT_URL="https://${GITHUB_URL}/naibahq/agent/releases/download/${version}/nezha-agent_darwin_${os_arch}.zip"
    fi

    curl -o "$temp_zip" -L -f --retry 2 --retry-max-time 60 "$NZ_AGENT_URL"
    if [[ $? != 0 ]]; then
        echo -e "${red}Failed to download agent. Check network connectivity.${plain}"
        return 1
    fi

    unzip -qo "$temp_zip" &&
        mv -f nezha-agent "$NZ_AGENT_PATH" &&
        rm -f "$temp_zip"

    [[ $? != 0 ]] && echo -e "${red}Error occurred during extraction.${plain}" && return 1

    modify_agent_config "$@"
}

modify_agent_config() {
    echo -e "> Modifying agent configuration"

    if [[ $# -lt 3 ]]; then
        echo "Please add Agent in the admin panel first, then input its secret."
        read -ep "Domain resolving to the IP of the panel (no CDN): " nz_grpc_host
        read -ep "Panel RPC port (default 5555): " nz_grpc_port
        read -ep "Agent secret: " nz_client_secret
        read -ep "Enable SSL/TLS (--tls)? [y/N]: " nz_grpc_proxy

        [[ -z "$nz_grpc_port" ]] && nz_grpc_port=5555
        grep -qiw 'Y' <<<"${nz_grpc_proxy}" && args="--tls"

        [[ -z "$nz_grpc_host" || -z "$nz_client_secret" ]] && echo -e "${red}All fields are required.${plain}" && return 1
    else
        nz_grpc_host=$1
        nz_grpc_port=$2
        nz_client_secret=$3
        shift 3
        [[ $# -gt 0 ]] && args="$*"
    fi

    ${NZ_AGENT_PATH}/nezha-agent service install -s "$nz_grpc_host:$nz_grpc_port" -p "$nz_client_secret" $args >/dev/null 2>&1
}

uninstall_agent() {
    echo -e "> Uninstalling Nezha Agent"

    local agent_pid=$(pgrep -f nezha-agent)
    if [[ -n "$agent_pid" ]]; then
        echo -e "Stopping running process with PID: $agent_pid..."
        kill -9 "$agent_pid" >/dev/null 2>&1
    fi

    ${NZ_AGENT_PATH}/nezha-agent service uninstall >/dev/null 2>&1 || echo -e "${yellow}No service found to uninstall.${plain}"

    rm -rf "$NZ_AGENT_PATH"
    [[ -z "$(ls -A $NZ_BASE_PATH)" ]] && rm -rf "$NZ_BASE_PATH"

    echo -e "${green}Uninstallation completed.${plain}"
}

pre_check

case $1 in
    "install_agent") shift; install_agent "$@" ;;
    "uninstall_agent") uninstall_agent ;;
    *) echo -e "Usage: ./nezha.command install_agent <host> <port> <secret>" ;;
esac
