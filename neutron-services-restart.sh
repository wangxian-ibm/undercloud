#!/bin/bash
linuxbridge_restart() {
        echo restart neutron linux bridge agent  $1
        ssh $1 bash -c "'
service neutron-linuxbridge-agent restart
        '"
}

neutron_services_restart(){
        echo restart neutron services $1
        ssh $1 bash -c "'
service neutron-linuxbridge-agent restart
service neutron-l3-agent restart
service neutron-lbaasv2-agent restart
service neutron-metadata-agent restart
service neutron-dhcp-agent restart
        '"
}


for i in `seq 1 2`;
do
    linuxbridge_restart compute$i
done


for i in `seq 1 2`;
do
    neutron_services_restart controller$i
done

