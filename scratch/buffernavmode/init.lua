local cmd  = vim.api.nvim_command
local eval = vim.api.nvim_eval
local fn   = vim.api.nvim_call_function

local function _cmd_wrap(command)
	return function() cmd(command) end
end


function _bufferNavFunc()
  print("HERE")
	local userInput = vim.api.nvim_get_var('modebuffernavModeInput')
    if userInput == 'j' then
		api.nvim_command('wincmd k')
    elseif userInput == 'k' then
		api.nvim_command('wincmd j')
    elseif userInput == 'h' then
		api.nvim_command('wincmd h')
    elseif userInput == 'l' then
		api.nvim_command('wincmd l')
    else
      libmodal.utils.api.mode_exit()
    end
end
      


-- libmodal buffer navigation
local _BUFFER_NAV_MODE_COMBOS = {
  ['j'] = vim.cmd([[
  wincmd k
  echo 'j command?'
  ]]),
  ['k'] = vim.cmd('wincmd j'),
  ['h'] = vim.cmd('wincmd h'),
  ['l'] = vim.cmd('wincmd l'),
}

function buffernavemode()
  print("HERE1")
	require('libmodal').mode.enter('modeBufferNav', _bufferNavFunc)
end
