class DashboardController < ApplicationController
  def commands
    user_level = params[:user_level]
    all = params[:all]
    @channel = params[:channel]
    case user_level
      when 'all'
        getCommands(%w(DEFAULT SUBSCRIBER REGULAR MODERATOR SUPER-MODERATOR BROADCASTER))
      when 'usr'
        getCommands('DEFAULT')
      when 'sub'
        if !all.nil? && all == 'all'
          getCommands(%w(SUBSCRIBER DEFAULT))
        else
        getCommands(%w(SUBSCRIBER))
        end
      when 'reg'
        if !all.nil? && all == 'all'
          getCommands(%w(REGULAR SUBSCRIBER DEFAULT))
        else
        getCommands('REGULAR')
        end
      when 'mod'
        if !all.nil? && all == 'all'
          getCommands(%w(MODERATOR REGULAR SUBSCRIBER DEFAULT))
        else
        getCommands('MODERATOR')
        end
      when 'smd'
        if !all.nil? && all == 'all'
          getCommands(%w(SUPER-MODERATOR MODERATOR REGULAR SUBSCRIBER DEFAULT))
        else
        getCommands('SUPER-MODERATOR')
        end
      when 'own'
        if !all.nil? && all == 'all'
          getCommands(%w(BROADCASTER SUPER-MODERATOR MODERATOR REGULAR SUBSCRIBER DEFAULT))
        else
        getCommands('BROADCASTER')
        end
      else
    end
  end

  def getCommands(user_level)

    ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: "~/.otbproject/data/channels/#{@channel}/main.db"
    @command = Command.where(execUserLevel: user_level)
    @command.to_a.sort!
    #Command.where(execUserLevel: user_level)
    #Account.create
    #@account = Account.all
  end
end