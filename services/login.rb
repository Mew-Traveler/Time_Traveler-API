class LogIn
  extend Dry::Monads::Either::Mixin

  def self.call(params)
    if (userInfo = User.find(userEmail: params[:userEmail])).nil?
      Left(Error.new(:not_found, '#{params[:userEmail]} not found'))
    else
      Right(userInfo)
    end
  end
end