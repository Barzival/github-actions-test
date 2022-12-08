#!/usr/bin/env bash
go env -w GOPRIVATE="${GOPRIVATE}"
git config --global url.ssh://git@github.com/.insteadof https://github.com/
mkdir -p ~/.ssh
touch ~/.ssh/id_ed25519
echo "${ED25519_KEY}" > ~/.ssh/id_ed25519
chmod 600 ~/.ssh/id_ed25519
ssh-keygen -y -f ~/.ssh/id_ed25519 > ~/.ssh/id_ed25519.pub
ssh-keyscan github.com >> ~/.ssh/known_hosts
cat ~/.ssh/id_ed25519.pub