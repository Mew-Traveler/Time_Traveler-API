# frozen_string_literal: true

# Loads data from Facebook group to database
class FindDaily
  extend Dry::Monads::Either::Mixin

  def self.call(params)
    puts params
    projectId = params[:projectId]
    day = params[:day]
    dailyplandata= Dailyplan.find(projectId:projectId, nthday:day)
      roomId = dailyplandata.roomId if dailyplandata.roomId
      timeRemain = dailyplandata.timeRemain if dailyplandata.timeRemain
      locateEnd = dailyplandata.locateEnd if dailyplandata.locateEnd
      locateStart = dailyplandata.locateStart if dailyplandata.locateStart
      timeEnd = dailyplandata.timeEnd if dailyplandata.timeEnd
      timeStart = dailyplandata.timeStart if dailyplandata.timeStart
      date = dailyplandata.date if dailyplandata.date
      dailyplandata.to_json
      {
         id: dailyplandata.id,  roomId: roomId, nthday: day, date: date, timeStart: timeStart,
         timeEnd: timeEnd, locateStart: timeStart, locateEnd: locateEnd , timeRemain: timeRemain, projectId: projectId
      }
    
    if projectinfo.nil?
      Left(Error.new(:not_found, "No Information for"))
    else
      Right(projectinfo)
    end
  end
end
