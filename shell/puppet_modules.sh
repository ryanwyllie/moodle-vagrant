#!/bin/sh

PUPPET_DIR='/etc/puppet/modules'
MODULE_LIST='/vagrant/puppet_modules'

if [ ! -d "$PUPPET_DIR" ]; then
  echo "Creating $PUPPET_DIR"
  mkdir -p $PUPPET_DIR
else
  echo "$PUPPET_DIR exists."
fi

while read module_name; do
  if [ "$(puppet module list | grep $module_name | wc -l)" -gt 0 ]; then
    echo "${module_name} exists. Ignoring."
  else
    echo "Installing ${module_name}"
    puppet module install $module_name
    echo "Installed!"
  fi
done < $MODULE_LIST

