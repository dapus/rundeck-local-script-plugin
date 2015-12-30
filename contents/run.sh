#!/bin/bash

if [ -z "$HOME" ]; then
  export HOME=~
fi

if [ -z "$RD_CONFIG_INTERPRETER" ]; then
  RD_CONFIG_INTERPRETER=/bin/bash
fi

script=$(tempfile -d $RD_PLUGIN_TMPDIR)

echo "$RD_CONFIG_SCRIPT" > $script

unset RD_CONFIG_SCRIPT

$RD_CONFIG_INTERPRETER $script

