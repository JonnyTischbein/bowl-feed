m = Map("Network Overview", translate("Network Overview"))
m.pageaction = false

s = m:section(NamedSection, "__networkoverview__")

function s.render(self, sid)
	local tpl = require "luci.template"
	local json = require "luci.json"
	local utl = require "luci.util"
	tpl.render_string([[
		<ul>
			<%
            		local status = require "luci.tools.ieee80211"
			local utl = require "luci.util"
		        local sys = require "luci.sys"     
		        local hosts = sys.net.host_hints() 
			local stat = utl.ubus("dawn", "get_network", { })
			local name, macs
			for name, macs in pairs(stat) do
			%>
				<li>
					<strong>SSID is: </strong><%= name %><br />
				</li>
				<ul>
				<%
				local mac, data
				for mac, data in pairs(macs) do
				%>
					<li>
						<strong>MAC: </strong><%= mac %><br />
						<strong>Channel Utilization: </strong><%= "%d" %data.channel_utilization %><br />
						<strong>Frequency is: </strong><%= "%.3f" %( data.freq / 1000 ) %> GHz (Channel: <%= "%d" %( status.frequency_to_channel(data.freq) ) %>)<br />
						<strong>Stations: </strong><%= "%d" %data.num_sta %><br />
						<strong>HT Sup: </strong><%= (data.ht_support == true) and "available" or "not available" %><br />
						<strong>VHT Sup: </strong><%= (data.vht_support == true) and "available" or "not available" %><br />  
						<strong>Clients: </strong><br />	
					</li>
                                        <% 					
					local mac2, data2
					for clientmac, clientvals in pairs(data) do
					if (type(clientvals) == "table") then 
					%>
						<ul>
						<li>
						<strong>MAC: </strong><%= clientmac %><br />
						<strong>HT: </strong><%= (clientvals.ht == true) and "available" or "not available" %><br />
						<strong>VHT: </strong><%= (clientvals.vht == true) and "available" or "not available" %><br />
						<strong>Signal is: </strong><%= "%d" %clientvals.signal %><br />
						</li>
						</ul>
					<%
					end
					end
					%>
				<%
				end
				%>
			</ul>
			<%
			end
			%>
		</ul>
	]])
end

return m
