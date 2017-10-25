#!/bin/bash
active_workspace=$(i3-msg -t get_workspaces | jq '.[] | select(.focused).num')
echo $active_workspace
