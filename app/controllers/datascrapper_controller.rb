class DatascrapperController < ApplicationController
  include DatascrapperHelper

  def get_items

    main_url = params['input_url']
    puts "RECEIVED URL"+main_url

    #sets url in helper methos to be available to view
    url_to_scrap(main_url)

    puts " ENTERING GET ITEMS CODE THROUGH NOKOGIRI ----------------"

    #Browsing through nokogiri and http from helper method data scrappe
    scrapped_nokogiri_data = data_scraper(main_url)
    puts "==================================="

    #if data found good
    filtered_scrapped_data=get_filtered_scrapped_data(scrapped_nokogiri_data)
    puts filtered_scrapped_data
    if filtered_scrapped_data[1]==true
      @scrapped_data=filtered_scrapped_data
    else                                    #else try with Watir #OPEN BROWSER
      puts "------SCRAPPING DATA BY METHOD # 2---------"
      @scrapped_data=open_browser(main_url)
    end


  end




end

#dummy methods for reference

# browser = Watir::Browser.start url2
#  for i in 1..20
#      l = browser.link :text => "#{i}"
#      l.exists?
#      l.click
#      open("page_#{i}.html", "w"){ |f| f.puts browser.html }
#      sleep 2
#  end


# def get_items
#   puts "I am inside"

#     base_url = ''
#     main_url = "#{base_url}/"
#     data = data_scraper(main_url)
#     all_sections = data.css('table > tr > td > table > tr > td:nth-child(3) > table > tr')
#     sections = all_sections.slice(2..all_sections.length)
#     return "hello"
# end

# def data_scraper(url)
#     Nokogiri::HTML(open(url))
# end


# date, role, url, company, array_of_items = '', '', '', '', []
# puts all_sections.length.to_s
# sections = all_sections.slice(2..all_sections.length)
# puts sections.to_s

#  data = data_scraper(main_url)
# all_sections = data.css('table > tr > td > table > tr > td:nth-child(3) > table > tr')
#puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
#puts data.to_s
# all_sections = data.css('h3 ul li')

# sections.each_with_index do |section, section_index|
#     puts "SECTION:"+section
#     puts "SECTION INDEX:"+section_index.to_s
#     puts "XXXXXXXXXXXXXXXXXXXXXXXXXX"

#     if section_index % 3 == 0
#         # date = section.text
#     elsif section_index % 3 == 1
#         section.css('font').each_with_index do |item, item_index|
#         #  puts "MY ITEM INDEX :"+item_index.to_s
#             if item_index % 3 == 0
#                 # role = item.text.strip
#                 # # puts "--------------------------"
#                 # # puts "MY ROLE:"+role
#                 # # puts "--------------------------"
#                 # #url = "#{base_url}#{item.at_css('a')['href']}"
#             elsif item_index % 3 == 1
#                 # company = item.text.strip
#                 # array_of_item << {
#                 #     date: date,
#                 #     role: role,
#                 #     url: url,
#                 #     company: company
#                 #}
#             end
#         end
#     end
#   end