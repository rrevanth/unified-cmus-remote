local kb = require("keyboard");
local mutedvol = 0;

function updateInfo()
	cmd = "cmus-remote -Q | sed -n 2p | rev | cut -d/ -f1 | rev"

	local pout = "";
	local presult = 0;
	local perr = "";
	
	local success, ex = pcall(function ()
		pout,perr,presult = libs.script.shell(cmd);
	end);

	libs.server.update(
		{ id = "title", text = pout }
	);
end 

--@help Toggle play/pause
actions.play_pause = function ()
	cmd = "cmus-remote -u"

	local pout = "";
	local presult = 0;
	local perr = "";
	
	local success, ex = pcall(function ()
		pout,perr,presult = libs.script.shell(cmd);
	end);
	updateInfo();
end

--@help Lower system volume
actions.volume_down = function()
	kb.press("volumedown");
end

--@help Raise system volume
actions.volume_up = function()
	kb.press("volumeup");
end

--@help Raise volume
actions.volume_up = function ()
	cmd = "cmus-remote -v +5%"

	local pout = "";
	local presult = 0;
	local perr = "";
	
	local success, ex = pcall(function ()
		pout,perr,presult = libs.script.shell(cmd);
	end);
end

--@help Lower volume
actions.volume_down = function ()
	cmd = "cmus-remote -v -5%"

	local pout = "";
	local presult = 0;
	local perr = "";
	
	local success, ex = pcall(function ()
		pout,perr,presult = libs.script.shell(cmd);
	end);
end

--@help Mute volume
actions.volume_mute = function ()
	cmd = "cmus-remote -Q | sed -n 16p | rev | cut -d ' ' -f1 | rev"

	local pout = "";
	local presult = 0;
	local perr = "";
	
	local success, ex = pcall(function ()
		pout,perr,presult = libs.script.shell(cmd);
	end);

	local current = tonumber(pout);

	if(current ~= 0) then
		mutedvol = current;
		cmd = "cmus-remote -v 0";
	else
		cmd = "cmus-remote -v " .. mutedvol .. "%";
	end

	pout = "";
	presult = 0;
	perr = "";

	local success, ex = pcall(function ()
		pout,perr,presult = libs.script.shell(cmd);
	end);
end

--@help Next playlist item
actions.next = function ()
	cmd = "cmus-remote -n"

	local pout = "";
	local presult = 0;
	local perr = "";
	
	local success, ex = pcall(function ()
		pout,perr,presult = libs.script.shell(cmd);
	end);
	updateInfo();
end

--@help Previous playlist item
actions.previous = function ()
	cmd = "cmus-remote -r"

	local pout = "";
	local presult = 0;
	local perr = "";
	
	local success, ex = pcall(function ()
		pout,perr,presult = libs.script.shell(cmd);
	end);
	updateInfo();
end

--@help Stop playback
actions.stop = function ()
	cmd = "cmus-remote -s"

	local pout = "";
	local presult = 0;
	local perr = "";
	
	local success, ex = pcall(function ()
		pout,perr,presult = libs.script.shell(cmd);
	end);
	updateInfo();
end

--@help Jump back 10 seconds
actions.jump_back = function ()
	cmd = "cmus-remote -k -10"

	local pout = "";
	local presult = 0;
	local perr = "";
	
	local success, ex = pcall(function ()
		pout,perr,presult = libs.script.shell(cmd);
	end);
end

--@help Jump forward 10 seconds
actions.jump_forward = function ()
	cmd = "cmus-remote -k +10"

	local pout = "";
	local presult = 0;
	local perr = "";
	
	local success, ex = pcall(function ()
		pout,perr,presult = libs.script.shell(cmd);
	end);
end

--@help Toggle repeat
actions.loop_repeat = function ()
	cmd = "cmus-remote -R"

	local pout = "";
	local presult = 0;
	local perr = "";
	
	local success, ex = pcall(function ()
		pout,perr,presult = libs.script.shell(cmd);
	end);

	cmd = "cmus-remote -C 'set repeat?'"

	pout = "";
	presult = 0;
	perr = "";
	
	local success, ex = pcall(function ()
		pout,perr,presult = libs.script.shell(cmd);
	end);

	libs.device.toast(pout);
end

--@help Toggle shuffle
actions.shuffle = function ()
	cmd = "cmus-remote -S"

	local pout = "";
	local presult = 0;
	local perr = "";
	
	local success, ex = pcall(function ()
		pout,perr,presult = libs.script.shell(cmd);
	end);

	cmd = "cmus-remote -C 'set shuffle?'"

	pout = "";
	presult = 0;
	perr = "";
	
	local success, ex = pcall(function ()
		pout,perr,presult = libs.script.shell(cmd);
	end);

	libs.device.toast(pout);
end

--@help Toggle shuffle
actions.current_repeat = function ()
	cmd = "cmus-remote -C 'toggle repeat_current'"

	local pout = "";
	local presult = 0;
	local perr = "";
	
	local success, ex = pcall(function ()
		pout,perr,presult = libs.script.shell(cmd);
	end);

	cmd = "cmus-remote -C 'set repeat_current?'"

	pout = "";
	presult = 0;
	perr = "";
	
	local success, ex = pcall(function ()
		pout,perr,presult = libs.script.shell(cmd);
	end);

	libs.device.toast(pout);
end

--@help Start cmus in background
actions.start_cmus = function ()
	cmd = "screen -dmS cmus /usr/bin/cmus"

	local pout = "";
	local presult = 0;
	local perr = "";
	
	local success, ex = pcall(function ()
		pout,perr,presult = libs.script.shell(cmd);
	end);
end

--@help Exit Cmus
actions.stop_cmus = function ()
	cmd = "screen -X -S cmus quit"

	local pout = "";
	local presult = 0;
	local perr = "";
	
	local success, ex = pcall(function ()
		pout,perr,presult = libs.script.shell(cmd);
	end);
end