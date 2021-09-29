require 'json'

class NagerService
  def get_info(url)
    response = Faraday.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def holidays
    get_info("https://date.nager.at/api/v3/NextPublicHolidays/US")
  end
end
