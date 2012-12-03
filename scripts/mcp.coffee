# Description:
#   Manage and launch instances with the help of MCP
#
# Dependencies:
#   Needs MCP installed on the system
#
# Configuration:
#   Right now MCP does not support system wide installation, so path to
#   MCP must be set correct
#   MCP must be rewritten to have an option where it doesn't ask for input
#
# Commands:
#   hubot mcp - List commands to use
#   hubot mcp <command> - Instruct MCP to run <command>
#
# Author:
#   Magine AB

processOutput = (stdout, msg) ->
  msg.send stdout

callMCP = (command, msg) ->
  exec  = require("child_process").exec
  exec "/opt/tvoli/mcp #{command}", (err, stdout, stderr) ->
    if err?
      msg.send "Problems issuing your command #{command}"
    else
      try
        processOutput(stdout, msg)
      catch error
        msg.send "Problems issuing your command #{command}. Hubot had an exception."

module.exports = (robot) ->
  robot.respond /mcp\W*$/i, (msg) ->
    command = 'help'
    callMCP(command, msg)

  robot.respond /mcp\W(.+)/i, (msg) ->
    command = msg.match[1]
    callMCP(command, msg)



