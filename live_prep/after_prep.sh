#Make the direcotry for the iso loop mount
mkdir ~/tmp/live_iso

#Mount the iso into /media/live_iso
mount -o loop ~/tmp/remaster-new-files/livecd.iso ~/tmp/live_iso

#Create temp directory for final iso files to work with
mkdir ~/tmp/final_iso_files

#Copy all mounted iso files into final_iso_files so they will be read/write
cp -a ~/tmp/live_iso/* ~/tmp/final_iso_files/

#Copy the new txt.cfg menu to replace the existing one into the new iso directory
cp isolinux/txt.cfg ~/tmp/final_iso_files/isolinux

#Make the new iso from
mkisofs -R -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o ~/tmp/compensato.iso ~/tmp/final_iso_files