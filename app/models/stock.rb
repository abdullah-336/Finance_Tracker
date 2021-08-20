class Stock < ApplicationRecord
    has_many :user_stockings
    has_many :users, through: :user_stockings
    validates :name, :ticket, presence:true
    def self.new_lookup(ticket_symbol)
        client = IEX::Api::Client.new(
            publishable_token: Rails.application.credentials.iex_client[:publishable_key],
            secret_token: Rails.application.credentials.iex_client[:secret_access_key],
            endpoint: 'https://sandbox.iexapis.com/v1')
        begin
            new(ticket:ticket_symbol,name:client.company(ticket_symbol).company_name,last_price:client.price(ticket_symbol))
        rescue => exception
            return nil
        end    
    end    

    def self.check_db(ticket_symbol)
        where(ticket: ticket_symbol).first
    end








    # def self.find_by_ticket(ticket_symbol)
    #     where(ticket: ticket_symbol).first
    #   end
    # def self.new_from_lookup(ticker_symbol)
    #     begin
    #         looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
    #         price = strip_commas(looked_up_stock.l)
    #         new(name: looked_up_stock.name, ticker: looked_up_stock.symbol, last_price: price)
    #     rescue Exception => e
    #         return nil
    #     end
    # end
    
    # def self.strip_commas(number)
    #     number.gsub(",", "")
    # end
    #   def self.new_from_lookup(ticket_symbol)
    #     looked_up_stock = StockQuote::Stock.quote(ticket_symbol)
    #     return nil unless looked_up_stock.name
        
    #     new_stock = new(ticket: looked_up_stock.symbol, name: looked_up_stock.name)
    #     new_stock.last_price = new_stock.price
    #     new_stock
    #   end
      
    #   def price
    #     closing_price = StockQuote::Stock.quote(ticket).close
    #     return "#{closing_price} (Closing)" if closing_price
        
    #     opening_price = StockQuote::Stock.quote(ticket).open
    #     return "#{opening_price} (Opening)" if opening_price
    #     'Unavailable'
    #   end
     end
