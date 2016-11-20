# frozen_string_literal: true

# Search query for profile by keywords
class ItineraryQuery
  def self.call(userEmail)
    search_project(userEmail)
  end

  private_class_method

  def self.search_project(userEmail)
    User.where(userEmail: userEmail)
  end

end