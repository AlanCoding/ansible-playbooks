#!/bin/bash

export ANSIBLE_NOCOWS=1

# names='context_demo full_skip log_plays nrdp say	sumologic
# counter_enabled	grafana_annotations	logdna null 	selective syslog_json
# actionable debug hipchat logentries oneline skippy timer
# aws_resource_actions	default jabber logstash osx_say slack tree
# cgroup_memory_recap	dense json 	mail 	profile_roles	splunk unixy
# cgroup_perf_recap	foreman junit minimal profile_tasks	stderr yaml'

# the stdout callback plugins
names='stderr skippy counter_enabled actionable dense null selective default yaml unixy debug full_skip minimal json oneline'
for name in $names
do
  echo ""
  echo $name
  ANSIBLE_STDOUT_CALLBACK=$name ansible-playbook -i inventories/inventory.ini --connection=local chatty_tasks.yml > outputs/$name
done

echo ""
echo ""
echo "--- stdout applied to adhoc ---"

for name in $names
do
  echo ""
  echo $name
  ANSIBLE_STDOUT_CALLBACK=$name ansible -i inventories/inventory.ini -m ping all --connection=local > outputs_adhoc/$name
done


echo ""
echo ""
echo "--- Aggregate callbacks ---"

# aggregate
names='profile_roles tree profile_tasks syslog_json context_demo logdna aws_resource_actions cgroup_perf_recap timer logstash sumologic junit grafana_annotations cgroup_memory_recap splunk'
for name in $names
do
  echo ""
  echo $name
  ANSIBLE_CALLBACK_WHITELIST=$name ansible-playbook -i inventories/inventory.ini --connection=local chatty_tasks.yml > outputs2/$name
done

echo "All done"

# bugs
# ANSIBLE_STDOUT_CALLBACK=syslog_json ansible-playbook -i inventories/inventory.ini --connection=local chatty_tasks.yml -vvv
# ANSIBLE_STDOUT_CALLBACK=dense ansible-playbook -i inventories/inventory.ini --connection=local chatty_tasks.yml -vvv
