#!/usr/bin/env bash

sudo cp $HOME/.fx/apps/seafile/seaf.service /etc/systemd/system/seaf-cli.service
sudo systemctl daemon-reload
sudo systemctl enable seaf-cli.service
sudo systemctl start seaf-cli.service
sudo systemctl status seaf-cli.service

echo
echo configured
