class DatascrapperController < ApplicationController
  include DatascrapperHelper

  def get_items

    main_url = params['input_url']
    puts "------ RECEIVED URL ---->  "+main_url

    #sets url in helper methos to be available to view
    url_to_scrap(main_url)

    puts "----------------------- ENTERING GET ITEMS CODE THROUGH NOKOGIRI  ------------------------"

    #Browsing through nokogiri and http from helper method data scrapper
    scrapped_nokogiri_data = data_scraper(main_url)

    #if data found good
    filtered_scrapped_data=get_filtered_scrapped_data(scrapped_nokogiri_data)

    #puts filtered_scrapped_data
    if filtered_scrapped_data[1]==true #data found/assign it

      @scrapped_data=filtered_scrapped_data

    else  #else try with Watir #OPEN BROWSER


      puts "------SCRAPPING DATA BY METHOD # 2---------"
      raw_scrapped_data=open_browser(main_url) #returns the page raw scrapped data

      #----------------------------------------------------------------------------------------------
      if (raw_scrapped_data.size >=8 && raw_scrapped_data.size!=0 && raw_scrapped_data.first.present?)

        item_tile_category_index, item_category_name, item_name, item_description, item_avail, item_price=''
        array_of_items=[]
        html_array_of_items=[]
        array_of_items_2=[]
        puts "LISTING HTML OF OUR REQUIRED ELEMENTS"

        raw_scrapped_data.each_with_index do |section, section_index|

          puts "SECTION INDEX:"+section_index.to_s
          puts "SECTION:"+section.text
          puts "SECTION HTML"+ section.html

          document = html_scraper(section.html) #using nokogiri

          puts "HTML SCRAPPER ELEMENTS FOUND ==>"+ document.css('ul li').count.to_s


          # result = document.css('ul li') do |all, row|
          merchant_menu_category=document.css("h3.merchant-menu-category_header").first
          puts "MERCHANT MENU CATEGORY ====> " + merchant_menu_category.text

          document.css("ul li").each do |result|

            # puts result.css("h4.offer-tile_name").text
            array_of_items_2 <<
                {
                    item_category: merchant_menu_category.text,
                    item_name: result.css("h4.offer-tile_name").text,
                    item_description: result.css("p.offer-tile_description").text,
                    item_avail: result.css("p.offer-tile_disclaimer").text,
                    item_price: result.css("span.offer-tile_price").text
                }
          end

          puts "\n"

          #Organised index with data each large category
          array_of_items << {
              item_id: section_index,
              item: section.text
          }

          #htm data with auto generated index of whole html
          html_array_of_items << section.html




        end

        #main data
        #Food_Items_Contoller with model created will be used to save data to tables and could be used further
        @scrapped_data_html=html_array_of_items
        @scrapped_data=array_of_items
        @scrapped_data_items=array_of_items_2




      else
        puts "*****************NO RESULTS FOUND FOR METHOD 2*******************"
        @scrapped_data= "NO RESULTS FOUND FOR THIS METHOD"

      end


      #-----------------------------------------------------------------------------------------------------


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
#
#
# #Load data
#        #puts "DRIVER LOADED"
#         #browser.goto home_path
#         # browser.goto url2
#         # browser.element(tag_name: 'section')
#         # browser.div(:class => "ClassicMerchantOffers").should exist
#         #js_rendered_content.link.click