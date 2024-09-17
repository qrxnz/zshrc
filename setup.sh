#!/bin/env bash

mkdir -p ~/.config/zshrc

cp ./zshrc ~/.config/zshrc/ && cp -r ./zsh ~/.config/zshrc/

echo "source ~/.config/zshrc/zshrc" > ~/.zshrc


