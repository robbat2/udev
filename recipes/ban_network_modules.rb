# 
# Bans specific network modules
#
node[:udev][:banned_modules].each do |module|
	file "/etc/modprobe.d/#{module}"
		content "blacklist #{module}"
	end
end
