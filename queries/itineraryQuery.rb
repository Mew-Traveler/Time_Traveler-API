
# frozen_string_literal: true

# Search query for itinerary by keywords
class ItineraryQuery
  def self.call(userId)
    search_project(userId)
  end

  private_class_method

  def self.search_project(userId)
    Project.where(userId: userId).all
  end

end