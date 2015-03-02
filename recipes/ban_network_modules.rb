# 
# Bans specific kernel modules
#

node['udev']['banned_modules'].each do |mdl|
	file "/etc/modprobe.d/blacklist-#{mdl}.conf" do
		content "blacklist #{mdl}"
		notifies :run, "execute[update-initramfs -u]"
	end
	execute "rmmod #{mdl}" do
		returns [0,1]
	end
end

execute "update-initramfs -u" do
	action :nothing
end
