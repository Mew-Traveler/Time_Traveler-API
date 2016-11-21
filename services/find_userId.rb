# frozen_string_literal: true

# Loads data from Facebook group to database
class FindUserId
  extend Dry::Monads::Either::Mixin

  def self.call(params)
    keyword = params[:userEmail].gsub(/\+/, ' ')
    if (userId = User.find(userEmail: keyword).id).nil?
      Left(Error.new(:not_found, "User #{params[:keyword]} could not be found"))
    else
      Right(userId.to_s)
    end
  end
end
