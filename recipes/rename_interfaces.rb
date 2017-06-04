#
# Forces common ethXX names for exotic interfaces
#
# Ignores specific MAC prefixes, like 00:25:90

ruby_block "rename interfaces" do
	block do
		eth_num = 0
		node['network']['interfaces'].each do |int,data|
			data['addresses'].each do |addr,addr_info|
				if addr_info['family'] == 'lladdr' and ! node['udev']['banned_macs'].any? { |mac| addr.start_with? (mac) }
					Chef::Log.debug("Found valid MAC #{addr} saving as eth#{eth_num}")
					node.default['udev']['net']["eth#{eth_num}"] = addr
					eth_num = eth_num+1
				end
			end
		end
	end
end
