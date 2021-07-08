<<<<<<< HEAD
#!/bin/bash
set -eou pipefail
set -x

getDiskIDs(){

	checkDiskById() {
		read -r NAME
	        errchk="$(find /dev/disk/by-id -maxdepth 1 -mindepth 1 -name "$NAME")"
        	if [ -z "$errchk" ]; then
                	echo "Disk ID not found. Exiting."
                	exit 1
        	fi
		echo $NAME
	}

	##Get root Disk UUID
	ls -la /dev/disk/by-id
	echo "Enter Disk ID for EFI:"
	DISKID_EFI=$(checkDiskById)
	ls -la /dev/disk/by-id
	echo "Enter Disk ID for ZFS (1 of 2):"
	DISKID_ZFS1=$(checkDiskById)
	ls -la /dev/disk/by-id
	echo "Enter Disk ID for ZFS (2 of 2):"
	DISKID_ZFS2=$(checkDiskById)

	cat <<-EOF
 	DISKID_EFI=$DISKID_EFI
 	DISKID_ZFS1=$DISKID_ZFS1
 	DISKID_ZFS2=$DISKID_ZFS2
 	Please confirm with enter or break with ctrl-c"
	EOF

	if [ "$DISKID_EFI" = "$DISKID_ZFS1" ]; then
		echo "ERROR: disk ids are not all unique!";
		exit 1
	fi
	if [ "$DISKID_EFI" = "$DISKID_ZFS2" ]; then
		echo "ERROR: disk ids are not all unique!";
		exit 1
	fi
	if [ "$DISKID_ZFS1" = "$DISKID_ZFS2" ]; then
		echo "ERROR: disk ids are not all unique!"
		exit 1
	fi
}

getDiskIDs
#cat <<-EOF
#  DISKID_EFI=$DISKID_EFI
#  DISKID_ZFS1=$DISKID_ZFS1
#  DISKID_ZFS2=$DISKID_ZFS2
#  Please confirm with enter or break with ctrl-c"
#EOF
#read -r _

