module DatascrapperHelper

  #these methods are visible to both views and controllers

  def data_scraper(my_url)
    Nokogiri::HTML(open(my_url))
  end

  def html_scraper(my_html)
    Nokogiri::HTML.parse(my_html)
  end

  def url_to_scrap(my_url)
    #puts "Display main URL ------------- > "+ my_url
    return my_url
  end



  def get_filtered_scrapped_data(data_from_nokogiri)


    # data_class=data_from_nokogiri.class
    # data_filtered_by_css=data_from_nokogiri.css('body')
    # data_filtered_by_css_mapped=data_from_nokogiri.css('body').map(&:text)
    #
    # puts "==================================="
    # # puts data_class
    # # puts data_filtered_by_css.length   # => 6
    # # puts data_filtered_by_css
    # # puts data_filtered_by_css_mapped
    # puts "============FILTERED DATA START======================="
    #
    # data_filtered_by_script_to_text = data_from_nokogiri.at('script').text
    # data_filtered_by_script_limit=data_from_nokogiri.search('script')[1]
    # data_filtered_by_script_count=data_from_nokogiri.search("//script[not(@hidden)]").count
    #
    # #The content generated by react is not visible
    # puts "==================================="
    # # puts data_filtered_by_script_to_text
    # # puts data_filtered_by_script_limit
    # # puts data_filtered_by_script_count
    # puts "===============FILTERED DATA ENDS====================="

    # links=data_from_nokogiri.css('div.wrapper > div.merchant-content-container')
    required_result=data_from_nokogiri.css('html body div > div.merchant-content-container')
    # puts required_result.map(&:text)
    puts required_result.count #should be 9 for that page
    #puts "=============PROGRAM EXITING AFTER SCRAPPING======================="



    if (required_result.count >=8)
      puts "============== REQUIRED RESULT ========================="
        @filtered_result=required_result.to_yaml
        return [true,@filtered_result]
    else
      puts "=================== NO ITEMS FOUND BY THIS METHOD ========================="
        @filtered_result="XXXXXXXXXXX - NO ITEMS FOUND BY THIS METHOD -XXXXXXXXXXXXX"
        return [false,@filtered_result]
    end


  end


  def open_browser(url2open)


    puts "********* ENTERED WATIR OPENING CODE ***********"

    # Specify the driver path
    chromedriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)),"browsers","chromedriver.exe")
    puts chromedriver_path
    Selenium::WebDriver::Service.driver_path = chromedriver_path

    #start_browser
    begin
      browser = Watir::Browser.start url2open
      search_content(browser)
    rescue Timeout::Error => e #catch the Exception
      puts "Page did not load: #{e}"
      # program continues from here
    end



  end

  def search_content(browser_data_received)

    # #search the div with menu category
    # browser_data_received.element(css: ".merchant-offers .merchant-menu-category").wait_until(&:present?)
    #
    # #two ways finding
    # js_rendered_content = browser_data_received.element(css: ".merchant-offers .merchant-menu-category")
    # puts "------------------------------------------"
    # puts js_rendered_content.to_yaml #xx
    # puts "------------------------------------------"



    rendered_content=browser_data_received.elements(:class=>"merchant-menu-category")
    rendered_content_first=browser_data_received.elements(:class=>"merchant-menu-category").first.html
    rendered_content_size=browser_data_received.elements(:class=>"merchant-menu-category").size


    puts "**********************CONTENT***********************"
    puts rendered_content
    puts "*******************SIZE*****************************"
    puts rendered_content_size
    puts "******************FIRST ELEMENT*********************"
    puts rendered_content_first
    # puts "******************TO YAML*************************"
    # puts rendered_content.to_yaml
    puts "****************************************************"

    return rendered_content

  #   if (rendered_content_size >=9 && rendered_content_size==0 && rendered_content_first.present?)
  #     return rendered_content
  #   else
  #     rendered_content==0
  #     return rendered_content
  #   end
  #
  #   array_of_items=[]
  #   puts "LISTING HTML OF OUR REQUIRED ELEMENTS"
  #   rendered_content.each_with_index do |section, section_index|
  #
  #
  #     puts "SECTION INDEX:"+section_index.to_s
  #     puts "SECTION:"+section.text
  #
  #     puts "\n"
  #
  #     array_of_items << {
  #         item: section.text
  #     }
  #
  #   end
  #
  #   #puts "DRIVER LOADED"
  #   #browser.goto home_path
  #   # browser.goto url2
  #   # browser.element(tag_name: 'section')
  #   # browser.div(:class => "ClassicMerchantOffers").should exist
  #   #js_rendered_content.link.click
  #   puts "*****************LAST YAML PRINTING*******************"
  #   array_of_items
    end

end
