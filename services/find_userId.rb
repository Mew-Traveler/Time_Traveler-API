# frozen_string_literal: true

# Loads data from Facebook group to database
class FindUserId
  extend Dry::Monads::Either::Mixin

  def self.call(params)
    keyword = params[:userEmail].gsub(/\+/, ' ')
    if (userId = User.find(userEmail: keyword)).nil?
      Left(Error.new(:not_found, "User #{keyword} could not be found"))
    else
      Right(userId.id.to_s)
    end
  end
end
