#!/usr/bin/env bash
# shellcheck disable=SC2120
NODE_MODULES=(
    deoptigate
    fx
    grasp
    ipt
    jay
    jscpd
    lumo-cljs
    nodemon
    now
    npmrc
    npm-run-all
    npm-check-updates
    nrm
    nsp
    ntl
    nve
    plato
    release
    snyk
    stacks-cli
    stmux
    surge
    thanks
    tldr
)
VSCODE_EXTENSIONS=(
    ms-vscode.atom-keybindings
    formulahendry.auto-rename-tag
    jetmartin.bats
    shan.code-settings-sync
    wmaurer.change-case
    bierner.color-info
    bierner.lit-html
    deerawan.vscode-faker
    ms-dotnettools.csharp
    GrapeCity.gc-excelviewer
    wix.glean
    icsharpcode.ilspy-vscode
    sirtori.indenticator
    Ionide.Ionide-FAKE
    Ionide.Ionide-fsharp
    Ionide.Ionide-Paket
    silvenon.mdx
    techer.open-in-browser
    christian-kohler.path-intellisense
    ms-vscode.powershell
    2gua.rainbow-brackets
    mechatroner.rainbow-csv
    freebroccolo.reasonml
    ms-vscode-remote.remote-containers
    ms-vscode-remote.remote-ssh
    ms-vscode-remote.remote-ssh-edit
    ms-vscode-remote.remote-wsl
    rafamel.subtle-brackets
    softwaredotcom.swdc-vscode
    tabnine.tabnine-vscode
    marcostazi.VS-code-vagrantfile
    visualstudioexptteam.vscodeintellicode
    ms-azuretools.vscode-docker
    emmanuelbeziat.vscode-great-icons
    kisstkondoros.vscode-gutter-preview
    wix.vscode-import-cost
    akamud.vscode-javascript-snippet-pack
    johnpapa.vscode-peacock
    cssho.vscode-svgviewer
    akamud.vscode-javascript-snippet-pack
    akamud.vscode-theme-onedark
)
install_nix() {
    log "Installing Nix"
    mkdir /etc/nix; echo 'use-sqlite-wal = false' | sudo tee -a /etc/nix/nix.conf && sh <(curl https://nixos.org/releases/nix/nix-2.1.3/install) 
    if [ -f "${HOME}/.zshrc" ]; then
        echo "source ${HOME}/.nix-profile/etc/profile.d/nix.sh" >> ${HOME}/.zshrc
    fi
}
log() {
    TIMEZONE=Central
    MAXLEN=60
    MSG=$1
    for i in $(seq ${#MSG} $MAXLEN)
    do
        MSG=$MSG.
    done
    MSG=$MSG$(TZ=":US/$TIMEZONE" date +%T)
    echo "$MSG"
}