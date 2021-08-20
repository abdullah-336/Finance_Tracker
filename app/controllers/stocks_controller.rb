class StocksController < ApplicationController
    def search

        if params[:stock].present?
            @stock= Stock.new_lookup(params[:stock])
            if @stock
                render 'stock_users/my_portfolio'
            else
                flash[:alert]="Please Enter a Valid Company Name to Search"
                redirect_to my_portfolio_path
            end
        else
            flash[:alert]="Please Enter a Company to Search"
            redirect_to my_portfolio_path
        end
    end
 
end