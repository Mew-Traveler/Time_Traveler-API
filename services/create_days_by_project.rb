# frozen_string_literal: true

# Create new day
class CreateDaysByProject
  require 'date'

  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :validate_request_json, lambda { |request_body|
    begin
      data = { project_id: request_body['project_id'],
               dateStart: request_body['dateStart'],
               dateEnd: request_body['dateEnd']
             }
      Right(data)
    rescue
      Left(Error.new(:bad_request, 'request data error'))
    end
  }

  register :create_days, lambda { |data|
    # t = cal_days(data[:dateStart], data[:dateEnd])
    t = (Date.parse(data[:dateEnd])- Date.parse(data[:dateStart])).to_i

    d = data[:dateStart]
    for i in 1..t
      day_info = { project_id: data[:project_id],
                   nthday: i.to_s,
                   date: d
                 }
      d = (Date.parse(d)+1).to_s
      puts "dddddd"
      puts d
      create_day(day_info)
      # d = next_date(d)
      # d = date_of_next(Date.parse(data[:dateStart]))
      # d = Date.parse(d).next_day(1)
    end
    Right(data)
  }



  def self.call(params)
    Dry.Transaction(container: self) do
      step :validate_request_json
      step :create_days
    end.call(params)
  end

  private_class_method

  def self.cal_days(date1, date2)
    m1 = date1.split('/')[0].to_i
    d1 = date1.split('/')[1].to_i
    m2 = date2.split('/')[0].to_i
    d2 = date2.split('/')[1].to_i

    if (m2 == m1)
      result = d2 - d1 + 1
    else
      result = (30 - d1 + 1) + d2 + (m2 - m1 - 1) * 30
    end

    return result
  end

  def self.next_date(date)
    m = date.split('/')[0].to_i
    d = date.split('/')[1].to_i

    if(d == 30)
      d = 1
      m = m + 1
    else
      d = d + 1
    end

    return m.to_s + "/" + d.to_s
  end

  def self.date_of_next(day)
    d = Date.parse(day).to_i


    # delta = date > Date.today ? 0 : 7
    # d = Date.strptime(day, '%Y%Y%Y%Y-%M%M-%D%D %H%H:%m%m')
    # d = Date.parse(day)
    #
    # w = d.wday                       #=> 6

  end

  def self.create_day(day_info)
    CreateNewDay.call(JSON.parse day_info.to_json)
  end

end
