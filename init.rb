# frozen_string_literal: true
Dir.glob('./{config,lib,models,controllers,services,values,representers}/init.rb').each do |file|
  require file
end
