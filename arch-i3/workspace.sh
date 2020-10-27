#!/bin/bash
array=$(i3-msg -t get_workspaces | jq '.[] | select(.visible==false).num')
echo $array
